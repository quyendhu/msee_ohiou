function [ out ] = EE5673_M13_utilizationBound_QDH( tasks, util )
%EE5673_M13_utilizationBound_QDH calculates schedulability based on utilization
%bound test
%INPUT:
% tasks - matrix with columns defined as:
%   1. task number
%   2. worst case execution time (WCET) in ms
%   3. period (ms)
%   4. deadline (ms)
% utilization - utilization calcuation based on Rate Monotonic Scheduling
%OUTPUT:
% out - string definition of schedulability, options include:
% 'definitely schedulable'
% 'not schedulable'

[numTasks,temp] = size(tasks);

bn = numTasks*(2^(1/numTasks)-1);

if util <= bn
    out = 'definitely schedulable';
else
    out = 'not schedulable';
end


end %end

