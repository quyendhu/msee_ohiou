%
%  This script initializes parameters for simulating the
%  Ball and Beam dynamics appearing in:
%
%    J. Hauser, S. Sastry, and P. Kokotovic,
%    "Nonlinear Control via Approximate I/O Linearization:
%     The Ball and Beam Example," IEEE Trans. Auto. Contr.,
%     Vol. 37, No. 3, pp. 392 - 398, 1992.
%

clc
clear all
close all

%
% Parameter Values
%
M               = 0.05;              % ball mass (kg)
R               = 0.01;              % ball radius (m)
J               = 0.02;              % beam inertia (kg m^2)
Jb              = 2.0e-6;            % ball inertia (kg m^2)
G               = 9.81;              % gravitational acceleration (m/s^2)
Bb              = M / (Jb/R^2 + M);  % normalized parameter (unitless)
param           = [M R J Jb G];

tstart          = 0;                 % s
tstop           = 4;                 % s

%
% Initial State Vector to Produce a Sustained Ocillation in the Linear
% Simulation
%
%    x1 = ball position (m)
%    x2 = ball velocity (m/s)
%    x3 = beam angle (rad)
%    x4 = beam angular velocity (rad/s)
%
p0              = 0.01;              % m
a0              = -(M*G)^2/(Jb/R^2+M)/(J+Jb);
x0              = p0 * diag([1 1 -1/Bb/G -1/Bb/G]) * [1; 0; -sqrt(-a0); 0];

%
% Linearization about r = 0, theta = 0
%
A               = [0 1 0 0; 0 0 -Bb*G 0; 0 0 0 1; -M*G/(J + Jb) 0 0 0];
B               = [0; 0; 0; 1/(J + Jb)];
C               = [1 0 0 0];
D               = 0;
sysBB           = ss(A, B, C, D);