% % Quyen Hua
% % EE5673
% % M11 Project

clear all
close all

data = load('messages.dat');

data_prioritized = EE5673_M11_DeadlineMonotonicSchedule(data);
data_messaged = EE5673_M11_ComputeMessageBits(data_prioritized);
data_timed = EE5673_M11_WorstCaseResponse(data_messaged);


%end