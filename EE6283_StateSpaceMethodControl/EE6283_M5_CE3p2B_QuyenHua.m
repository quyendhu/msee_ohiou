% % Quyen Hua
% % EE6283
% % M5
% % CE3.2B
% % 
% % Compute the Controller Canonical Form
% % of system given by CE1.2 with values from CE2.2A

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

% disp('B(t) = ')
% pretty(B)

disp('____________________________________________')
% disp('P = B BA BA^2 BA^3')

% P = [B A*B (A^2)*B (A^3)*B];

% disp('The following equation will calculate P with given values from textbook')
% PFunction = matlabFunction(P)

% Zero initial state, unit impulse force F(t)
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

% calculate A, B, and P from values above
Asym = matlabFunction(A); 
A_calc = Asym(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);
disp('using values given in text, A = ')
disp(A_calc)

Bsym = matlabFunction(B);
B_calc = Bsym(L_val, m1_val,m2_val,x3_val);
disp('using values given in text, B = ')
disp(B_calc)

Psym = matlabFunction([ B(:,1) A* B(:,1) (A^2)* B(:,1) (A^3)* B(:,1)]);
P_calc = Psym(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val);

% identify the characteristic polynomial of A
disp('The following are values of the characteristic polynomial of A at zero condition and unit impulse f(t)')
charPA = matlabFunction(charpoly(A));
A_poly = charPA(L_val, g_val, m1_val, m2_val, u1_val, u2_val, x3_val, x4_val)

a1 = A_poly(4);
a2 = A_poly(3);
a3 = A_poly(2);

pp = [a1 a2 a3 1; a2 a3 1 0; a3 1 0 0; 1 0 0 0];
disp('Calculate Tccf using P*Pccf')
disp('P = ')
disp(P_calc)
disp('Pccf = ')
disp(pp)
disp('Tccf = ')
Tccf = P_calc*pp;
disp(Tccf)


Accf = inv(Tccf)*A_calc*Tccf
Bccf = inv(Tccf)*B_calc
Cccf = [1 0 0 0]*Tccf %refer to M2 CE1.2 exercise for value of C


disp('I am not quite sure how to describe these calculations. I believe that')
disp(' using torque force of 0 implies in our previous calculations that')
disp(' the differential calculations and matrices correct themselves to')
disp(' reflect a single input single output system')
disp('Additionally, according to MATLABs rank function, this system is still')
disp(' contollable. The text introduces the traditional single input system')
disp(' as uncontrollable. I am a bit confused by this and must dwell on it.')