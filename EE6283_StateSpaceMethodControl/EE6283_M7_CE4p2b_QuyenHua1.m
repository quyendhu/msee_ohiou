% % Quyen Hua
% % EE6283
% % M7
% % CE4.2B
% % 
% % Compute the OCF of case i only
% % of system given by CE1.2 with values from CE2.2A
% % Demonstrate duality relationship between CCF and OCF

% % Recall from earlier submissions that for single input system
% B = [0; 1/(m1+m2-m2*cos(x3)^2); 0; cos(x3)/(L*m1+L*m2-L*m2*cos(x3)^2)]
C = [1 0 0 0];

% Recall from earlier submissions that with initial conditions = 0
% A = 0 1 0 0
%     0 0 y z 
%     0 0 0 1
%     0 0 h k
% 
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
h1a =g*(m1+m2)/(m1*L);

A1a = [0 1 0 0; 0 0 y1a 0; 0 0 0 1; 0 0 h1a 0];
B1a = [0; 1/(m1+m2-m2*cos(x3)^2); 0; cos(x3)/(L*m1+L*m2-L*m2*cos(x3)^2)];


aa = charpoly(A1a);
t1 = [aa(4) aa(3) aa(2) 1; aa(3) aa(2) 1 0; aa(2) 1 0 0; 1 0 0 0];
t2 = [C; C*A1a; C*A1a^2; C*A1a^3];

Tocf1a = inv(t1*t2);

Aocf1a = inv(Tocf1a)*A1a*Tocf1a
Bocf1a = inv(Tocf1a)*B1a
Cocf1a = C*Tocf1a

% Recall from earlier submissions that with initial conditions = 0 and
% x3(beam angle) = 0.1
% A = 0 1 0 0
%     0 0 y z 
%     0 0 0 1
%     0 0 h k
% 
% with
% y = (L*g*m2*cos(x3)^2)/(L*m1 + L*m2 - L*m2*cos(x3)^2) - (L*m2*x4^2*cos(x3))/(m1 + m2 - m2*cos(x3)^2) - (2*m2*cos(x3)*sin(x3)*(- L*m2*sin(x3)*x4^2 + u1))/(- m2*cos(x3)^2 + m1 + m2)^2 - (sin(x3)*(u2 + L*g*m2*sin(x3)))/(L*m1 + L*m2 - L*m2*cos(x3)^2) - (2*L*m2*cos(x3)^2*sin(x3)*(u2 + L*g*m2*sin(x3)))/(- L*m2*cos(x3)^2 + L*m1 + L*m2)^2
% z = 0
% h =(L*g*m2*cos(x3)*(m1 + m2))/(L^2*m2^2 - L^2*m2^2*cos(x3)^2 + L^2*m1*m2) - (L*m2*x4^2*cos(x3)^2)/(L*m1 + L*m2 - L*m2*cos(x3)^2) - (sin(x3)*(- L*m2*sin(x3)*x4^2 + u1))/(L*m1 + L*m2 - L*m2*cos(x3)^2) - (2*L*m2*cos(x3)^2*sin(x3)*(- L*m2*sin(x3)*x4^2 + u1))/(- L*m2*cos(x3)^2 + L*m1 + L*m2)^2 - (2*L^2*m2^2*cos(x3)*sin(x3)*(m1 + m2)*(u2 + L*g*m2*sin(x3)))/(- L^2*m2^2*cos(x3)^2 + L^2*m2^2 + m1*L^2*m2)^2
% k = 0
% when evaluated at with initial condition zero



% case ib; Zero input f(t), initial condition theta(t) = 0.1
L = 0.75;
m1 = 2;
m2 = 1;
x1 = 0; %cart position
x2 = 0; %cart velocity
x3 = 0.1; %beam angle
x4 = 0; %beam angle radial velocity
u1 = 0; %applied force (unit impulse)
u2 = 0; %torque // not used in case ia
g = 9.81;


y1b = (L*g*m2*cos(x3)^2)/(L*m1 + L*m2 - L*m2*cos(x3)^2) - (L*m2*x4^2*cos(x3))/(m1 + m2 - m2*cos(x3)^2) - (2*m2*cos(x3)*sin(x3)*(- L*m2*sin(x3)*x4^2 + u1))/(- m2*cos(x3)^2 + m1 + m2)^2 - (sin(x3)*(u2 + L*g*m2*sin(x3)))/(L*m1 + L*m2 - L*m2*cos(x3)^2) - (2*L*m2*cos(x3)^2*sin(x3)*(u2 + L*g*m2*sin(x3)))/(- L*m2*cos(x3)^2 + L*m1 + L*m2)^2;
h1b =(L*g*m2*cos(x3)*(m1 + m2))/(L^2*m2^2 - L^2*m2^2*cos(x3)^2 + L^2*m1*m2) - (L*m2*x4^2*cos(x3)^2)/(L*m1 + L*m2 - L*m2*cos(x3)^2) - (sin(x3)*(- L*m2*sin(x3)*x4^2 + u1))/(L*m1 + L*m2 - L*m2*cos(x3)^2) - (2*L*m2*cos(x3)^2*sin(x3)*(- L*m2*sin(x3)*x4^2 + u1))/(- L*m2*cos(x3)^2 + L*m1 + L*m2)^2 - (2*L^2*m2^2*cos(x3)*sin(x3)*(m1 + m2)*(u2 + L*g*m2*sin(x3)))/(- L^2*m2^2*cos(x3)^2 + L^2*m2^2 + m1*L^2*m2)^2;

A1b = [0 1 0 0; 0 0 y1b 0; 0 0 0 1; 0 0 h1b 0];
B1b = [0; 1/(m1+m2-m2*cos(x3)^2); 0; cos(x3)/(L*m1+L*m2-L*m2*cos(x3)^2)];

aa = charpoly(A1b);
t1 = [aa(4) aa(3) aa(2) 1; aa(3) aa(2) 1 0; aa(2) 1 0 0; 1 0 0 0];
t2 = [C; C*A1b; C*A1b^2; C*A1b^3];

Tocf1b = inv(t1*t2);

Aocf1b = inv(Tocf1b)*A1b*Tocf1b
Bocf1b = inv(Tocf1b)*B1b
Cocf1b = C*Tocf1b




% from previous homework exercise...
Tccf = [-6.5400         0    0.5000         0;
         0   -6.5400         0    0.5000;
         0         0    0.6667         0;
         0         0         0    0.6667]


Accf =[   0    1.0000         0   -0.0000;
         0         0    1.0000         0;
         0         0         0    1.0000;
         0         0   19.6200         0]


Bccf = [ 0;   0;    0;    1]


Cccf =[   -6.5400         0    0.5000         0]



disp('comparing CCF and OCF forms of this system, we can demonstrate the')
disp('the relationship of duality. Aocf = Accf^T, Bocf = Cccf^T, Cocf = Bocf^T')

disp('Aocf')
disp(Aocf1a)
disp('=Accf^T')
disp(Accf')

disp('Bocf')
disp(Bocf1a)
disp('=Cccf^T')
disp(Cccf')

disp('Cocf')
disp(Cocf1a)
disp('=Bccf^T')
disp(Bccf')


