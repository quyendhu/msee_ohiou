% QUYEN HUA
% EE6283
% MODULE 2
% 
% CE 1.2 OF LINEAR STATE-SPACE CONTROL SYSTEMS


%
%  This script initializes and executes nonlinear and linear(ized) simulations for
%  Inverted Pendulum problem appearing in:
%

%
%  and produces plots that compare the nonlinear and linearized responses
%

clc
clear all
close all

%
% Initialize the Simulation
%
InvPendInit

%
% Run the Simulation(s)
%
sim('InvertedPendulumLinear')  % linear(ized) simulation
sim('InvertedPendulum')        % nonlinear simulation


%
% Analyze the Simulation Results
%
lwidth  = 2;        % line width
fsize   = 16;       % font size

% Cart Position response - linear vs. nonlinear
figure(1)
plot(x_lin.time, x_lin.signals.values(:,1), ...
    x_nonlin.time, x_nonlin.signals.values(:,1), 'r--', 'LineWidth', lwidth)
legend('Linear Response', 'Nonlinear Response', 'Location', 'SouthWest')
ylabel('Cart Position (m)', 'Fontsize', fsize)
xlabel('Time (s)', 'Fontsize', fsize)
title('Equilibrium condition of theta = pi', 'Fontsize', fsize)

% Pendulum angle response - linear vs. nonlinear
figure(2)
plot(x_lin.time, x_lin.signals.values(:,3)*180/pi, ...
    x_nonlin.time, x_nonlin.signals.values(:,3)*180/pi, 'r--', 'LineWidth', lwidth)
legend('Linear Response', 'Nonlinear Response',  'Location', 'NorthWest')
ylabel('Pendulum Angle (deg)', 'Fontsize', fsize)
xlabel('Time (s)', 'Fontsize', fsize)
title('Equilibrium condition of theta = pi', 'Fontsize', fsize)