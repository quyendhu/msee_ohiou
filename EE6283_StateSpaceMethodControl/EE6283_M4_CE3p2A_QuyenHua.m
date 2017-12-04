% % Quyen Hua
% % EE6283
% % M4
% % CE3.2A
% % 
% % Compute the controllability of system given by CE1.2 with values from
% % CE2.2A

%% Evaluated at equilibrium condition of 0

clear all
% define all variables
syms m1 m2 L x1 x2 x3 x4 u1 u2 g

a = [ (m1+m2) (-m2*L*cos(x3)); (-m2*L*cos(x3)) m2*L^2];

b=[-m2*L*sin(x3)*x4^2+u1; m2*g*L*sin(x3)+u2];

% solve for second derivatives
c=(a^-1)*b;

% establish f(x1,x2,x3,x4,u1,u2)
f = [ x2; c(1); x4; c(2)] ;

disp('f(x1,x2,x3,x4,u1,u2) = ')
pretty(f);

% get partial derivatives
A1 = diff(f, x1);
A2 = diff(f, x2);
A3 = diff(f, x3);
A4 = diff(f, x4);

A = [A1 A2 A3 A4];

disp('A(t) = ')
pretty(A);

B1 = diff(f, u1);
B2 = diff(f, u2);

B = [B1 B2]

disp('B(t) = ')
pretty(B)

disp('____________________________________________')
disp('P = B BA BA^2 BA^3')

P = [B A*B (A^2)*B (A^3)*B];

disp('The following equation will calculate P with given values from textbook')
PFunction = matlabFunction(P)

L_val = 0.75;
m1_val = 2;
m2_val = 1;
x1_val = 1; %cart position
x2_val = 0; %cart velocity
x3_val = 0.1; %beam angle
x4_val = 0; %beam angle radial velocity
u1_val = 0; %applied force
u2_val = 0; %torque
g_val = 9.81;

calcP = PFunction(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);

disp('Observing the RREF form of P, we see that RREF(P) =')
disp(rref(calcP));
disp('which has Rank:')
disp(rank(calcP))



