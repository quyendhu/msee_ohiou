function [ out ] = FTA_EE5673( t_input )
%FTA_EE5673
%   Quyen Hua
%   EE5673, M4
% 
%   Write a Matlab function that implements the Fault-Tolerant Averaging (FTA) method in Matlab
%   Implements Fault-Tolerant Averaging
%   
%   INPUT:
% - ensemble of values representing different clock values as reported to some master
% ie. [1.11, 1.13, 1.10, 1.08, 1.15] in seconds
% - reference clock
%   OUTPUT:
% ensemble of corrected clock values

%grab length of incoming data (ie number of clocks)
len = size(t_input);
%initialize difference matrix (square matrix of size number of clocks)
differences = zeros(len(2));
%initialize counters
counterx = 1;
countery = 1;
%run through each clock value
for i = t_input
    %then subtract each other clock value, including self and place in
    %other matrix
    for j = t_input
        differences(countery,counterx)= i-j;
        countery = countery + 1;
    end
    counterx = counterx + 1;
    countery = 1;
end

%now average the matrix's columns
out = zeros(1,len(2));
counterx = 1;
for i = differences(:,:)
    %sort then eliminate two extreme clocks
    temp = sort(i);
    temp2 = temp(2:len(2)-1);
    %return average difference for clock
    out(counterx) = mean(temp2);
    counterx = counterx + 1;
end

%end function.
end

