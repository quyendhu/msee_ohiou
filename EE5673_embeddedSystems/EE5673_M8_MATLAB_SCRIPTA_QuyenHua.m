% Quyen Hua
% EE5673
% M8 MATLAB
% 
% 1)	Write a Matlab function implements the curve shown on 
% slide 25 of Module 8. The function should take the percentage 
% of utilization as output and return the inflation factor.

% The graph appears exponenential in nature. However, a general rule of
% thumb is not directly given. Therefore, experimentation is required.
% Guess and check is now my best friend.

clear all
close all

% set x axis (percent utilization)
x = 0:1:100;

% now guess and check some functions
% % y = 1+0.01*2.^(x/10)
% % y = 1+0.01*2.^(x/100)
% % y = 1+0.01*2.^(x/20)
% % y = 1+0.005*3.^(x/20)
% % y = 1+0.003*4.^(x/20)

y = 1+0.001*(5).^(x/20);% winner winner chicken dinner!

plot(y)
xlim([0 100])
ylim([0 4])
grid on
xlabel('Percent utilization')
ylabel('relative programming cost per instruction')
title('model of True Cost of Full Resource Utilization')