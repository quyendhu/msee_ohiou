% Quyen Hua
% EE6713
% M9
% P8.44
% 

clear all
close all
clc

% Fs = 40Hz

t = 0:1/40:128/40; %128 sample of x[n] at 40Hz...

xn = cos(20*pi*t)+cos(18*pi*t)+cos(22*pi*t);

% (a) 128 pnt fft
x_fft128 = fft(xn,128);
% (b) 1024 pnt fft
x_fft1024 = fft(xn,1024);

subplot(3,1,1)
plot(t,xn)
title('x[n], N=128, Fs=40Hz')
xlabel('t')
subplot(3,1,2)
w128 = -20:40/128:20-40/128;
stem(w128,x_fft128)
title('FFT(x[n]) w/N=128')
xlabel('F')
subplot(3,1,3)
w1024 = -20:40/1024:20-40/1024;
stem(w1024,x_fft1024)
title('FFT(x[n]) w/N=1024')
xlabel('F')
