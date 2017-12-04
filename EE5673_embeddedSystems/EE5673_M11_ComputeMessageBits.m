% Quyen Hua
% EE5673
% M11

function [ out ] = EE5673_M11_ComputeMessageBits( data )
%EE5673_M11_COMPUTEMESSAGEBITS computes and returns required bits/message
%and number of bits/second for each messages in file.
%   INPUT:
% Nx4 matrix, whose columns represent
% 1: message number
% 2: payload bits
% 3: jitter
% 4: deadline/period (ms)
%   OUTPUT:
% Nx6 matrix
% 1: message number
% 2: payload bits
% 3: jitter
% 4: deadline/period (ms)
% 5: bits/message
% 6: bits/second

%initialize out matrix
[row, col] = size(data);
bits = zeros(row,2);

for i = 1:1:row
    %calculate bytes required
    byte = ceil(data(i,2)/8);
    %use formula provided in lecture notes
    bits(i,1) = round((54+8*byte)/4)+67+8*byte;
    %multiply bits/message by frequency (1/deadline)
    bits(i,2) = bits(i,1)*(1/(data(i,4)*1e-3));
end

out = [data bits];

end %end

