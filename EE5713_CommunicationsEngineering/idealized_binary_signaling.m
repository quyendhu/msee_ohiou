function idealized_binary_signaling

%this function is a simplified simulation of ideal polar-NRZ signaling over
%an additive white Gaussian noise channel

N=16;            %samples per bit
R=1000;         %data rate in bits per second
Tbit=1/R;       %bit time in seconds
dt=Tbit/N;      %sampling time interval in seconds
Fsamp=1/dt;     %sampling frequency in Hz.
Kbits=1000000;     %number of bits to simulate

%first, plot an example signal
data = round(rand(50,1));      %binary ones and zeros
tx_signal = data*2-1;           %polar signaling with one bit per sample
rx_signal = awgn_5713(tx_signal,0);%, 'measured');

figure(1); clf
stem(tx_signal,'b')
hold on
stem(rx_signal,'r')
hold off
grid on

%set the signal to noise ratio
Tsym=1;
Tsamp=1;
k=1;
EbNodB = 0:10;
EbNo = 10.^(.1*EbNodB);
EsNodB = EbNodB + 10*log10(k);
SNRdB = EsNodB - 10*log10(.5*Tsym/Tsamp);
M=length(EbNodB);

%simulate the system for various values of Eb/No
for m=1:M
    data = round(rand(Kbits,1));      %binary ones and zeros
    tx_signal = data*2-1;           %polar signaling with one bit per sample
    rx_signal = awgn_5713(tx_signal,SNRdB(m));%, 'measured');
    rx_decision = sign(rx_signal);
    error_count(m) = sum(tx_signal~=rx_decision);
    P_error = error_count/Kbits;
end

%plot the bit error rate curves
figure(2); clf
semilogy(EbNodB,P_error,'b*-','LineWidth',2)
hold on
semilogy(EbNodB, qfunc(sqrt(2*EbNo)),'r','LineWidth',2)
hold off
grid on
title('Ideal BPSK over AWGN channel')
xlabel('(E_b/N_0) dB')
ylabel('P(bit error)')
legend('simulated','theoretical')
axis([0 10 1e-6 1])

