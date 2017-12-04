% Quyen Hua
% EE5853
% M11
% 
% Loran-C Hyperbolic Positioning
% 
% Assumptions:
% - World is flat and 2D
% - radio signals propagate in a straight line and at constant velocity 3e8m/s

clear all
close all

%signal propagation velocity
c = 3e8; %m/s

%Loran-C Stations:
s7139m = [0 0]*1e3; %(y, x) coordinates in km
s7139y = [0 1000]*1e3;
EDy = 13000e-6; %emission delay, seconds
s7139z = [800 300]*1e3;
EDz = 29000e-6;

%time difference measurements:
TDym = 13735e-6; %seconds
TDzm = 27610e-6;

%% Task 3 Solve hyperbolic position using Iterative Least Square

%establish user position estimate
xu = 300000;
yu = 500000; %use center of all three for now...

%assume the following when establishing the rest of the script
% let:
% x1,y1 be master's position
% x2,y2 be y station
% x3,y3 be z station
% R1 be estimated range from user to master
% R2 be the estimated range from user to y
% R3 be the estimated range from user to z

res1 = [TDym-EDy;TDzm-EDz]*c;

xu_i = xu;
yu_i = yu;

temp = [xu_i;yu_i];

%try 50 times just to see what happens...

for i = 1:1:50    

    R1 = sqrt((xu-s7139m(2))^2+(yu-s7139m(1))^2);
    R2 = sqrt((xu-s7139y(2))^2+(yu-s7139y(1))^2);
    R3 = sqrt((xu-s7139z(2))^2+(yu-s7139z(1))^2);

    H11 = (xu-s7139y(2))/R2 - (xu-s7139m(2))/R1;
    H12 = (yu-s7139y(1))/R2 - (xu-s7139m(1))/R1;
    H21 = (xu-s7139z(2))/R3 - (xu-s7139m(2))/R1;
    H22 = (yu-s7139z(1))/R3 - (xu-s7139m(1))/R1;

    H = [H11, H12; H21, H22];

    res2 = [R2-R1;R3-R1];



    temp = [xu;yu] + inv(H'*H)*H'*(res1-res2)
    res1-res2;
    xu = temp(1,1);
    yu = temp(2,1);
end

disp('Residual is:')
disp(res1-res2)
disp('Which is very close to zero, this suggests that the ILS is very close to a good solution')
disp('User location is estimated to be (x,y) in meters:')
disp(temp)