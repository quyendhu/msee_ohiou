% QuyenHua
% EE6713
% M8
% P7.27

clear all
close all

t = 0:0.1:10;

W = -100:0.1:100;

xt = 10.*t.*exp(-20*t).*cos(20*pi*t);
xjw = 5./(i*(W+20*pi) + 20).^2 + 5./(i*(W-20*pi) + 20).^2;
subplot(5,1,1)
plot(t,xt)
title('x(t)')
subplot(5,1,2)
plot(W,abs(xjw))
title('|X(jW)|')
subplot(5,1,3)
plot(W,angle(xjw));
title('phase X(jW)')

x_fft = fft(xt,50);
subplot(5,1,4);
plot(abs(x_fft))
title('abs fft x(t), N=50')
subplot(5,1,5);
plot(angle(x_fft));
title('phase fft x(t), N=50')