% % Quyen Hua
% % EE6713
% % M2
% % MATLAB supplement
% % Textbook: Applied Digitial Signal Processing, 2011, D. Manolakis, Ingle

clear all
close all
%% 2.1C, D, E
% 2.1: write a MATLAB Script to generate and plot the following signals
% descried in section 2.1 for -20 <= n <= 40

n = -20:1:40;

% C
% real exponential signal, x1[n] = 0.80^n
x1 = 0.8.^n;
stem(n, x1);
grid on;
xlabel('n');
ylabel('x1');
title('real exponential signal, x1[n] = 0.80^n')
figure;
% D
% complex exponential signal, x2[n] = [0.9e^(j*pi/10)]^n
x2 = (0.9*exp(i*pi/10)).^n;
stem(n, x2);
grid on;
xlabel('n');
ylabel('x2');
title('complex exponential signal, x2[n] = [0.9e^(j*pi/10)]^n')
figure;

% E
% sinusoidal sequence, x3[n] = 2*cos[2*pi*(0.3)*n+pi/3]
x3 = 2*cos(2*pi*0.3*n + pi/3);
stem(n, x3);
grid on;
xlabel('n');
ylabel('x3');
title('sinusoidal sequence, x3[n] = 2*cos[2*pi*(0.3)*n+pi/3]')


%% 2.8 b. determine and plot the impulse response h[n]
n2_8 = -2:1:8;
hn2_8 =  [0 0 1/5 1/5 1/5 1/5 1/5 0 0 0 0];
figure;
stem(n2_8, hn2_8);
% xtick(-5:1:5);
% ytick(-2:1:2);
xlabel('n');
ylabel('h(n)');
title('2.8b, H[n]')

%% 2.27

u2_27 = ones(1,10);
n2_27 = 0:1:9;

x2_27 = (1/4).^n2_27;
h2_27 = (1/3).^n2_27;

y2_27 = conv(x2_27,h2_27);

figure;
stem(y2_27);
xlabel('np');
ylabel('y(n)');
title('2.27, y[n]')

figure;
stem(n2_27,x2_27);
xlabel('n');
ylabel('x(n)');
title('2.27, x[n]')

figure;
stem(n2_27,h2_27);
xlabel('n');
ylabel('h(n)');
title('2.27, h[n]')
