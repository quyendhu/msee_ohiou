% Quyen Hua
% EE6713
% M7
% 
% Problem 6.3 pg 343

clear all
close all
% xc(t) = 2cos(10pi t - 60deg) - 3sin(16pi t)

Fs05 = 0.05;
% sample = 0.1;
% sample = 0.5;
t = 0:1/1000:2; %will have 2000 datapoints
xct = 2*cos(10*pi.*t - pi/3) - 3*sin(16*pi.*t);

%xn is xct sampled every 0.05n. that means take every 100th point
tn05 = 0:2/100:2;
xn = 2*cos(10*pi.*tn05 - pi/3) - 3*sin(16*pi.*tn05);
% yr05 = EE6713_M7_IdealDAC(t, tn05, Fs05, xn);
yr05 = interp(xn, 1/Fs05);


hold on;
subplot(3,1,1)
plot(t, xct)
title('6.3A,B, xc(t) and its sampled version of 0.05n')
ylabel('xc(t)')

subplot(3,1,2)
stem(tn05, xn, 'r')
ylabel('x[n]')

subplot(3,1,3)
temp = size(yr05);
t05 = 0:1:temp(2)-1;
t05 = t05/1000;
plot(t05, yr05, 'g')
xlabel('time')
ylabel('yr(t)')


%% c

figure

Fs1 = 0.1;

t = 0:1/1000:2; %will have 2000 datapoints
xct = 2*cos(10*pi.*t - pi/3) - 3*sin(16*pi.*t);

%xn is xct sampled every 0.1n. that means take every 200th point
tn1 = 0:2/10:2;
xn1 = 2*cos(10*pi.*tn1 - pi/3) - 3*sin(16*pi.*tn1);
% yr1 = EE6713_M7_IdealDAC(t, tn1, Fs1, xn1);
yr1 = interp(xn1, 1/Fs1);

hold on;
subplot(3,1,1)
plot(t, xct)
title('6.3C, xc(t) and its sampled version of 0.1n')
ylabel('xc(t)')

subplot(3,1,2)
stem(tn1, xn1, 'r')
ylabel('x[n]')
subplot(3,1,3)
temp = size(yr1);
t1 = 0:1:temp(2)-1;
t1 = t1/1000;
plot(t1, yr1, 'g')
xlabel('time')
ylabel('yr(t)')

%% d

figure

Fs5 = 0.5;

t = 0:1/1000:2; %will have 2000 datapoints
xct = 2*cos(10*pi.*t - pi/3) - 3*sin(16*pi.*t);

%xn is xct sampled every 0.5n. that means take every 1000th point
tn5 = 0:1:2;
xn5 = 2*cos(10*pi.*tn5 - pi/3) - 3*sin(16*pi.*tn5);
% yr5 = EE6713_M7_IdealDAC(t, tn5, Fs5, xn5);
% yr5 = interp(xn5, 1/Fs5);

hold on;
plot(t, xct)
% plot(t, yr5, 'g')

subplot(3,1,1)
plot(t, xct)
title('6.3D, xc(t) and its sampled version of 0.5n')
ylabel('xc(t)')

subplot(3,1,2)
stem(tn5, xn5, 'r')
ylabel('x[n]')

subplot(3,1,3)
temp = size(yr05);
t5 = 0:1:temp(2)-1;
t5 = t5/1000;
% plot(t5, yr5, 'g')
xlabel('time')
ylabel('yr(t)')
