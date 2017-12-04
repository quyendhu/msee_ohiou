% Quyen Hua
% EE5673
% M8 MATLAB
% 
% 2)	2)	Use Matlab to evaluate the following. Suppose that for a
% certain application, the cost per SLOC is estimated to be $135, that 
% one line of code can be represented by 1 line in the program memory 
% and that the estimated number of lines of code is 6,000. Furthermore,
% the microcontrollers have been down-selected to the following 
% three options:  (i) the PIC16F883, (ii) the PIC16F1786, (ii) and 
% the PIC16F1938. Evaluate and plot the cost per item as a function
% of number of produced items (ranging from 1000 to 10,000,000) for
% each of the three options with and without taking into account the
% utilization. You are required to provide two plots here: one while
% not taking into account utilization and one while taking into account 
% utilization. Make sure to indicate the curves for the three options
% by different colors.

clear all
close all

% set x axis (number of units)
x = 1000:1000:10000000;

% compute the cost of the three devices, with and without inflation factor
% use: RE + (inflationFactor*NRE/numberUnits), where RE is the IC cost
% and NRE is the cost of the software

%in calculating the NRE, assume 1 line = 1 bytes in assembly language
NRE = 6000*135; %6000 SLOC * 135 $/SLOC

inflation7 = EE5673_M8_ResourceCost((6/7)*100);
inflation14 = EE5673_M8_ResourceCost((6/14)*100);
inflation28 = EE5673_M8_ResourceCost((6/28)*100);

kb7         = 1.64+(NRE./x);
kb7inf      = 1.64+inflation7*(NRE./x);
kb14        = 1.61+(NRE./x);
kb14inf     = 1.61+inflation14*(NRE./x);
kb28        = 1.74+(NRE./x);
kb28inf     = 1.74+inflation28*(NRE./x);


plot(x, kb7,x, kb14, x, kb28)
xlim([0 10000000])
ylim([0 10])
legend('7KB memory', '14KB memory','28KB memory')
grid on
xlabel('Total Number of Units')
ylabel('Cost Per Unit ($)')
title('Cost of implementation of similar code across three different devices (1,000-10,000,000 devices)')

figure
plot(x, kb7,x, kb14, x, kb28)
xlim([0 500000])
ylim([0 100])
legend('7KB memory', '14KB memory','28KB memory')
grid on
xlabel('Total Number of Units')
ylabel('Cost Per Unit ($)')
title('Cost of implementation of similar code across three different devices with inflation factor (1,000-500,000 devices)')
 
figure;
plot(x ,kb7inf,x, kb14inf,x, kb28inf)
xlim([0 10000000])
ylim([0 10])
xlabel('Total Number of Units')
ylabel('Cost Per Unit ($)')
legend('7KB memory', '14KB memory','28KB memory')
title('Cost of implementation of similar code across three different devices (1,000-10,000,000 devices)')
grid on;

figure;
plot(x ,kb7inf,x, kb14inf,x, kb28inf)
xlim([0 500000])
ylim([0 100])
xlabel('Total Number of Units')
ylabel('Cost Per Unit ($)')
legend('7KB memory', '14KB memory','28KB memory')
title('Cost of implementation of similar code across three different devices with inflation factor (1,000-500,000 devices)')
grid on;

% end