% Quyen HUa
% EE6713
% M12
% P11.12

close all
clear all

%% analaog design specs for bilinear and butterworth
Ws = 0.35*pi;%rads/sec
Wp = 0.25*pi;%rads/sec

Fs = 100; %sampling frequency

Ap = 1; %dB
As = 50; %dB

% we convert filter specs to acquire e and A (see 10.9)
e = sqrt(10^(0.1*Ap)-1);
A = 10^(0.05*As);
% next, find Rp
Rp  = 1/sqrt(1+e^2);


%%step by step design of impulse invariance filter transform
%% step 1, choose td
% Td is arbitrary. the solution chose 2
Td = 1;
%% step 2, compute edge freq
edge_op = 2/Td*tan(Wp/2);
edge_os = 2/Td*tan(Ws/2);

%% Step 3, butterworth intermediary step
[n, oc] = buttord(edge_op, edge_os, Ap, As, 's');
[B_i, A_i] = butter(n, oc, 's');

%% step 4, digital filter
[B, A] = bilinear(B_i, A_i, 1/Td);

[H, w] = freqz(B,A);

Hmagdb = 20*log10(abs(H));
Hpha = angle(H);
%im not sure i understand these group delay calculations. why are we
%calculating the "derivative"?
Hgroup = -diff(unwrap(Hpha))./(diff(w));
Hgroup = [Hgroup' Hgroup(end)];
Hgroup = medfilt1(Hgroup, 3);

%impulse response... help definitely needed here
NN = 50;
n = 0:NN;
x = (n==0);
t = linspace(0, NN*Td, 501);
Hc = impulse(B, A, t);

%% now plot! help needed here...
% om = linspace(0,1,501)*pi; %instead, use w from freqz...
subplot(2,2,1)
plot(w, Hmagdb);
axis([0,pi,-80,10]);
xlabel('\omega/\pi')
ylabel('Mag (dB)');
title('Log-Magnitude Response')
set(gca, 'xtick', [0, Wp, Ws, pi])

subplot(2,2,2)
plot(w, Hpha);
xlabel('\omega/\pi')
ylabel('Rad');
title('Phase Response')

subplot(2,2,3)
plot(w, Hgroup)
xlabel('\omega/\pi')
ylabel('samples');
title('group delay')

subplot(2,2,4)
plot(t, Hc)
xlabel('Time (s)')
ylabel('Amplitude')
title('Impulse Response');

%% exact band edge frequency
test = find((floor(Hmagdb))==-3,1);
band_edge_freq = test/length(Hmagdb);

