% EE6283
% M9
% CME6p4
% QuyenHua
% 
% For the system in CME1.4,
% A- assess the system stability using lyapunov analysis
%     compare with eigenvalue analysis
% B- Plot phase portraits to reinforce results

% % Recall CME1.4
% % [x1dot; x2dot; x3dot; x4dot] = ...
% %     [0 1 0 0; 0 0 1 0; 0 0 0 1; -962 -126 -67 -4]x + [0; 0; 0; 1]u
% % B = [0; 0; 0; 1];
% % C = [100 20 10 0];
% % D = 0;
clear all

A = [0 1 0 0; 0 0 1 0; 0 0 0 1; -962 -126 -67 -4];
B = [0; 0; 0; 1];
C = [100 20 10 0];
D = [0];

z = eig(A);

if real(z) > 0
    disp('System is not stable by eigenvalue test')
elseif real(z) == 0
    disp('System is marginally stable by eigenvalue test')
else
    disp('System is stable by eigenvalue test')
end

% % let Q = I4
Q = eye(4);

P = lyap(A',Q);

if (det(P) > 0)
    disp('System is stable by Lyapunav Test because determinant of P is positibe');
else
    disp('System is not stable by Lyapunav Test');
end    
    
x0 = [10; 10; 10; 10];
s = ss(A,B,C,D);
[y, t, x] = initial(s,x0);

figure;
plot(x(:,2),x(:,1))
title('Phase portrait of x2 vs x1 of CME6.4B')

figure;
plot(x(:,4),x(:,3))
title('Phase portrait of x4 vs x3 of CME6.4B')