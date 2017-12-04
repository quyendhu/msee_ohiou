% Quyen Hua
% EE5853
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


%add the satellite clock correction SatBC.clock (m) to the measured
%pseudoranges from L1PSR

L1PSR_adjSatBC = L1PSR + SatBC.Clock;

[estPosECEF, resid, Hmatrix] = EE5853_M13_Proj_T2_ILS(L1PSR_adjSatBC,SatBC.ECEF);

% Give the user position in LLH
estPosLLH = ECEF2LLH(estPosECEF);

% Calculate the error in meters. Use ECEF format.
error = TruthECEF - [estPosECEF(1); estPosECEF(2); estPosECEF(3)];
magError = norm(error);

%probide the norm of the range residuals
residNorm = norm(resid);


