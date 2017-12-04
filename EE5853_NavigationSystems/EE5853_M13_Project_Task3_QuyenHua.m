% Quyen Hua
% EE5853
% M13 - Project - Task 3
% 
% Using the L1 and L2 pseudorange measurements, calculate the iono delay (expressed in
% meters) for all satellites.
%   a) Calculate the Iono delays and fill them into the table
%   b) Correct the L1 pseudorange measurements with the iono delays, and recalculate
% the user position. Provide
%       i. The improved user position in Lat, Lon, Height
%       ii. Error in user position with respect to truth in meters
%       iii. The norm of the range residuals

clear all
close all


% usefull constants
c = 299792458; % speed of light, m/s
GPS_L1_freq = 1575.42e6; %Hz
GPS_L2_freq = 1227.60e6; %Hz

load('EE4853-5853_GPS_PR.mat')

%first, get user position from LLH to ENU. use LLH2ECEF then ECEF2ENU
TruthECEF = LLH2ECEF(TruthLLH);
TruthENU = ECEF2ENU(TruthECEF,TruthECEF,TruthLLH); %its going to be 0,0,0, since user is supposed to be origin...


%using two different pseudoranges at two different frequency, we can
%calculate teh ionospheric delay, exclusive of the elevation angle

% delay_iono = (L1PSR-L2PSR)/c; %in seconds

%use dual frequency correction
delay_iono_L1_range = (GPS_L2_freq^2)/(GPS_L1_freq^2-GPS_L2_freq^2)*(L2PSR-L1PSR); % meters
delay_iono_L1_time = delay_iono_L1_range/c; %in seconds

%adjust the L1PSR with ionosphere corrections.
L1PSR_adjIono = L1PSR + delay_iono_L1_range;

%function!
[estPosECEF, resid, Hmatrix] = EE5853_M13_Proj_T2_ILS(L1PSR_adjIono,SatBC.ECEF);

% Give the user position in LLH
estPosLLH = ECEF2LLH(estPosECEF);

% Calculate the error in meters. Use ECEF format.
error = TruthECEF - [estPosECEF(1); estPosECEF(2); estPosECEF(3)];
magError = norm(error);

%probide the norm of the range residuals
residNorm = norm(resid);

estPosECEF_not= 1e6*[0.6695;-4.90325;4.01061;1.28494];