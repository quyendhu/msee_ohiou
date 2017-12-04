function [ Xdft ] = fftditr2( x )
%FFTRECUR 
%   DIT radix-2 FFT Algorithm
% ref fig 8.9 of EE6713 textbook

N = length(x);
nu = log2(N);
x = bitrevorder(x);

for m=1:nu;
    L=2^m;
    L2 = L/2;
    for ir=1:L2
        W = exp(-1i*2*pi*(ir-1)/L);
        for it = ir:L:N;
            ib = it + L2;
            temp=x(ib)*W;
            x(it) = x(it) + temp;
            x(ib) = x(it) - temp;
        end
    end
end
end