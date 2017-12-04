% QUYEN HUA
% EE6283
% MODULE 2
% 
% CE 1.2 OF LINEAR STATE-SPACE CONTROL SYSTEMS


%
%  This function implements the nonlinear state equation function for the
%  Inverted Pendulum in:
%
%    R. Williams, D. Lawrence,
%    "Linear State-Space Control Systems; Continuing Example 1.2,"
%
function    xdot = InvertedPendulumFun(v, param)

%
% Parameter Values
%
m1       = param(1);          % mass, cart (kg)
m2       = param(2);          % mass, anchor (kg)
L        = param(3);          % length, pendulum
grav     = param(4);          % gravity constant (m/s^2)

%
% Input Vector Components
%
%    v1 = u1 = applied force (N m)
%    v2 = u2 = applied torque (N m)
%    v3 = x1 = displacement, cart (m)
%    v4 = x2 = velocity, cart (m/s)
%    v5 = x3 = angle, pendulum (rad)
%    v6 = x4 = angular velocity, pendulum (rad/s)

u1      = v(1);
u2      = v(2);
x1      = v(3);
x2      = v(4);
x3      = v(5);
x4      = v(6);


x2dotA = (-L*m2*sin(x3)*x4^2 + u1)/(m1-m2*cos(x3)^2+m2);
x2dotB = cos(x3)*(u2+L*grav*m2*sin(x3))/(L*m1-L*m2*cos(x3)^2+L*m2);

x2dot = x2dotA+x2dotB;


x4dotA = cos(x3)*(-L*m2*sin(x3)*(x4^2)+u1)/(L*m1-L*m2*cos(x3)^2+L*m2);
x4dotB = (m1+m2)*(u2+L*grav*m2*sin(x3))/(L^2*(m2^2-m2^2*cos(x3)^2+m1*m2));

x4dot = x4dotA+x4dotB;

xdot     = [x2;                                                         % x1 dot
            x2dot;                                                      % x2 dot
            x4;                                                         % x3 dot
            x4dot];                                                     % x4 dot