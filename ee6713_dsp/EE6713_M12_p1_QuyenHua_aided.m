% Quyen HUa
% EE6713
% M12
% P11.8

close all
clear all

%% analaog design specs
Os = 10;%rads/sec
Op = 15;%rads/sec

Fs = 100; %sampling frequency

Ap = 1; %dB
As = 40; %dB

[n, Wn] = buttord(Op, Os, Ap, As, 's'); 

[B, A] = butter(n, Wn, 'high', 's'); 

omax = 30; %rad/sec, x max
om = linspace(0,omax, Fs); 

H = freqs(B,A,om);

Hdb = 20*log10(abs(H));
plot(om,Hdb)
xlabel('F in rad/sec')
ylabel('Mag (dB)')
title('Magnitude Response')
set(gca, 'xtick', [0, Os, Op, omax]);

%% impulse invariance
Td = 1;

[Bi, Ai] = impinvar(B,A,1/Td);

w = linspace(0,1,Fs)*pi;

Hd = freqz(B,A,w);

Hddb = 20*log10(abs(Hd)./max(abs(Hd)));
figure;
plot(w/pi, Hddb)
xlabel('\omega/\pi')
ylabel('mag (dB)')
title('transformed magnitude response with Td=1')
% set(gca, 'xtick', [0, Os, Op, omax]);


