% Quyen Hua
% EE6713
% M8
% p7.34
% 
clear all
close all


n = -15:1:15;

xn = 0.8.^abs(n);

w = -2*pi:pi/10:2*pi;
x_dtft = 1./(1-0.8*exp(i*w)) + 1./(1-1.25*exp(-i*w));
x_fft = fft(xn, 50);

subplot(4,1,1)
plot(n,xn)
title('x[n] = 0.8.^abs(n);')
subplot(4,1,2)
plot(w,abs(x_dtft))
title('DTFT x[n]')
subplot(4,1,3)
title('DFT x[n]')
subplot(4,1,4)
plot(abs(x_fft))
title('|FFT|, x[n], N=50')

xcn = 0.4.^abs(n);
xc_dtft = 1./(1-0.4*exp(i*w)) + 1./(1-2.5*exp(-i*w));
xc_fft = fft(xcn, 50);
figure;
subplot(4,1,1)
plot(n,xcn)
title('x[n] = 0.4.^abs(n);')
subplot(4,1,2)
plot(w,abs(xc_dtft))
title('DTFT x[n]')
subplot(4,1,3)
title('DFT x[n]')
subplot(4,1,4)
plot(abs(xc_fft))
title('|FFT|, x[n], N=50')