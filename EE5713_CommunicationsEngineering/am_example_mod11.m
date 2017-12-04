function am_example_mod11

%download built in MATLAB sound file of a train whistle
load train

%play the sound through the speakers
y=y';
soundsc(y,Fs)

%set up plotting parameters
dt=1/Fs;
N=length(y);
t=(0:(N-1))*dt;

%Add white noise
noise_dB =20; %level of noise to add

y_noisy = awgn_5713(y,noise_dB);

%examine the spectrum of the signal
plot_PSD(t,y_noisy,1,Fs,length(t));
pause(3)

%upsample the signal Y to 128K samples per second 
y128=interp(y_noisy,16);
Fs128=Fs*16;
dt128=1/Fs128;
N128=N*16;
t128=(0:(N128-1))*dt128;

%replay and re-examine the spectrum of the signal
soundsc(y128,Fs128)
plot_PSD(t128,y128,2,Fs128,length(t));
pause(3)

%now modulate using am
%carrier frequency
fc=16384;
%set the modulation index
mp = max(abs(y128));
mu = 1;
A=mp/mu;
carrier=cos(2*pi*fc*t128);
ymod=(A+y128).*carrier;

%examine the spectrum of the modulated signal
plot_PSD(t128,ymod,3,Fs128,length(t));

%now demodulate the signal, by faking the diode rectifier demodulator shown in figure 4.10
%note that a coherent demodulation carrier is not required
%"matlab ideal diode"
yd1=max(ymod,0);
%low pass filter
[b,a]=butter(2,.01);
yd2 = filter(b,a,yd1);
%shift back to zero mean
ydemod = yd2-mean(yd2);

%play back the demodulated signal and examine the spectrum
soundsc(ydemod,Fs128)
plot_PSD(t128,ydemod,5,Fs128,length(t));


