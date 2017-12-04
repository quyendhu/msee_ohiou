clear all
close all

%set a time vector...
t = -100:10:1000;

x = 0:10:800;

% draw that first line, using
% The DME/P interrogator uses a DAC circuit with a delay of 100 ns and attenuation of 6 dB. 
% 
signal = 0.01*x;

%Consider a DME/P signal that is contaminated with specular multipath with a multipath-to-direct ratio of -3 dB, a multipath delay of 150 ns, and a relative phase of 0°. 
multipath = (1/200)*x-(150/200);


%add the signals together and find the virtual zero
impact = signal+multipath;

iImpact = find(impact==0);
iSignal = find(signal==0);

timediff = 10*(iImpact-iSignal); %nanoseconds

measurementError=timediff*3e8*1e-9; %meters



plot(x,signal, x, multipath, x, impact);
grid on
xlim([0,1000])
ylim([0,12])
legend('interrogator signal','Multipath signal','recieved signal')
xlabel('Time (nanoseconds)')
ylabel('Peak Amplitude (dB)')
title('DME/P Multipath problem')
