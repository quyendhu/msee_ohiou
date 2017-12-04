function [ out ] = EE5673_M11_WorstCaseResponse( data )
%EE5673_M11_WorstCaseResponse Computes the worst case response time for
%each message. Assumes prioritized message matrix provided
% Nx4 matrix, sorted by deadline, whose columens represent
% 1: message number
% 2: payload bits
% 3: jitter
% 4: deadline/period (ms)
%   OUTPUT:
% Nx5 matrix,
% 1: message number
% 2: payload bits
% 3: jitter
% 4: deadline/period (ms)
% 5: worst case response time (ms)

% assume 100kbps

[row,col] = size(data);

%prioritize data, just in case
data_prioritized = EE5673_M11_DeadlineMonotonicSchedule(data);

% calculate bits/message and bits/second. will append two columns with
% bits/message and bits/second
data_message = EE5673_M11_ComputeMessageBits(data_prioritized);


%identify the blocking message for each message based on priority
% note that blocking message is longest lower priority message by
% bits/message

blocking_message = zeros(row,1);

for i = 1:1:row-1
    %make sure not to count yourself as you own blocking message (?)
    blocking_message(i) = max(data_message((i+1:row),5));    
end
% lowest priority message has no blocking message, set this value to zero
blocking_message(row) = 0;

%now calculate number of bits to wait due to higher priority messages
% priority 1 message has no higher priority messages, ignore it
bits = zeros(row,1);

for i = 1:1:row
    for j = 1:1:i
        if i ~= j
            %formula as seen on slide 45,
            %deadline(self)/deadline(other)*BitsPerMessage
            bits(i) = bits(i) + (data_message(i,4)/data_message(j,4))*data_message(j,5);            
        end
    end
end


worst_case_time = (bits+blocking_message)/100;% assume 100kbps, output in ms

out = [data_prioritized worst_case_time];

end %end

