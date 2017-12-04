function [ H, W ] = EE6713_M6_freq0( b,a )
%EE6713_M6_FREQ0 
%   ref EE6713 txtbk fig 5.12
% computation of frequency response function

K=1024;
H = fft(b,K)./fft(a,K); %0 <= W < 2pi
W = 2*pi*(0:K-1)/K;




end

