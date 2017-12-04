% Quyen Hua
% EE5673
% M11

function [ out ] = EE5673_M11_DeadlineMonotonicSchedule( data )
%EE5673_M11_DeadlineMonotonicSchedule orders items with respect to
%deadline. if deadlines are equivalent, do additional sorting by jitter,
%where larger jitter has lower priority
%   INPUT
% Nx4 matrix, whose columens represent
% 1: message number
% 2: payload bits
% 3: jitter
% 4: deadline/period (ms)
%   OUTPUT:
% Nx4 matrix, sorted by priority
% 1: message number
% 2: payload bits
% 3: jitter
% 4: deadline/period (ms)


%initialize out matrix
[row, col] = size(data);
priority = zeros(row,1);

%sort data by deadline, store sorted signal indices.
[deadlines,signals] = sort(data(:,4));

%find all signals of with equivalent deadline
data_sorted = zeros(size(data));

%find all messages with same deadline
% migrate messages with same deadline to new matrix
%   sort new matrix by jitter
%   store sorted values into data_sorted, remember to increment top loop
index = 1;
prevDeadline = 0;
for i = 1:1:length(signals)
    %identify all data with the same deadline
    if prevDeadline ~= deadlines(i)
        temp = data(:,4)==deadlines(i);    
        %new matrix to store messages with same deadline
        temp2 = [];
        %add message to new matrix
        for j = 1:1:length(signals)
            if temp(j)==1
                temp2 = [temp2;data(j,:)];
            end
        end
        %sort messages
        [A,jitterSorted] = sort(temp2(:,3));
        %store messages into data_sorted
        for k = 1:1:length(A)
            if index <= row
                if(data_sorted(index,1) == 0 )
                    data_sorted(index,:) = temp2(jitterSorted(k),:);
%                     disp(['inserting data:' num2str(index)])
                    index = index + 1;
                end
            end
        end
        prevDeadline = deadlines(i);
    end
end

out = data_sorted;
end %end

