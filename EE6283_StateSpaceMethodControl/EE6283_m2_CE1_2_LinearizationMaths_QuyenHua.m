

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


% define equilibrium as x1=x2=x3=x4=u1=u2=0
gtest = matlabFunction(A(4,3))
gtest(L,g,m1,m2,0,0,0,0)



