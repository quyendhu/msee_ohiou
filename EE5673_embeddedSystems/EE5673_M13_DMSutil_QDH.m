% Quyen Hua
% EE5673
% M13

function [ out ] = EE5673_M13_DMSutil_QDH( tasks )
%EE5673_M13_DMSUTIL_QDH Calculates utilization using Deadline Monotonic
%scheduling based on given set of tasks
% INPUT
% matrix with four columns, with columns being:
% 1. task number
% 2. worst case execution time (WCET) in ms
% 3. period (ms)
% 4. deadline (ms)
% 
% OUTPUT
% row matrix with percent utilization

[numTasks,temp] = size(tasks);

%set aside space for utilization calculations, namely minimum between
%period and deadline

rate = zeros(numTasks,1);
util = zeros(numTasks,1);


%iterate through each task to determine utilization
for i = 1:1:numTasks
    %find minimum between deadline and period
    rate(i) = min(tasks(i,[3 4]));
    util(i) = tasks(i,2)/rate(i);

end

%output = sum of calculated utilizations of tasks
out = sum(util);

end %end