% Quyen HUa
% EE6713
% M12
% P11.8

close all
clear all
Os = 10;%rads/sec
Op = 15;%rads/sec

Fs = 100; %sampling frequency

Ws = Os/Fs; 
Wp = Op/Fs; 
Ap = 1; %dB
As = 40; %dB

[n, Wn] = buttord(Wp, Ws, Ap, As);

[B, A] = butter(abs(n), Wn, 'high');

[h,w] = freqz(B,A);%,512);


subplot(2,1,1)
plot(w/pi, 20*log10(abs(h)))
title('Butterworth Filter, Log-Magnitude Response')
ylabel('Mag (dB)')
subplot(2,1,2)
plot(w/pi, angle(h))
title('Phase Response')
xlabel('frequency (10 Hz)')

Td = 1;

% [z, p, k] = butter(n, Wn, 'high');
[Ba, Aa] = impinvar(B, A, 1);
[ha,wa] = freqz(Ba, Aa);
figure;
subplot(2,1,1)
plot(wa/pi, 20*log10(abs(ha)));
title('Impulse Invariance of butterworth')
subplot(2,1,2)
plot(wa/pi, angle(ha))
title('Phase response')
xlabel('frequency (10 Hz)')

