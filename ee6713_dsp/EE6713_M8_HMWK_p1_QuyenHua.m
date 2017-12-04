% Quyen Hua
% EE6713
% M8
% problem 7.3
clear all
close all

n = 0:1:1000; 
x_n = n.*(0.9).^n;

w = 0:pi/100:2*pi;
x_ejw = (0.9*exp(j*w))./(1-0.9*exp(j*w)).^2;
mag_xejw = sqrt(real(x_ejw).^2 + imag(x_ejw).^2)
x_fft = fft(x_n, 50);
mag_xfft = sqrt(real(x_fft).^2 + imag(x_fft).^2)


subplot(3,1,1)
plot(n,x_n)
title('x[n]')
subplot(3,1,2)
plot(w,mag_xejw)
title('DTFT X[ejw]')
subplot(3,1,3)
plot(mag_xfft)
title('FFT of x[n], N = 20')