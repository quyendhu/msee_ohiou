function bipolar_nrz_simulation

%this function is a simplified simulation of ideal polar-NRZ signaling over
%an additive white Gaussian noise channel

%set up simulation constants
R=1000;     %data rate in bits per second
Tsym=1/R;   %symbol time in seconds
N = 8;      %number of samples per bit
Tsamp=Tsym/N;    %sample time in seconds
EbNodB = 0:10;
EbNo = 10.^(.1*EbNodB);
SNRdB = EbNodB - 10*log10(.5*Tsym/Tsamp);
M=length(EbNodB);
Kbits=1e6;     %number of bits to simulate

for m=1:M
    dataX = round(rand(Kbits,1));                   %binary ones and zeros
    dataY = repmat(dataX, 1, 8);
    data = reshape(dataY',1,Kbits*N)';
    tx_signal = (data*2-1);      %full width rectangular NRZ pulses
%      tx_signal = rectpuls( (data*2-1), N);      %full width rectangular NRZ pulses
    rx_signal = awgn_5713(tx_signal,SNRdB(m));%, 'measured');  %add Gaussian noise
    t = (0:length(tx_signal)-1)*Tsamp;          %set up the time axis
    
    %first, plot an example signal of 50 bits with Eb/No set at zero dB
    if m==11
        figure(1); clf
        plot(t(1:50*N),tx_signal(1:50*N),'b','LineWidth',2)
        hold on
        plot(t(1:50*N),rx_signal(1:50*N),'r')
        hold off
        grid on
        axis([0 50*Tsym -4 4])
        legend('Transmitted signal','Received noisy signal')
        
    end
    
    %integrate the bits and compare to a threshold for data decisions
    bit_sums = sum(reshape(rx_signal,N,Kbits))';
    rx_decision = (sign(bit_sums)+1)/2;
    error_count(m) = sum(rx_decision~=dataX);
    P_error = error_count/Kbits;
end

figure(2); clf
semilogy(EbNodB,P_error,'b*-','LineWidth',2)
hold on
semilogy(EbNodB, qfunc(sqrt(2*EbNo)),'r','LineWidth',2)
hold off
grid on
title('Ideal BPSK over awgn channel')
xlabel('(E_b/N_0) dB')
ylabel('P(bit error)')
axis([0 10 1e-6 1])
legend('Simulated BER','Theoretical BER')




