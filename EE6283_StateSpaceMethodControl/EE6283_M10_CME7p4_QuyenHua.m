% Quyen Hua
% EE6283
% M10
% CME7.4 a b
% 

% For the system given in CME1.4
% a) determine desired eigenvalues for a generic second order system to obtain
% 2 percent overshoot and 2s settling time. plot step response
% 
% b) design a state feedback control law to achieve the eigenvalue placement
% of part a. compare

% % Recall CME1.4
% % [x1dot; x2dot; x3dot; x4dot] = ...
% %     [0 1 0 0; 0 0 1 0; 0 0 0 1; -962 -126 -67 -4]x + [0; 0; 0; 1]u
% % B = [0; 0; 0; 1];
% % C = [100 20 10 0];
% % D = 0;
close all
clear all

A = [0 1 0 0; 0 0 1 0; 0 0 0 1; -962 -126 -67 -4];
B = [0; 0; 0; 1];
C = [100 20 10 0];
D = [0];

system_Orig = ss(A,B,C,D);
% 
% recall settling time follows the formula
% ts ~= 4/EWn
% 
% with percent overshoot given by:
% PO = 100e^{(-E*pi)/(sqrt(1-E^2))}

% Following example 7.2 of the text...
PO = 2; %2 percent overshoot
Tsettle = 2; %2 second settling time

Eprime = abs(log(PO/100))/sqrt(pi^2+(log(PO/100))^2);
Wnprime = 4/(Eprime*Tsettle);
Wdprime = Wnprime*sqrt(1-(Eprime)^2);

num2 = Wnprime^2;

den2 = [1 2*Eprime*Wnprime Wnprime^2];

desEig2 = [roots(den2); -20; -21];
disp('CME7.4A: Desired eigenvalues for 2% overshoot and 2s settling time:')
disp(desEig2)
des2 = tf(num2,den2);
[y1, t1, x1]= step(des2);

% now design a state feedback control law (following Chapter 7.6 of text)
K = place(A,B,desEig2');

Ac = A-B*K;
Bc = B;
Cc = C;
Dc = D;

systemA = ss(A,B,C,D);
[y0, t0, x0]= step(systemA);

desSystem = ss(Ac,Bc,Cc,Dc);
[y2, t2, x2]= step(desSystem);

% recall gain = a0prime^2/a0^2 (page 243?)
temp = charpoly(A);
a0 =temp(5);
temp = charpoly(Ac);
a0p = temp(5);

gain = a0p^2/a0^2;

figure;
plot(t2,x2(:,1)*gain, t0, x0(:,1))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_1');
figure;
plot(t2,x2(:,2)*gain, t0, x0(:,2))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_2');
figure;
plot(t2,x2(:,3)*gain, t0, x0(:,3))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_3');
figure;
plot(t2,x2(:,4)*gain, t0, x0(:,4))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_4');


disp('comparing figures, settling time is certainly reduced to 2 seconds');
disp('However, i am unsure of how to interpet overshoot.')
