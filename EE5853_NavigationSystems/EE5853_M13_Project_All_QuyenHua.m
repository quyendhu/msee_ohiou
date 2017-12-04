% Quyen Hua
% EE5853

clear all
close all

% usefull constants
c = 299792458; % speed of light, m/s
GPS_L1_freq = 1575.42e6; %Hz
GPS_L2_freq = 1227.60e6; %Hz

load('EE4853-5853_GPS_PR.mat')

% remember to utilize LLH2ECEF and ECEF2LLH coordinate transformations

%first, get user position from LLH to ENU. use LLH2ECEF then ECEF2ENU
TruthECEF = LLH2ECEF(TruthLLH);
TruthENU = ECEF2ENU(TruthECEF,TruthECEF,TruthLLH); %its going to be 0,0,0, since user is supposed to be origin...


%% Task1

% This is in the report as its a small word type thing



%% Task2

% M13 - Project - Task 2 
% 
% Calculate the GPS position using the measured pseudoranges (L1PSR), and the broadcast
% ephemeris satellite clock and orbit (SatBC.ECEF and SatBC.Clock)
% 
% Add the satellite clock correction SatBC.Clock to the measured pseudorange.
% Note: this correction is already in meters.
% - Do not apply any iono and tropo corrections to the pseudoranges yet.
% - Use the Iterative Least Squares (ILS) method as explained in Module 13 to solve
% for user position and receiver clock error. Implement the following function for
% this:
%     [EstPos,Residuals,H]=CalcGPSPos(PR,SatECEF)
% with
%     PR = [Nx1] pseudoranges, for example from L1PSR
%     SatECEF = [3xN] sat positions in ECEF, for example from SatBC.ECEF


%add the satellite clock correction SatBC.clock (m) to the measured
%pseudoranges from L1PSR
L1PSR_adjSatBC = L1PSR + SatBC.Clock;

[estPosECEF_unmod, resid_unmod, Hmatrix] = CalcGPSPos(L1PSR_adjSatBC,SatBC.ECEF);

% Give the user position in LLH
estPosLLH_unmod = ECEF2LLH(estPosECEF_unmod);
estPosLLH_unmodDeg = [  estPosLLH_unmod(1)/(pi/180);
                        estPosLLH_unmod(2)/(pi/180);
                        estPosLLH_unmod(3)];
% Calculate the error in meters. Use ECEF format.
error_unmod = TruthECEF - [estPosECEF_unmod(1); estPosECEF_unmod(2); estPosECEF_unmod(3)];
magError_unmod = norm(error_unmod);

%probide the norm of the range residuals
residNorm_unmod = norm(resid_unmod);

% identify the horizontal, vertical, and p... dilution of precisions.
[estPosENU_unmod, resid_ENU, H_ENU] = CalcGPSPos(L1PSR_adjSatBC, ECEF2ENU(SatBC.ECEF, estPosECEF_unmod(1:3), ECEF2LLH(estPosECEF_unmod(1:3))));

% dilution of precision
Q = inv(H_ENU'*H_ENU);
PDOP = sqrt(Q(1,1)+Q(2,2)+Q(3,3));
HDOP = sqrt(Q(1,1)+Q(2,2));
VDOP = sqrt(Q(3,3));


%% Task3
% 
% Using the L1 and L2 pseudorange measurements, calculate the iono delay (expressed in
% meters) for all satellites.
%   a) Calculate the Iono delays and fill them into the table
%   b) Correct the L1 pseudorange measurements with the iono delays, and recalculate
% the user position. Provide
%       i. The improved user position in Lat, Lon, Height
%       ii. Error in user position with respect to truth in meters
%       iii. The norm of the range residuals

%use dual frequency correction
delay_iono_L1_range = (GPS_L2_freq^2)/(GPS_L1_freq^2-GPS_L2_freq^2)*(L2PSR-L1PSR); % meters
delay_iono_L1_time = delay_iono_L1_range/c; %in seconds

%calculate Total Electron Count with delay_iono_L1_time
TEC = delay_iono_L1_time*c*GPS_L1_freq^2/40.3; %electrons/m^2

%adjust the L1PSR with ionosphere corrections. subtract because the code is
%delayed and the carrier is advanced
L1PSR_adjIono = L1PSR_adjSatBC - delay_iono_L1_range;

%function!
[estPosECEF_iono, resid_iono, Hmatrix_iono] = CalcGPSPos(L1PSR_adjIono,SatBC.ECEF);

% Give the user position in LLH
estPosLLH_iono = ECEF2LLH(estPosECEF_iono);

estPosLLH_ionoDeg = [   estPosLLH_iono(1)/(pi/180);
                        estPosLLH_iono(2)/(pi/180);
                        estPosLLH_iono(3)];

% Calculate the error in meters. Use ECEF format.
error_iono = TruthECEF - [estPosECEF_iono(1); estPosECEF_iono(2); estPosECEF_iono(3)];
magError_iono = norm(error_iono);

%probide the norm of the range residuals
residNorm_iono = norm(resid_iono);

%% Task4
% To calculate the tropo corrections, you first need the satellite elevation angles. For this,
% convert the satellite ECEF coordinates into an ENU coordinate frame, with the position
% found at 3 as the origin. Using the satellite coordinates in the local-level ENU coordinate
% frame you now can calculate the satellite elevation angles.
%     a) Calculate the satellite elevation angles and fill them into the table
%     b) Calculate the satellite tropospheric delays, and put those in the table as well
%     c) Correct the L1 pseudorange measurements with the iono and tropo delays, and
%     recalculate the user position. Provide
%         i. The improved user position in Lat, Lon, Height
%         ii. Error in user position with respect to truth in meters
%         iii. The norm of the range residuals

sat_ENU = [];
sat_LLH = [];
%convert sat positions to ENU using task3 estPos as origin
for i = 1:1:length(L1PSR)
    temp = [SatBC.ECEF(1,i); SatBC.ECEF(2,i);SatBC.ECEF(3,i)];
    sat_ENU = [sat_ENU ECEF2ENU(temp, estPosECEF_iono(1:3),estPosLLH_iono(1:3))];
    sat_LLH = [sat_LLH ECEF2LLH(temp)];
end


sat_EL = zeros(length(L1PSR),1);

%visualize... how do you calculate elevation angle???
%scatter3(sat_ENU(1,:),sat_ENU(2,:),sat_ENU(3,:))
for i = 1:1:length(L1PSR)
    r_EN = sqrt(sat_ENU(1,i)^2+sat_ENU(2,i)^2);
    sat_EL(i) = atand(sat_ENU(3,i)/r_EN); %in degrees
end

%delay calculation. refer to slide 23 of lecture notes.
% for H, use estPost H from LLH coordinate frame.
% for EL, use calculated Elevation Angle, above
delay_tropo = 2.4224*exp(-0.13345e-3*estPosLLH_iono(3))./(sind(sat_EL)+0.026);

%adjust L1PSR psuedoranges with tropo adjustments
L1PSR_tropo = L1PSR_adjIono - delay_tropo;

%function!
[estPosECEF_tropo, resid_tropo, Hmatrix_tropo] = CalcGPSPos(L1PSR_tropo,SatBC.ECEF);

% Give the user position in LLH
estPosLLH_tropo = ECEF2LLH(estPosECEF_tropo);
estPosLLH_tropoDeg = [  estPosLLH_tropo(1)/(pi/180);
                        estPosLLH_tropo(2)/(pi/180);
                        estPosLLH_tropo(3)];


% Calculate the error in meters. Use ECEF format.
error_tropo = TruthECEF - [estPosECEF_tropo(1); estPosECEF_tropo(2); estPosECEF_tropo(3)];
magError_tropo = norm(error_tropo);

%probide the norm of the range residuals
residNorm_tropo = norm(resid_tropo);

%% Task5 Precise Clock and Orbit
% Using an extensive network of ground-based reference stations it is possible to calculate
% the satellite clock and orbit parameters much more precisely than those provided in the
% GPS broadcast message. See for example
% http://igscb.jpl.nasa.gov/components/usage.html. The struct SatPPP contains those
% precise clock and orbit parameters for this time epoch.
%     a) Calculate the error of the broadcast ephemeris clock, compared to the precise
%     ephemeris. Put your result in the table.
%     b) Calculate the error of the broadcast ephemeris orbit, compared to the precise
%     ephemeris, projected on the Line-Of-Sight vector. Put your result in the table.
%     c) Calculate the improved position using iono and tropo corrections, and the precise
%     clock and orbit (SatPPP). Provide:
%         i. The improved user position in Lat, Lon, Height
%         ii. Error in user position with respect to truth in meters
%         iii. The norm of the range residuals

%compute clock errors
ClockError_m = SatBC.Clock-SatPPP.Clock; %meters?
ClockError_t = ClockError_m/c; %seconds...
ClockError_hz = ClockError_t*GPS_L1_freq; % "clocks"


%compute orbit errors
OrbitError = zeros(3,length(L1PSR));
OrbitError_projected = zeros(1,length(L1PSR));
LoS = zeros(3,length(L1PSR));
LoS_unit = zeros(3,length(L1PSR));
for i = 1:1:length(L1PSR)
   % calculate line of sight unit vector
   LoS(1,i) = TruthECEF(1) - SatPPP.ECEF(1,i);
   LoS(2,i) = TruthECEF(2) - SatPPP.ECEF(2,i);
   LoS(3,i) = TruthECEF(3) - SatPPP.ECEF(3,i);
        
   LoS_unit(:,i) = LoS(:,i)/(norm(LoS(:,i)));
   
   %calculate vector from precise to broadcast
   OrbitError(1,i) = SatPPP.ECEF(1,i) - SatBC.ECEF(1,i);
   OrbitError(2,i) = SatPPP.ECEF(2,i) - SatBC.ECEF(2,i);
   OrbitError(3,i) = SatPPP.ECEF(3,i) - SatBC.ECEF(3,i);
   
   %find the amount of error which lies along line of site vector
   OrbitError_projected(i) = dot(OrbitError(:,i),LoS_unit(:,i));
end


%use SatPPP to estimate user position...
% note that tropo delay utilizes initial BC satellite positions to estimate
% delay.
L1PSR_precise = L1PSR + SatPPP.Clock - delay_iono_L1_range - delay_tropo;

[estPosECEF_precise, resid_precise,H_precise] = CalcGPSPos(L1PSR_precise,SatPPP.ECEF);

estPosLLH_precise = ECEF2LLH(estPosECEF_precise);
estPosLLH_preciseDeg = [estPosLLH_precise(1)/(pi/180);
                        estPosLLH_precise(2)/(pi/180);
                        estPosLLH_precise(3)];

error_precise = TruthECEF - [estPosECEF_precise(1); estPosECEF_precise(2); estPosECEF_precise(3)];

residNorm_precise = norm(resid_precise);