%
%  This script initializes and executes nonlinear and linear(ized) simulations for
%  Ball and Beam dynamics appearing in:
%
%    J. Hauser, S. Sastry, and P. Kokotovic,
%    "Nonlinear Control via Approximate I/O Linearization:
%     The Ball and Beam Example," IEEE Trans. Auto. Contr.,
%     Vol. 37, No. 3, pp. 392 - 398, 1992.
%
%  and produces plots that compare the nonlinear and linearized responses
%

clc
clear all
close all

%
% Initialize the Simulation
%
BandBinit

%
% Run the Simulation(s)
%
sim('BandB')        % nonlinear simulation
sim('BandBlinear')  % linear(ized) simulation

%
% Analyze the Simulation Results
%
lwidth  = 2;        % line width
fsize   = 16;       % font size

% Ball position response - linear vs. nonlinear
figure(1)
plot(x_lin.time, x_lin.signals.values(:,1), ...
    x_nonlin.time, x_nonlin.signals.values(:,1), 'r--', 'LineWidth', lwidth)
legend('Linear Response', 'Nonlinear Response', 'Location', 'SouthWest')
ylabel('Ball Position (m)', 'Fontsize', fsize)
xlabel('Time (s)', 'Fontsize', fsize)

% Beam angle response - linear vs. nonlinear
figure(2)
plot(x_lin.time, x_lin.signals.values(:,3)*180/pi, ...
    x_nonlin.time, x_nonlin.signals.values(:,3)*180/pi, 'r--', 'LineWidth', lwidth)
legend('Linear Response', 'Nonlinear Response',  'Location', 'NorthWest')
ylabel('Beam Angle (deg)', 'Fontsize', fsize)
xlabel('Time (s)', 'Fontsize', fsize)
