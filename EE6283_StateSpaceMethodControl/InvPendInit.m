% QUYEN HUA
% EE6283
% MODULE 2
% 
% CE 1.2 OF LINEAR STATE-SPACE CONTROL SYSTEMS


%
%  This script initializes parameters for simulating the
%  inverted pendulum problem stated in Continuing Example 1.2 of 
%  the text:
%         Linear State-Space Control Systems
%         R. Williams, D. Lawrence

%

clc
clear all
close all

%
% Parameter Values
%
m1       =      1;          % mass, cart (kg)
m2       =      1;          % mass, anchor (kg)
L        =      1;          % length, pendulum
grav     =      9.8;          % gravity constant (m/s^2)
param    = [m1 m2 L grav];

tstart          = 0;                 % s
tstop           = 4;                 % s

%
% Initial State Vector to Produce a Sustained Ocillation in the Linear
% Simulation
%
%   x1 = displacement, cart (m)
%   x2 = velocity, cart (m/s)
%   x3 = angle, pendulum (rad)
%   x4 = angular velocity, pendulum (rad/s)
% %
% p0              = 0.01;              % m
% a0              = -(M*G)^2/(Jb/R^2+M)/(J+Jb);
% x0              = p0 * diag([1 1 -1/Bb/G -1/Bb/G]) * [1; 0; -sqrt(-a0); 0];

% I have no idea how to calculate these values.
x0=[0 0 0 0];
%
% Linearization about x1=x2=x3=x4=u1=u2=0
%
% A               = [0 1 0 0; 0 0 grav*m2/m1 0; 0 0 0 1; grav*(m1+m2)/(m1*L) 0 0 0];
% B               = [0 0; 1/m1 1/(L*m1); 0 0; 1/(L*m1) (m1+m2)/(m1*m2*L^2)];
% C               = [1 0 0 0; 0 0 1 0];
% D               = 0;
% sysBB           = ss(A, B, C, D);


% % Linearization about x1=x2=x4=u1=u2=0; x3=pi
% %
A               = [0 1 0 0; 0 0 grav*m2/m1 0; 0 0 0 1; -grav*(m1+m2)/(m1*L) 0 0 0];
B               = [0 0; 1/m1 -1/(L*m1); 0 0; -1/(L*m1) (m1+m2)/(m1*m2*L^2)];
C               = [1 0 0 0; 0 0 1 0];
D               = 0;
sysBB           = ss(A, B, C, D);