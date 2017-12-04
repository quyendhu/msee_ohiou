clear all
close all

%% Problem 1

Ac = 0.5; %amplitude
theta = 0; %phase shift...
fc = 108E6; %carrier frequency is 108MHz
fs = 16*fc;
t = 0:1/fs:6*(1/fc); %6 wavelengths


% Very High Frequency Omnideirectional Range (VOR) signal
st = Ac*(1+0.3*cos(2*pi*30.*t-theta)+0.3*cos(2*pi*9960.*t+16*cos(2*pi*30.*t))).*cos(2*pi*fc.*t);

mvar = 0.3*cos(2*pi*30*t - theta);


points = 100;
St = fft(st,points);

w=(0:(points/2-1))/(points/2)*(fs/2);
stem(w,abs(St(1:points/2)')/(points/2)); grid;
xlabel('Frequency (Hz)')
ylabel('|S(f)|')
title('one-sided amplitude spectrum of the VOR signal')


%% Problem 2
fc2 = 1.5E9;
fbpsk = 1E6;
t2 = 0:1E-10:1E-6;
y=square(2*pi*fbpsk.*t2);
carry=cos(2*pi*fc2*t2);
bpsk = y.*carry;


points2 = 10000;
BPSK = fft(bpsk,points2);
figure()
w2=(0:(points2/2-1))/(points2/2)*(fc2/2);
stem(w2,abs(BPSK(1:points2/2)')/(points2/2)); grid;
xlabel('Frequency (Hz)')
ylabel('|S(f)|')
title('one-sided amplitude spectrum of the BPSK signal w/1.5E9 carrier frequency and 1E6 BPSK frequency')