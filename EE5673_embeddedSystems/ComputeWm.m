
% -----------------------------------------------------------------------
%
%   For EE4673/5673
%
%   Copyright (c) OU-EECS-MUdH-2014
%   
% -----------------------------------------------------------------------

close all
clear all
clc

% Bit period
tau = 1/125000; % bitrate = 125kbps
tau = tau*1000; % in ms

% -----------------------------------------------------------------------
% Message periods [ms]
% -----------------------------------------------------------------------

% Higher priority
T_Contactor     = 5;
T_Brake_msg     = 5;
T_Accel_posn    = 5;
T_Trans_Clutch  = 5; 
T_Brake_Switch  = 20;

% Our message
T_Driver_msg    = 50;

% Lower priority
T_Batt_msg_1    = 100;

% -----------------------------------------------------------------------
% Deadlines
% -----------------------------------------------------------------------

% Higher priority
D_Contactor     = 5;
D_Accel_posn    = 5;
D_Brake_msg     = 5;
D_Trans_Clutch  = 5; 
D_Brake_Switch  = 20;

% Our message
D_Driver_msg    = 20;

% Lower priority
D_Batt_msg_1    = 100;

% -----------------------------------------------------------------------
% Jitters
% -----------------------------------------------------------------------

% Higher priority
J_Accel_posn    = 0.1;
J_Brake_msg     = 0.1;
J_Trans_Clutch  = 0.1; 
J_Contactor     = 0.1;
J_Brake_Switch  = 0.3;

% Our message
J_Driver_msg    = 0.2;

% Lower priority (BLOCKING)
J_Batt_msg_1    = 0.6;

% -----------------------------------------------------------------------
% Bits per message
% -----------------------------------------------------------------------

% Higher priority
B_Accel_posn    = 90;
B_Brake_msg     = 100;
B_Trans_Clutch  = 90; 
B_Contactor     = 90;
B_Brake_Switch  = 90;

% Our message
B_Driver_msg    = 90;

% Lower priority
B_Batt_msg_1    = 120;

% -----------------------------------------------------------------------
% Transmission delays
% -----------------------------------------------------------------------

% Higher priority
C_Accel_posn    = 90*tau;
C_Brake_msg     = 100*tau;
C_Trans_Clutch  = 90*tau; 
C_Contactor     = 90*tau;
C_Brake_Switch  = 90*tau;

% Our message
C_Driver_msg    = 90*tau;

% Lower priority
C_Batt_msg_1    = 120*tau;

%
% Computations
%

% Compute blocking delay
Bm = B_Batt_msg_1*tau;

% Recursively compute 'wm'
N = 10; % # of steps

% Set teh initial value for the queuing delay
wm = Bm;
wmv = [];
wmv(1) = wm;
for ii=1:N,
    % Compute the part due to higher priority messages
    H = ceil( (wm + J_Accel_posn + tau)/T_Accel_posn )*C_Accel_posn + ...
        ceil( (wm + J_Brake_msg + tau)/T_Brake_msg )*C_Brake_msg + ...
        ceil( (wm + J_Trans_Clutch + tau)/T_Trans_Clutch )*C_Trans_Clutch + ...
        ceil( (wm + J_Contactor + tau)/T_Contactor )*C_Contactor + ...
        ceil( (wm + J_Brake_Switch + tau)/T_Brake_Switch )*C_Brake_Switch  ;
        
    % Compute interference delay
    wm = Bm +  H;
    
    % Add to vector (for display only)
    wmv(ii+1) = wm;
end
index = 0:N;

plot(index,wmv,'*')
grid on
title('Iterated Interference delay ', 'Fontsize', 12, 'FontWeight', 'bold');
xlabel('Iteration step', 'Fontsize', 12, 'FontWeight', 'bold');
ylabel('Interference delay [ms]', 'Fontsize', 12, 'FontWeight', 'bold');


