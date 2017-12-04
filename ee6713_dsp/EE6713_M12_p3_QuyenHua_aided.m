% Quyen HUa
% EE6713
% M12
% P11.17

close all
clear all

%% analaog design specs for highpass using chebyshev 2
Ws = 0.6*pi;%rads/sec
Wp = 0.8*pi;%rads/sec

Fs = 100; %sampling frequency

Ap = 1; %dB
As = 60; %dB

% we convert filter specs to acquire e and A (see 10.9)
e = sqrt(10^(0.1*Ap)-1);
A = 10^(0.05*As);
% next, find Rp
Rp  = 1/sqrt(1+e^2);

%% step 1, filter design, order selection
[n, oc] = cheb2ord(Wp/pi, Ws/pi, Ap, As);
[B, A] = cheby2(n, As, oc, 'high');

%% part a, cascade form...
%homework help - to get to cascade form
%tf2sos converts digital transfer funcion datatt to second-order sections
%form (SOS). also, reference example 9.3
[sos G] = tf2sos(B,A);


%% part b, plots

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
h_imp = filter(B,A,x);
% Hc = impulse(B, A, t);

%% now plot! help needed here...
% om = linspace(0,1,501)*pi; %instead, use w from freqz...
subplot(2,2,1)
plot(w, Hmagdb);
axis([0,pi,-80,10]);
xlabel('\omega/\pi')
ylabel('Mag (dB)');
title('Log-Magnitude Response')
set(gca, 'xtick', [0, Ws, Wp, pi])

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
stem(n, h_imp)
xlabel('Time (s)')
ylabel('Amplitude')
title('Impulse Response');

%% exact band edge frequency
test = find((floor(Hmagdb))==-3,1);
band_edge_freq = test/length(Hmagdb);

