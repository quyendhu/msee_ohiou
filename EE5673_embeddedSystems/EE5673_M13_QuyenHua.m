% Quyen Hua
% EE5673
% M13-Project
% 

clear all
close all


tasks = load('tasks.dat');

util_RMS = EE5673_M13_RMSutil_QDH(tasks);
util_DMS = EE5673_M13_DMSutil_QDH(tasks);
sched_RMS = EE5673_M13_utilizationBound_QDH(tasks,util_RMS);
sched_DMS = EE5673_M13_utilizationBound_QDH(tasks,util_DMS);

disp(['with a RMS utilization of: ', num2str(util_RMS), ', the set of tasks is: ', sched_RMS])
disp(['with a DMS utilization of: ', num2str(util_DMS), ', the set of tasks is: ', sched_DMS])

%end