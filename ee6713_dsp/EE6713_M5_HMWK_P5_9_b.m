% Quyen Hua
% EE6713
% M5
% 
% P5.9b


clear all
close all


B = [1 1.655 1.655 1];
A = [1 -1.57 1.264 -0.4];

% A = [-0.4 1.264 -1.57 1];


% [gd, omega] = grpdelay(B,A);
% plot(omega, gd)
% xlabel('w/pi')
% ylabel('tau(w)')
% title('Group Delay by "grpdelay"')
% figure;


[gd0, omega0] = grpdelay0(B,A);
plot(omega0, gd0)
xlabel('w/pi')
ylabel('tau(w)')
title('Group Delay by "grpdelay0"')

