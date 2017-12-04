% Quyen HUa
% EE6713
% M12
% P11.55

close all
clear all

%% analaog design specs for lowpass using elliptic and impulse invariance
Ws = 0.4*pi;%rads/sec
Wp = 0.3*pi;%rads/sec

Fs = 100; %sampling frequency

Ap = 1; %dB
%part a, As= 30, Part bm As = 60
As = 30; %dB

% we convert filter specs to acquire e and A (see 10.9)
e = sqrt(10^(0.1*Ap)-1);
A = 10^(0.05*As);
% next, find Rp
Rp  = 1/sqrt(1+e^2);

Td = 2;

%% filter design, order selection
[n, oc] = ellipord(Wp/pi, Ws/pi, Ap, As);
[B, A] = ellip(n, Ap, As, oc);

%% impulse invariance
[Bi, Ai] = impinvar(B,A,1/Td);

%% magnitude

[H, w] = freqz(B,A);
[Hi, wi] = freqz(B,A);

Hmagdb = 20*log10(abs(H));
% Hpha = angle(H);

Hidb = 20*log10(abs(Hi));


%% now plot! 
subplot(2,1,1)
plot(w, Hmagdb);
axis([0,pi,-80,10]);
xlabel('\omega')
ylabel('Mag (dB)');
title('Log-Magnitude Analog Response')
set(gca, 'xtick', [0, Wp, Ws, pi])


subplot(2,1,2)
plot(w, Hidb);
axis([0,pi,-80,10]);
xlabel('\omega')
ylabel('Mag (dB)');
title('Log-Magnitude Digital Response')
set(gca, 'xtick', [0, Wp, Ws, pi])


%% exact band edge frequency
test = find((floor(Hmagdb))==-3,1);
band_edge_freq = test/length(Hmagdb);

