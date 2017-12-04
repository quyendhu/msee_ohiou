% quyen hua
% ee6713
% m5
% p5.2

a = 0.81;
b = 0.19;

w = -pi:pi/50:pi;
w2 = 0:pi/50:2*pi;

Hw = b./(1+a*exp(-j*2*w));
Hw2 = b./(1+a*exp(-j*2*w2));

phaseHw = angle(Hw);
phaseHw2 = angle(Hw2);

plot(w2, phaseHw2);
xlabel('w')
ylabel('phase')
title('5.2.b unwrapped and wrapped phase response')