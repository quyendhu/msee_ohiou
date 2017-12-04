% quyen hua
% EE6713
% P10.7 a, b

clear all
close all


% ref slide 13 of lecture notes
ha = [1, 2, 3, -2, 5, -2, 3, 2, 1];
[Ha, oma] = freqz(ha,1);
magHa = abs(Ha);
wphaHa = angle(Ha)/pi;
[Aa, oma, uwphaa] = zerophase(ha,1);
subplot(2, 2, 1)
plot(oma, Ha)
title('Impulse Response')

subplot(2,2,2)
plot(oma,Aa)
title('Amplitude Response')

subplot(2,2,3)
% plot(real(Ha),imag(Ha))
zplane(ha, 1)
title('Pole-Zero plot')

subplot(2,2,4)
plot(oma,uwphaa)
title('Unwrapped phase response')



figure;
hb = [1, 2, 3, -2, -2, 3, 2, 1];
[Hb, omb] = freqz(hb,1);
magHb = abs(Hb);
wphaHb = angle(Hb)/pi;
[Ab, omb, uwphab] = zerophase(hb,1);

subplot(2, 2, 1)
plot(omb, Hb)
title('Impulse Response')

subplot(2,2,2)
plot(omb,Ab)
title('Amplitude Response')

subplot(2,2,3)
% plot(real(Ha),imag(Ha))
zplane(hb, 1)
title('Pole-Zero plot')

subplot(2,2,4)
plot(omb,uwphab)
title('Unwrapped phase response')
