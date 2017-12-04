function [ xhat, t ] = DAC1(x, N, T)
%DAC1 Summary of this function goes here
% 
% Quyen Hua
% EE6713
% eq6,100 in textbook

% sum from 0 to N of (x[n]*Sin(pi(t-nT)/T)/ (pi(t-nT)/T)

t = 0:1:length(x);

xhat=zeros(1,length(x));
for i = 1:length(x)-N
    for n = 1:N    
        num=sin(pi*(t-n*T)/T);
        den=pi*(t-n*T)/T;
        temp = num./den;
        xhat(i) = xhat(i) + x(n)*num/den;
    end
end
end

