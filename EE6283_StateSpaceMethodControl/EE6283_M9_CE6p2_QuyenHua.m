% EE6283
% Quyen Hua
% M9
% CE6.2
% 
% using Lyapunov Analsis, assess the stability prorperties of the CE2 System;
% any case will do - because the A matrix is identical for all input output
% cases. Should Lyapunov analysis not succeed, use Eigenvalue analysis.
% Plot phase portraits to reinforce your results.

clear all

% % let Q = I4 for Lyapunov Analysis
Q = eye(4);
C = [1 0 0 0];
D = [0];
% Recall from earlier submissions that with initial conditions (theta) = 0
% A = 0 1 0 0
%     0 0 y z 
%     0 0 0 1
%     0 0 h k

% with
% y = (g*m2/m1)
% z = 0
% h =g*(m1+m2)/(m1*L)
% k = 0
% when evaluated at with initial condition zero

% Case ia; Zero initial state, unit impulse force F(t)
L = 0.75;
m1 = 2;
m2 = 1;
x1 = 0; %cart position
x2 = 0; %cart velocity
x3 = 0; %beam angle
x4 = 0; %beam angle radial velocity
u1 = 1; %applied force (unit impulse)
u2 = 0; %torque // not used in case ia
g = 9.81;

y1a = (g*m2/m1);
h1b =g*(m1+m2)/(m1*L);

A1a = [0 1 0 0; 0 0 y1a 0; 0 0 0 1; 0 0 h1b 0];
B1a = [0; 1/(m1+m2-m2*cos(x3)^2); 0; cos(x3)/(L*m1+L*m2-L*m2*cos(x3)^2)];


% 
% P1a = lyap(A1a',Q);
% 
% if (det(P1a) > 0)
%     disp('System is stable by Lyapunav Test because determinant of P is positibe');
% else
%     disp('System is not stable by Lyapunav Test');
% end    

z1a = eig(A1a);

if real(max(z1a)) > 0
    disp('System (IC theta=0) is not stable by eigenvalue test')
elseif real(max(z1a)) == 0
    disp('System (IC theta=0) is marginally stable by eigenvalue test')
else
    disp('System (IC theta=0) is stable by eigenvalue test')
end

x0 = [10; 10; 10; 10];
s1b = ss(A1a,B1a,C,D);
[y, t, x1b] = initial(s1b,x0);
figure;
plot(x1b(:,2),x1b(:,1))
title('Phase portrait of x2 vs x1 of CE6.2, theta = 0')
figure;
plot(x1b(:,4),x1b(:,3))
title('Phase portrait of x4 vs x3 of CE6.2, theta = 0')
% % % % % % % % % % 
% % % % % % % % % % 
    
% % 
% Recall from earlier submissions that with initial conditions (theta) =
% pi
% A = 0 1 0 0
%     0 0 y z 
%     0 0 0 1
%     0 0 -h k

% with
% y = (g*m2/m1)
% z = 0
% h =g*(m1+m2)/(m1*L)
% k = 0
% when evaluated at with initial condition zero

% Case ia; Zero initial state, unit impulse force F(t)
L = 0.75;
m1 = 2;
m2 = 1;
x1 = 0; %cart position
x2 = 0; %cart velocity
x3 = pi; %beam angle
x4 = 0; %beam angle radial velocity
u1 = 1; %applied force (unit impulse)
u2 = 0; %torque // not used in case ia
g = 9.81;

y1b = (g*m2/m1);
h1b =g*(m1+m2)/(m1*L);

A1b = [0 1 0 0; 0 0 y1b 0; 0 0 0 1; 0 0 -h1b 0];
B1b = [0; 1/(m1+m2-m2*cos(x3)^2); 0; cos(x3)/(L*m1+L*m2-L*m2*cos(x3)^2)];




% P1b = lyap(A1b',Q);
% 
% if (det(P1b) > 0)
%     disp('System is stable by Lyapunav Test because determinant of P is positibe');
% else
%     disp('System is not stable by Lyapunav Test');
% end    

z1b = eig(A1b);

if real(max(z1b)) > 0
    disp('System (IC theta=pi) is not stable by eigenvalue test')
elseif real(max(z1b)) == 0
    disp('System (IC theta=pi) is marginally stable by eigenvalue test')
else
    disp('System (IC theta=pi) is stable by eigenvalue test')
end

s1b = ss(A1b,B1b,C,D);
[y, t, x1b] = initial(s1b,x0);
figure;
plot(x1b(:,2),x1b(:,1))
title('Phase portrait of x2 vs x1 of CE6.2, theta = pi')
figure;
plot(x1b(:,4),x1b(:,3))
title('Phase portrait of x4 vs x3 of CE6.2, theta = pi')