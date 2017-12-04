% Quyen Hua
% EE5853
% M13, Project, Function, Task2, ILS

function [ EstPos, Residuals, H] = EE5853_M13_Proj_T2_ILS( PR, ECEF )
%EE5853_M13_PROJ_T2_ILS Summary of this function goes here
%     PR = [Nx1] pseudoranges, for example from L1PSR
%     SatECEF = [3xN] sat positions in ECEF, for example from SatBC.ECEF

%     EstPos = estimated user position in ECEF
%     Residuals = size of residual from iterative least squares method
%     H = System Matrix H for lesat squares solution

%  note that PR = sqrt( (xu-x1)^2 + (yu-y1)^2 + (zu-z1)^2 ) + c*deltaT



counter = 0; % basic counter. might be useful.
% res_threshold = 1e-8; %set threshold for residual as we may never get to zero residual

%set initial estimated user position to origin in ECEF frame
EstPos = [0;0;0;0]; %[x;y;z;deltaT]
Residuals = 1; %need an initial value for Residuals too...

%establish an initial H matrix. note that column 4 will be all 1 according
%to slide 11 of lecture notes
H = [zeros(length(PR),3) ones(length(PR),1)];

while counter < 10 %Residuals > res_threshold
    %iterating
    
    %fill in the H matrix...
    
    %estimated PR will change each iteration. Need a placeholder
    ranges = zeros(length(PR),1);
    
    for i = 1:1:length(PR)
        %for each satellite, fill in the needed stuff in the H matrix
        %R = range from satellite to estimated user position
        Rx = EstPos(1) - ECEF(1,i);
        Ry = EstPos(2) - ECEF(2,i);
        Rz = EstPos(3) - ECEF(3,i);
        R  = sqrt(Rx^2+Ry^2+Rz^2);
        for j = 1:1:3 %only go up to z...
            %fill in the x,y,z columns in the H matrix
            % formula is generally, xu-x1/R
            H(i,j) = (EstPos(j) - ECEF(j,i))/R;
        end
        
        ranges(i) = R;
    end
    
    
    
    Residuals = PR - ranges;%what is the residual in this case?
    
    temp = EstPos + inv(H'*H)*H'*Residuals;%apply least squares solution
    
%     Residual = norm(EstPos - temp)
    
    EstPos = temp; %update estimated position
    
   
    %and keep count of iterations
    counter = counter + 1;
%     disp(counter)
end

end % end function

