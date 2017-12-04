% % Quyen Hua
% % EE6283
% % M6
% % CE4.2B
% % 
% % Compute the OCF of case i only
% % of system given by CE1.2 with values from CE2.2A
% % Demonstrate duality relationship between CCF and OCF

%% Evaluated at equilibrium condition of 0
clc
clear all
% define all variables
syms m1 m2 L x1 x2 x3 x4 u1 u2 g

a = [ (m1+m2) (-m2*L*cos(x3)); (-m2*L*cos(x3)) m2*L^2];

b=[-m2*L*sin(x3)*x4^2+u1; m2*g*L*sin(x3)+u2];

% solve for second derivatives
c=(a^-1)*b;

% establish f(x1,x2,x3,x4,u1,u2)
f = [ x2; c(1); x4; c(2)] ;

% % disp('f(x1,x2,x3,x4,u1,u2) = ')
% % pretty(f);

% get partial derivatives
A1 = diff(f, x1);
A2 = diff(f, x2);
A3 = diff(f, x3);
A4 = diff(f, x4);

A = [A1 A2 A3 A4];

% % disp('A(t) = ')
% % pretty(A);

B1 = diff(f, u1);
B2 = diff(f, u2);

B = [B1 B2];

% From CE1.2, state matrix C = 

C = [1 0 0 0; 0 0 1 0];

disp('____________________________________________')

disp('for a 4 x 4 state matrix A')
disp('Q = [C; CA; CA^2; CA^3]')

% % % 
% % % 
% % % 

% Case ia; Zero initial state, unit impulse force F(t)
L_val = 0.75;
m1_val = 2;
m2_val = 1;
x1_val = 0; %cart position
x2_val = 0; %cart velocity
x3_val = 0; %beam angle
x4_val = 0; %beam angle radial velocity
u1_val = 1; %applied force (unit impulse)
u2_val = 0; %torque
g_val = 9.81;

Asym = matlabFunction(A); 
A_calc = Asym(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);
disp('using values given in text, case (i)a, A = ')
disp(A_calc)

disp('C = ')
disp(C)

Q = [C(1,:); C(1,:)*A; C(1,:)*A^2; C(1,:)*A^3];

qfunia = matlabFunction(Q);

Qia = qfunia(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);

disp('And we have Q = ')
disp(Qia)
disp('which has determinant =')
disp(det(Qia))
disp('Which is nonzero, and therefore the case ia is observable')

% % % 
% % % 
% % % 

% case ib; Zero input f(t), initial condition theta(t) = 0.1
L_val = 0.75;
m1_val = 2;
m2_val = 1;
x1_val = 0; %cart position
x2_val = 0; %cart velocity
x3_val = 0.1; %beam angle
x4_val = 0; %beam angle radial velocity
u1_val = 0; %applied force (unit impulse)
u2_val = 0; %torque
g_val = 9.81;


Asym = matlabFunction(A); 
A_calc = Asym(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);
disp('using values given in text, case (i)b, A = ')
disp(A_calc)

disp('C = ')
disp(C)

Q = [C(1,:); C(1,:)*A; C(1,:)*A^2; C(1,:)*A^3];
qfunib = matlabFunction(Q);

Qib = qfunib(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);

disp('And we have Q = ')
disp(Qib)
disp('which has determinant =')
disp(det(Qib))
disp('Which is nonzero, and therefore the case ib is observable')

% % % 
% % % 
% % % 

% case ii; inpulse input f(t), initial condition theta(t) = w(t) = 0
L_val = 0.75;
m1_val = 2;
m2_val = 1;
x1_val = 0; %cart position
x2_val = 0; %cart velocity
x3_val = 0; %beam angle
x4_val = 0; %beam angle radial velocity
u1_val = 1; %applied force (unit impulse)
u2_val = 0; %torque
g_val = 9.81;


Asym = matlabFunction(A); 
A_calc = Asym(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);
disp('using values given in text, case ii, A = ')
disp(A_calc)

disp('C = ')
disp(C)

Q = [C(1,:); C(1,:)*A; C(1,:)*A^2; C(1,:)*A^3];
qfunib = matlabFunction(Q);

Qii = qfunib(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);

disp('And we have Q = ')
disp(Qii)
disp('which has determinant =')
disp(det(Qii))
disp('Which is nonzero, and therefore the case ii is observable')

% % % 
% % % 
% % % 

% case iii; inpulse input f(t) and tau(t), initial condition theta(t) = w(t) = 0
L_val = 0.75;
m1_val = 2;
m2_val = 1;
x1_val = 0; %cart position
x2_val = 0; %cart velocity
x3_val = 0; %beam angle
x4_val = 0; %beam angle radial velocity
u1_val = 1; %applied force (unit impulse)
u2_val = 1; %torque
g_val = 9.81;


Asym = matlabFunction(A); 
A_calc = Asym(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);
disp('using values given in text, case iii, A = ')
disp(A_calc)

disp('C = ')
disp(C)

Q = [C; C*A; C*A^2; C*A^3];
qfunib = matlabFunction(Q);

Qiii = qfunib(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);

disp('And we have Q = ')
disp(Qiii)
disp('which has rank =')
disp(rank(Qiii))
disp('Which is equal to n from A, and therefore the case iii is observable')