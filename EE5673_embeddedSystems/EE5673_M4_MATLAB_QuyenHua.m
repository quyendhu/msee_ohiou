% Quyen Hua
% EE5673
% M4
% MATLAB Assignment
%% 

% Included in this project is the file clocktime.mat, a Matlab data file containing the clock readings from the reference clock (‘tref’) and 7 embedded node clocks (‘t1’ through ‘t7’) with different drifts.

% Using this data perform the following tasks:
% 
%     Given a precision requirement equal to 0.5 seconds and the drift rate results from Module 3, compute the resynchronization interval.
% 
%     Write a Matlab function that implements the Fault-Tolerant Averaging (FTA) method in Matlab.
% 
%     Write the Matlab code to perform the FTA method on the data from ‘clocktime.mat’  (only ‘t1’ though ‘t7’) every resynchronization interval.
% 
%     Generate a graph similar to the one on slide 29 of the Module 4 notes plotting reference clock versus local clock or local clock versus reference clock after synchronization.
% 
%     Provide a write-up (in Word or other comparable text editor) of your findings. Include all the plots in your text with correct cross-references to them in the text. Also, include a short discussion for each of the plots and tasks and make sure to include references to any equations or documents that you used.

%%  

clear all
close all


%load in the data
data = load('clocktime.mat');
tref=data.tref;
t1=data.t1;
t2=data.t2;
t3=data.t3;
t4=data.t4;
t5=data.t5;
t6=data.t6;
t7=data.t7;
%estimated drift rates from M3
drift1 = 1/(abs(t1(1000)-t1(1))/abs(tref(1000)-tref(1)))-1;
drift2 = 1/(abs(t2(1000)-t2(1))/abs(tref(1000)-tref(1)))-1;
drift3 = 1/(abs(t3(1000)-t3(1))/abs(tref(1000)-tref(1)))-1;
drift4 = 1/(abs(t4(1000)-t4(1))/abs(tref(1000)-tref(1)))-1;
drift5 = 1/(abs(t5(1000)-t5(1))/abs(tref(1000)-tref(1)))-1;
drift6 = 1/(abs(t6(1000)-t6(1))/abs(tref(1000)-tref(1)))-1;
drift7 = 1/(abs(t7(1000)-t7(1))/abs(tref(1000)-tref(1)))-1;

%% Given a precision requirement equal to 0.5 seconds and the drift rate results from Module 3, compute the resynchronization interval.

p = 0.5;
%assume PHI + RHO <= PI, with PHI = 0 (ideal system because not otherwise
%noted)
%and RHO = (driftRate1+...+driftRaten)*Rint

Rint = p/(drift1+drift2+drift3+drift4+drift5+drift6+drift7);
disp('Resynchronization interval calculated to be:')
disp('Rint = p/(drift1+drift2+drift3+drift4+drift5+drift6+drift7) = (seconds)')
disp(Rint)

%% Write the Matlab code to perform the FTA method on the data from ‘clocktime.mat’  (only ‘t1’ though ‘t7’) every resynchronization interval.
%see function FTA_EE5673 for FTA implementation

Rintm = floor(Rint*1000); % convert to miliseconds

len = size(tref);

t1adj=0;
t2adj=0;
t3adj=0;
t4adj=0;
t5adj=0;
t6adj=0;
t7adj=0;

adj = [0,0,0,0,0,0,0];
for i = [1:1:len(2)]
    if mod(i,Rintm) == 0
        disp(['performing FTA at clock cycle: ', num2str(i)])
        %since we are post processing, do we keep a running tally each time
        %we have to FTA? NOPE
%          adj = FTA_EE5673([t1(i)+adj(1),t2(i)+adj(2),t3(i)+adj(3),t4(i)+adj(4),t5(i)+adj(5),t6(i)+adj(6),t7(i)+adj(7)]);
        adj =FTA_EE5673([t1(i),t2(i),t3(i),t4(i),t5(i),t6(i),t7(i)]);
%         disp(adj)
    end
    t1adj = [t1adj, t1(i)-adj(1)];
    t2adj = [t2adj, t2(i)-adj(2)];
    t3adj = [t3adj, t3(i)-adj(3)];
    t4adj = [t4adj, t4(i)-adj(4)];
    t5adj = [t5adj, t5(i)-adj(5)];
    t6adj = [t6adj, t6(i)-adj(6)];
    t7adj = [t7adj, t7(i)-adj(7)]; 
end


%% Generate a graph similar to the one on slide 29 of the Module 4 notes plotting reference clock versus local clock or local clock versus reference clock after synchronization.
%% 
hold on;
plot(tref,t1adj(2:10001), ...
    tref,t2adj(2:10001), ...
    tref,t3adj(2:10001), ...
    tref,t4adj(2:10001), ...
    tref,t5adj(2:10001), ...
    tref,t6adj(2:10001), ...
    tref,t7adj(2:10001),'linewidth', 1)

plot(tref,tref,'--','linewidth',2)

legend('t1','t2','t3','t4','t5','t6','t7','tref')
title('Clocktime.mat with FTA')
xlabel('tref (mS)')
ylabel('t local (mS)')
saveas(gcf,'clockTimes_fta.png','png')

figure;
plot(tref,t1adj(2:10001),tref,t1, tref,tref)
legend('t1 w/FTA','t1','tref')
title('t1 vs t1 with FTA')
xlabel('tref (mS)')
ylabel('t1 (mS)')
saveas(gcf,'t1fta.png','png')
close

figure;
plot(tref,t2adj(2:10001),tref,t2, tref,tref)
legend('t2 w/FTA','t2','tref')
title('t2 vs t2 with FTA')
xlabel('tref (mS)')
ylabel('t2 (mS)')
saveas(gcf,'t2fta.png','png')
close

figure;
plot(tref,t3adj(2:10001),tref,t3, tref,tref)
legend('t3 w/FTA','t3','tref')
title('t3 vs t3 with FTA')
xlabel('tref (mS)')
ylabel('t3 (mS)')
saveas(gcf,'t3fta.png','png')
close

figure;
plot(tref,t4adj(2:10001),tref,t4, tref,tref)
legend('t4 w/FTA','t4','tref')
title('t4 vs t4 with FTA')
xlabel('tref (mS)')
ylabel('t4 (mS)')
saveas(gcf,'t4fta.png','png')
close

figure;
plot(tref,t5adj(2:10001),tref,t5, tref,tref)
legend('t5 w/FTA','t5','tref')
title('t5 vs t5 with FTA')
xlabel('tref (mS)')
ylabel('t5 (mS)')
saveas(gcf,'t5fta.png','png')
close

figure;
plot(tref,t6adj(2:10001),tref,t6, tref,tref)
legend('t6 w/FTA','t6','tref')
title('t6 vs t6 with FTA')
xlabel('tref (mS)')
ylabel('t6 (mS)')
saveas(gcf,'t6fta.png','png')
close

figure;
plot(tref,t7adj(2:10001),tref,t7, tref,tref)
legend('t7 w/FTA','t7','tref')
title('t7 vs t7 with FTA')
xlabel('tref (mS)')
ylabel('t7 (mS)')
saveas(gcf,'t7fta.png','png')
close