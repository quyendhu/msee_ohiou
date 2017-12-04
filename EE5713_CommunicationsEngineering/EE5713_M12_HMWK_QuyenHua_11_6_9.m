% Quyen Hua
% EE5713
% M12 MATLAB
% 
% Do problem 11.6-9, using MATLAB to produce the plots. 
% Make sure to plot Pe on a log scale. Put all three curves on the same plot.
% Label your axes properly and turn in this plot.
% Set the axes to an appropriate range using the MATLAB command:
% 
%     axis([0 25 1e-6 1])

clear all
close all

EbN = 0:1:10000;


%compare teh symbol error probabilities of 16-PAM, 16-PSK, and 16-QAM
M = 16;

%16-PAM (pulse amplitude modulation)
Pem_PAM = 2*(M-1)/M*qfunc(sqrt( 6*log2(M)/(M^2-1).*EbN));

%16-PSK (phase shift keying)
% Pem_PSK = qfunc(sqrt( (2*pi^2*log2(M)/(M^2))*(EbN)));

%16-QAM (quadrature amplitude modulation)
Pem_QAM = qfunc(sqrt(((4/5)*(EbN))));

% MFSK
Pem_MFSK = zeros(1,length(EbN));
for m = 1:1:(M-1)
    disp(m)
    temp = nchoosek(M-1,m)*((-1)^(m+1)/(m+1))*exp((-m*log2(M)/(m+1))*EbN);
    Pem_MFSK = temp + Pem_MFSK;
end

% semilogy(EbN, Pem_PAM, EbN, Pem_QAM, EbN, Pem_PSK);
loglog(EbN, Pem_PAM, EbN, Pem_QAM, EbN, Pem_MFSK);
% loglog(EbN, Pem_PSK)
axis([0 1000 1e-7 1])
xlabel('Eb/N (not dB)')
ylabel('PeM')
title('EE5713 Final Question 7, Comparison of Symbol Error Probabilities of 16-ary PAM, FSK and QAM');
legend('16-PAM', '16-QAM', '16-FSK')
grid on

