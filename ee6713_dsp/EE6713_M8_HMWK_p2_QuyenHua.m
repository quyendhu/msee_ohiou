% QUyen Hua
% EE6713
% M8
% Problem 7.12
% 
% 
clear all
close all

n = 0:1:49; %see textbook
x1 = 0.9.^n;
x2 = (1-0.8.^n);

[X1,X2] = tworealDFTs(x1,i*x2);

X1_fft = abs(fft(x1,50));
X2_fft = abs(fft(i*x2,50));

xn = x1+i*x2;

X_DFT = X1+X2;
XN_fft = abs(fft(xn,50));

%% plotting
%x[n]
subplot(3,1,1);
plot(n,xn);
title('p7.12, x[n]')
ylabel('x[n]')

subplot(3,1,2);
plot(n,x1);
ylabel('x1[n]')

subplot(3,1,3);
plot(n,x2);
ylabel('x2[n]')

%FFT
figure;
subplot(3,1,1);
plot(XN_fft);
title('p7.12, fft x[n] = x1[n] + jx2[n]')
ylabel('fft x[n]')

subplot(3,1,2);
plot(X1_fft);
ylabel('fft of x1[n]')

subplot(3,1,3);
plot(X2_fft);
ylabel('fft of x2[n]')

%DFT
figure;
subplot(3,1,1);
plot(abs(X_DFT));
title('p7.12, DFT x[n] = x1[n] + jx2[n]')
ylabel('DFT of x[n]')

subplot(3,1,2);
plot(abs(X1));
ylabel('DFT of x1[n]')

subplot(3,1,3);
plot(abs(X2));
ylabel('DFT of x2[n]')