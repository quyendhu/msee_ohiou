function [ H, W ] = EE6713_M6_myfreqz(B,A)
%EE6713_M6_freqz ref eq 5.87
%   Detailed explanation goes here

lenb = length(B);
lena = length(A);

K = 1024;
W = 2*pi*(0:K-1)/K;

num = 1;
den = 1;

for i = 2: lenb
    num = num.*sqrt(1+(B(i))^2 - 2*(B(i))*cos(W));
end

for i = 2: lena
    den = den.*sqrt(1+(A(i))^2 - 2*(A(i))*cos(W));

end

H = abs(B(1))*num./den;



end

