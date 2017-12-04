% P0217: Illustrating the usage of functions 'impz','filter,'conv'
close all; clc
n = 0:100;
b = [0.18 0.1 0.3 0.1 0.18];
a = [1 -1.15 1.5 -0.7 0.25];
% Part (a):
%
h = impz(b,a,length(n));
% Part (b):
%
u = [ones(1,50) zeros(1,96)];
y1 = filter(b,a,u);
%
% Part (c):
y2 = conv(h,u);
%
% Part (d):
y3 = filter(h,1,u);
%Plot
%
%hf = figconfg('P0217a','long');
figure(1)
stem(n,h)
xlabel('n','fontsize',14); ylabel('h[n]','fontsize',14);
title('Impulse Response h[n]','fontsize',14);
%
%hf2 = figconfg('P0217b','long');
figure(2)
stem(n,y1)
xlabel('n','fontsize',14); ylabel('y_1[n]','fontsize',14);
title('Unit Step Response: filter(b,a,x)','fontsize',14);
%
%hf3 = figconfg('P0217c','long');
figure(3)
stem(0:2*n(end),y2)
xlabel('n','fontsize',14); ylabel('y_2[n]','fontsize',14);
title('Unit Step Response: conv(h,x)','fontsize',14);
%
%hf4 = figconfg('P0217d','long');
figure(4)
stem(n,y3)
xlabel('n','fontsize',14); ylabel('y_3[n]','fontsize',14);
title('Unit Step Response: filter(h,1,x)','fontsize',14);