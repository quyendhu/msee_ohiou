% Quyen Hua
% EE6713
% M9
% Problem 8.1

clear all
close all
clc

V = 2:1:10;

N = 2.^V;

disp('Calculating the dftdirect of N-point complex signal x');
for i = 1:length(N)
%     disp('N = '+ r(i))
    disp('N = ')
    disp(N(i))
    x = randn(1,N) + 1i*randn(1,N);
    tic
       dftdirect(x);
    toc
end