function fm_example

%download built in MATLAB sound file of a train whistle
load train

%play the sound through the speakers
y=y';
soundsc(y,Fs)

%Set up plotting parameters
dt=1/Fs;
N=length(y);
t=(0:(N-1))*dt;

%examine the spectrum of the signal
plot_fft_spectrum(t,y,1);

%upsample the signal Y to 128K samples per second 
y128=interp(y,16);
Fs128=Fs*16;
dt128=1/Fs128;
N128=N*16;
t128=(0:(N128-1))*dt128;

%replay and re-examine the spectrum of the signal
soundsc(y128,Fs128)
plot_fft_spectrum(t128,y128,2);

%now modulate to a carrier using dsb_sc
fc=16384;   %carrier frequency
kk=3000;    %maximum frequency deviation
ymod = cos(2*pi*fc*t128 + 2*pi*kk*cumsum(y128)*dt128);

%examine the spectrum of the modulated signal
plot_fft_spectrum(t128,ymod,3);

%fm demodulate the signal
yq = hilbert(ymod).*exp(-j*2*pi*fc*t128);
ydemod = (1/(2*pi*kk))*[0 diff(unwrap(angle(yq)))*Fs128];


soundsc(ydemod,Fs128)
plot_fft_spectrum(t128,ydemod,5);

dum=1;
