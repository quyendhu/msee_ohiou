% Quyen Hua
% EE5853
% Module 10
% Project - Task 2


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

%how many TOTs to sample to identify sufficient range from binning?
sample_start = 1;
sample_end = 15;
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
%             disp(round(tempRange))
            ranges(round(tempRange)) = (ranges(round(tempRange)) + 1);
        end
    end
end

[binned, range_est_init] = max(ranges);



%so, alpha beta filtering time?

epoch_length = 25; % samples, equates to 1sec (25Hz is interrogator frequency)

alpha = 0.08; %arbitrary values for alpha-beta, will need to tune
beta = 0.004;

range_rate = -3e3; %initial range rate in m/s
range_rate_predict = 0;

range_curr = range_est_init/nmi2m; %convert to meters from nautical miles...
range_curr_predict = 0;
range_predict= 0;

residual = 0;

DME_raw = [range_est_init];
DME_filter = [range_est_init];
DME_smoothed = [range_est_init];

prev_valid_range =range_est_init;

for tracked = 1:epoch_length:length(data.TOT)-epoch_length
    %establish input signal
    
    ranges_tracked = zeros(max_distance_nmi,1); %range gated    
    for i = tracked:epoch_step:tracked+epoch_length
        temp = data.TOA(TOAIndex(i)+(0:20));
        for ii = 1:1:length(temp)
            tempRange=((temp(ii) - data.TOT(i) - 56e-6)/12.36e-6);
            if tempRange < max_distance_nmi & tempRange >= 1
                ranges_tracked(round(tempRange)) = (ranges_tracked(round(tempRange)) + 1);
            end
        end
    end
    [bins,range_input] = max(ranges_tracked); %raw maxed bin
    
    
     
    
    %perform alpha beta filtering
    range_predict = range_curr + (range_rate*(epoch_length/25));     
    range_rate = range_rate_predict;
    
%     if range_input > range_predict*1.5
%         range_input = prev_valid_range;
%     else
%         prev_valid_range = range_input;
%     end
%         
%     if(range_predict <= 0)
%         disp(range_predict)
%     end
    
    residual = range_input - range_curr;
    
    
    range_curr = range_curr+alpha*residual;
    range_rate = range_rate+(beta*residual)/(25/epoch_length);
    
    range_curr_predict = range_curr;
    range_rate_predict = range_rate;
    
    
    
    %save data
    DME_smoothed = [DME_smoothed NaN];
    DME_raw = [DME_raw range_input];
    DME_filter = [DME_filter, range_curr_predict];   
end
disp('end')

time = (1:1:length(DME_raw));
slantRange = data.SlantRange(1:epoch_length:8500)*nmi2m; %take ground truth
hold on;
plot(time, DME_raw, time, DME_filter, time(1:1:length(slantRange)),slantRange);
% plot(data.SlantRange)
ylim([0 30])
test = data.SlantRange(1:25:length(data.SlantRange));
ylabel('Slant Range (Nautical Miles)')
xlabel(['time epoch (' num2str(epoch_length) '/25 second)'])
legend('DME estimation', 'AlphaBeta Tracker', 'GPS ground truth')

%convert everything to meters...
DME_raw_m = DME_raw/nmi2m;
DME_filter_m =DME_filter/nmi2m;
TOT_Epoch = data.TOT(1:epoch_length:length(data.TOT));
save EE5853_M10_Project_Data_QuyenHua.mat TOT_Epoch DME_raw_m DME_filter_m
%end
% % 
% % Task 2: Tracking (60%)
% % Use an alpha-beta tracker to track and smooth the DME ranges.
% % - Research alpha-beta filters online. A good starting point is Wikipedia, which also has some example code in its article.
% % - Start the alpha-beta tracker with the Range from your Acquisition task and a set the initial Range Rate to 0 m/s.
% % - For every epoch:
% % o Prediction. Propagate the previous Range Rate and Range estimate to the current time.
% % ? Note: ?T = TOT(i)-TOT(i-1). This value changes from epoch to epoch and should be re-calculated for every epoch.
% % ? Note: assume constant velocity for the propagation
% % o Range Gating. Use your new range estimate as a range gate. Look for a measured range that fits the estimated range within in pre-set margin (you can test various margins, but don’t take them too small. Example 1 km: the measured range should be within 1km of the estimated range.
% % o Innovation. If you have a valid measured range, update your estimate:
% % ? Determine the residual between the estimated and measured range.
% % ? Update your Range and Range Rate estimates using an alpha-beta filter.
% % ? Tune your alpha and beta parameters to get the best tracking results. You can use alpha=0.1 and beta=0.004 as a starting point. (These are not the ideal values though)
% % o Save. Save the following information in a vector:
% % ? TOT of the epoch
% % ? Raw measured range (NaN when no measured range within range gate)
% % ? Estimated (smoothed) range. This is the resulting range from the Update step (if there was a valid measured range within the rang gate) or the range from the Prediction step (when there was no valid measurement for this epoch)