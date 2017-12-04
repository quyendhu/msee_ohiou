clc, clear, close all
% y[n] = x[n] + ay[n - D]; where D = tau*Fs, a is an attenuation factor
load 'handel';
% store the handel in a Xn signal to avoid confusion
Xn = y;
clear y;
tau = [50e-3 100e-3 500e-3];
a = 0.7;
B = 1;
for ii = 1:length(tau)
    D = uint16(tau(ii)*Fs);
    A = zeros(1, D);
    A(1) = 1;
    A(D) = -a;
    Yn = filter(B, A, Xn);
    sound(Yn, Fs);
    pause(10);
end
