% Quyen Hua
% EE5853
% Module 10
% Project - Task 1

clear all
close all

data = load('DMEAcquisitionTracking.mat');

nmi2m = 0.000539957; %meters/nmi

% constants defined by paper:
delay_Transp = 56e-6; %seconds, delay of transponder
max_distance_nmi = 150; %nautical miles
max_distance_m = max_distance_nmi/nmi2m;
ppps_transp = 2700; %pulse pairs per second of transponder
ppps_interr = 25;  %pulse pairs per second of interrogator
velocity_signal = 2*1852/12.36e-6; %assuming 12.36 uS radar mile

%how big a range to bin things?
% what is the starting point of the epoch? the end point?
sample_start = 1;
sample_end = 10;
epoch_step = 1;

% generic formula:
% range = [TOA-TOT-delay_Transp]/12.36e-6 us/nmi


% create reference index array to reduce and identify more usable search
% range
TOAIndex = interp1(data.TOA,1:length(data.TOA),data.TOT,'nearest');

% initialize bins. since max range is 150nmi, use bin size of 1 and have
% 150 bins
ranges = zeros(max_distance_nmi,1);

% for each TOT (i) in between smaple start and sample end
%   for ten closest TOAs
%       calculate slant range measurement and bin them (add 1 to each bin
%       which results from a calculated range
for i = sample_start:epoch_step:sample_end
    temp = data.TOA(TOAIndex(i)+(0:10));
    for ii = 1:1:length(temp)
        tempRange=((temp(ii) - data.TOT(i) - 56e-6)/12.36e-6);
        if tempRange < max_distance_nmi & tempRange >= 0
            disp(round(tempRange))
            ranges(round(tempRange)) = (ranges(round(tempRange)) + 1);
        end
    end
end
