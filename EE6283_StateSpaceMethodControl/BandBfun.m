%
%  This function implements the nonlinear state equation function for the
%  Ball and Beam dynamics appearing in:
%
%    J. Hauser, S. Sastry, and P. Kokotovic,
%    "Nonlinear Control via Approximate I/O Linearization:
%     The Ball and Beam Example," IEEE Trans. Auto. Contr.,
%     Vol. 37, No. 3, pp. 392 - 398, 1992.
%
function    xdot = BandBfun(v, param)

%
% Parameter Values
%
M       = param(1);          % ball mass (kg)
R       = param(2);          % ball radius (m)
J       = param(3);          % beam inertia (kg m^2)
Jb      = param(4);          % ball inertia (kg m^2)
G       = param(5);          % gravitational acceleration (m/s^2)
B       = M / (Jb/R^2 + M);  % normalized parameter (unitless)

%
% Input Vector Components
%
%    v1 =  u = applied torque (N m)
%    v2 = x1 = ball position (m)
%    v3 = x2 = ball velocity (m/s)
%    v4 = x3 = beam angle (rad)
%    v5 = x4 = beam angular velocity (rad/s)
%
u       = v(1);
x1      = v(2);
x2      = v(3);
x3      = v(4);
x4      = v(5);


xdot     = [x2;                                                         % x1 dot
            B * ( x1*x4^2 - G*sin(x3) );                                % x2 dot
            x4;                                                         % x3 dot
           (-2*M*x1*x2*x4 - M*G*x1*cos(x3) + u) / (M*x1^2 + J + Jb) ];  % x4 dot