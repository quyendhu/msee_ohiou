% Quyen Hua
% EE6713
% M6
% hmwk script
clear all 
close all
%% P5.18
%a
B = [2 0 3.125];
A = [1 -0.9 0.81];

[H18a, W18a] = EE6713_M6_freqz0(B,A);
p18a = angle(H18a);
plot(W18a, H18a)
title('P5.18a, freqz0(B,A)')
xlabel('omega')
ylabel('Magnitude')
figure
plot(W18a, p18a)
title('P5.18a, angle(H)')
xlabel('omega')
ylabel('phase')
figure;

%b
B = [3.125 0 2];
A = [1 -0.9 0.81];

[H18b, W18b] = EE6713_M6_freqz0(B,A);
p18b = angle(H18b);
plot(W18b, H18b)
title('P5.18b, freqz0(B,A)')
xlabel('omega')
ylabel('Magnitude')
figure
plot(W18b, p18b)
title('P5.18b, angle(H)')
xlabel('omega')
ylabel('phase')
figure;




%% P5.36
%(a)
B = [1/2 1/2];
A = [1];
[H36a, W36a] = EE6713_M6_freqz0(B,A);
p36a = angle(H36a);
plot(W36a, H36a);
title('P5.36a, freqz0(B,A)')
xlabel('omega')
ylabel('Magnitude')
figure
plot(W36a, p36a)
title('P5.36a, angle(H)')
xlabel('omega')
ylabel('phase')

%(a)
B = [1/4 -1/4 -1/4 -1/4];
A = [1];
[H36c, W36c] = EE6713_M6_freqz0(B,A);
p36c = angle(H36c);
plot(W36c, H36c);
title('P5.36c, freqz0(B,c)')
xlabel('omega')
ylabel('Magnitude')
figure
plot(W36c, p36c)
title('P5.36c, angle(H)')
xlabel('omega')
ylabel('phase')



figure
%% P5.50 
B = [1 -2.73 3.73 -2.73 1];
A = [1 -2.46 3.02 -1.99 0.66];
% (a) use freqz
[H50a, W50a] = freqz(B,A);
plot(W50a, H50a);
title('P5.50a, freqz(B,A)')
xlabel('omega')
ylabel('Magnitude')
p50a = angle(H50a);
figure
plot(W50a, p50a)
title('P5.50a, angle(H)')
xlabel('omega')
ylabel('phase')
% (b) use freqz0 given in fig 5.12
figure;
[H50b, W50b] = EE6713_M6_freqz0(B,A);
plot(W50b, H50b);
title('P5.50b, freqz0(B,A)')
xlabel('omega')
ylabel('Magnitude')
p50b = angle(H50b);
figure
plot(W50b, p50b)
title('P5.50b, angle(H)')
xlabel('omega')
ylabel('phase')
% (c) use function based on eq 5.87
figure;
[H50c, W50c] = EE6713_M6_myfreqz(B,A);
plot(W50c, H50c);
title('P5.50c, myfreqz(B,A)')
xlabel('omega')
ylabel('Magnitude')
p50c = angle(H50c);
figure
plot(W50c, p50c)
title('P5.50c, angle(H)')
xlabel('omega')
ylabel('phase')
