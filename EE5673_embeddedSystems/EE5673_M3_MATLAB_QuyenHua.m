% Quyen Hua
% EE5673
% M3
% MATLAB Assignment
%% 

% Included in this project is the file clocktime.mat, 
% a Matlab data file containing the clock readings 
% from the reference clock ('tref') and 7 embedded node clocks 
% ('t1' through 't7') with different drifts.
% 
% Using this data perform the following tasks:
% 
%  1]    Generate a graph similar to the one on 
% slide 28 of the Module 3 notes plotting reference 
% clock versus local clock or local clock versus reference clock.
% 
%  2]    Estimate the drift rates for each of the 7
% embedded node clocks based on the graphs and data.
% 
%  3]    Plot all possible offsets (between the 7 
% embedded node clocks) as a function of the reference time.
% 
%  4]   Plot the precision as a function of the reference time.
% 
% Provide a write-up (in MS Word or other comparable text editor) 
% of your findings. Include all the plots in your text with correct 
% cross-references to them in the text. Also, include a short discussion 
% for each of the plots and tasks and make sure to include references to
% any equations or documents that you used.
%%  part one... plot similar to slide 28

clear all
close all

data = load('clocktime.mat');
tref=data.tref;
t1=data.t1;
t2=data.t2;
t3=data.t3;
t4=data.t4;
t5=data.t5;
t6=data.t6;
t7=data.t7;
hold;
plot(t1,tref, ...
    t2,tref, ...
    t3,tref, ...
    t4,tref, ...
    t5,tref, ...
    t6,tref, ...
    t7,tref)
plot(tref,tref,'--r','LineWidth',5)
legend('t1','t2','t3','t4','t5','t6','t7','tref')
xlabel('time of local clock')
ylabel('time of reference clock')
title('Clock drifts of "clocktime.mat"')

%% part two... estimate drift rates...
drift1 = 1/(abs(t1(1000)-t1(1))/abs(tref(1000)-tref(1)));
drift2 = 1/(abs(t2(1000)-t2(1))/abs(tref(1000)-tref(1)));
drift3 = 1/(abs(t3(1000)-t3(1))/abs(tref(1000)-tref(1)));
drift4 = 1/(abs(t4(1000)-t4(1))/abs(tref(1000)-tref(1)));
drift5 = 1/(abs(t5(1000)-t5(1))/abs(tref(1000)-tref(1)));
drift6 = 1/(abs(t6(1000)-t6(1))/abs(tref(1000)-tref(1)));
drift7 = 1/(abs(t7(1000)-t7(1))/abs(tref(1000)-tref(1)));

%% part three... plot offsets?


%% part four... plot precision as a function ofreference time

