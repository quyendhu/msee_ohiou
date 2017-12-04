% Quyen Hua
% EE5673
% M8 MATLAB

function [ relativeCost ] = EE5673_M8_ResourceCost( percentUsage )
%EE5673_M8_ResourceCost 
%   Matlab function implements the curve shown on slide 25 of Module 8. 
% The function should take the percentage of utilization as output 
% and return the inflation factor
% input: percentUsage in %
% output: inflationFactor
% example:
% EE5673_M8_ResourceCost(80) gives output of 1.5

relativeCost = 1+0.001*(5).^(percentUsage/20);

end

