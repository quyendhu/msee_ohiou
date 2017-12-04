% Quyen Hua
% EE5713
% M6 - MATLAB
% 
% We wish to transmit the following 20 bits of data, using various
% modulation schemes: [1 0 0 1 1 1 0 1 1 0 0 0 0 1 0 1 1 1 0 1]
% 
%     1. Using a data rate of 1 bit per second, a carrier of 5 Hz., 
%     and a sampling frequency of 50 samples per second, 
%     create a MATLAB plot of the OOK modulated signal, 
%     along with a plot of the PSD of the signal. 
%     Use the functions plot_fft_spectrum and fft_spectrum 
%     as a starting point, and modify as necessary.
%     2. Repeat for BPSK
%     3. Now create an FSK modulation of the same signal, 
%     using 4 Hz. and 6 Hz. to represent binary zeros and ones respectively.
% 
% Submit the 3 plots. Make sure all axes are labeled properly
% Also turn in a short report (1/2 to 1 page long) on what you 
% observe from the plots, particularly the differences in the PSD 
% of the different modulations.

clear all
close all

message = [1 0 0 1 1 1 0 1 1 0 0 0 0 1 0 1 1 1 0 1];

l = length(message);

%% 1. OOK

fc = 5; %Hz, carrier frequency
data_rate = 1; %bit/sec
fs = 50; %samples/sec, sampling frequency

t = [0:1/fs:l-1/fs]; %time vector.

carrier = sin(2*pi*fc*t); %establish carrier

mod_message = zeros(1,length(t)); %preload mod sig for time savings...

%create pseudo message...
for i = 1:1:l
    mod_message((i-1)*fs+1:i*fs) = message(i);
end

%apply message to carrier
mod_sig = mod_message.*carrier;

plot(t, mod_sig);
title('Message w/OOK');
xlabel('time (s)');
ylabel('Amplitude');
set(gca, 'XTick', [1:1:20]);
%find the spectrum of our OOK signal and plot it.
[fft_Freq, fft_OOK] = fft_spectrum(t, mod_sig);
% plot_fft_spectrum(tempF, tempX, 1);

%PSD calculation
psd_OOK = (1/(fs*length(t)))*abs(fft_OOK).^2;

psd_OOK(2:end-1) = 2*psd_OOK(2:end-1);

figure();
plot(fft_Freq, (psd_OOK));
title('PSD of Message w/OOK');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (W/Hz)');

%% BPSK

%set up phase shift keyed carrier (180degrees)
b_carrier = sin(2*pi*fc*t + pi);

bpsk_sig = zeros(1, length(t));

%multiply message by carrier based on message value
for i = 1:1:length(t)
    if mod_message(i) == 0
        bpsk_sig(i) = b_carrier(i);
    else
        bpsk_sig(i) = carrier(i);
    end
end
figure
plot(t, bpsk_sig)
title('Message w/BPSK');
xlabel('time (s)');
ylabel('Amplitude');
set(gca, 'XTick', [1:1:20]);

%find the spectrum of our BPSK signal and plot it.
[fft_Freq2, fft_BPSK] = fft_spectrum(t, bpsk_sig);
figure
plot_fft_spectrum(fft_Freq2, fft_BPSK, 1);

%PSD calculation
psd_BPSK = (1/(fs*length(t)))*abs(fft_BPSK).^2;

psd_BPSK(2:end-1) = 2*psd_BPSK(2:end-1);

figure();
plot(fft_Freq, (psd_BPSK));
title('PSD of Message w/BPSK');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (W/Hz)');

%% FSK w/ 4Hz & 6Hz

%establish carriers
c4 = sin(2*pi*4*t);
c6 = sin(2*pi*6*t);

fsk_sig = zeros(1, length(t));

%multiply message by carrier based on message value
for i = 1:1:length(t)
    if mod_message(i) == 0
        fsk_sig(i) = c4(i);
    else
        fsk_sig(i) = c6(i);
    end
end
%plot the modulated signal
figure
plot(t, fsk_sig)
title('Message w/FSK @ 4Hz and 6Hz');
xlabel('time (s)');
ylabel('Amplitude');
set(gca, 'XTick', [1:1:20]);

%find the spectrum of our FSK signal and plot it.
[fft_Freq3, fft_FSK] = fft_spectrum(t, fsk_sig);
figure
plot_fft_spectrum(fft_Freq3, fft_FSK, 1);

%PSD calculation
psd_FSK = (1/(fs*length(t)))*abs(fft_FSK).^2;

psd_FSK(2:end-1) = 2*psd_FSK(2:end-1);

figure();
plot(fft_Freq, (psd_FSK));
title('PSD of Message w/FSK');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (W/Hz)');

%end script