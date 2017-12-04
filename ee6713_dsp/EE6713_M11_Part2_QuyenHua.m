% quyen hua
% ee6713
% M11, part 2 per announcement
% txtbk problems: 10.17, 10.58

clc;
clear all;
close all;


% % 10.17,  multiband design with parks-mclellan (using matlab's firpm)
% f1 = [0.15 0.55 0.875];
f1 = [0.0 0.3 0.4 0.7 0.75 1.0];
a1 = [0.0 0.0 0.5 0.5 1.0  1.0];
n1 = 49;
b1 = firpm(n1, f1, a1);

[h1, w1] = freqz(b1, 1, 512);
plot(f1, a1, w1/pi, abs(h1))
legend('ideal', 'firpm multiband design, order=49')
xlabel('Radian Frequency (w/pi)')
ylabel('Magnitude')


% % 10.58,  multiband design with parks-mclellan (using matlab's firpm)
% f1 = [0.15 0.55 0.875];
f2 = [0.00 0.35 0.45 0.55 0.65 1.00];
a2 = [1.00 1.00 0.00 0.00 1.00 1.00];
n2 = 39;
b2 = firpm(n2, f2, a2);

[h2, w2] = freqz(b2, 1, 512);
figure;
plot(f2, a2, w2/pi, abs(h2))
legend('ideal', 'firpm bandstop design, order=39')
xlabel('Radian Frequency (w/pi)')
ylabel('Magnitude')