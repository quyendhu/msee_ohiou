function [ X1, X2 ] = tworealDFTs( x1, x2 )
%TWOREALDFTS see problem 7.12
% Quyen Hua
% EE6713
% M8
% problem 7.12

N = length(x1); %arbitrary

W = dftmtx(N);

X1 = W*x1';
X2 = W*x2';


end

