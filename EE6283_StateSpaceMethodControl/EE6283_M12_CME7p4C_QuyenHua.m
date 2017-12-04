% Quyen Hua
% EE6283
% M12
% CME7.4C

% For the system in CME1.4

% c) design a state feedback servomechanism to achieve the eigenvalue
% placment of part a and a steady state output value of 1. Compare open-
% and closed-loop responses to a unit step input. in this case, normalize
% the open-loop output level to 1 for easy comparison. Were your control
% law design goals met?


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

%define some generalities
t = [0:0.1:5];
u = ones(size(t));
X0 = [0 0 0 0];
% 
%% CME7.4A,B
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

[Yo,to,Xo] = lsim(systemA,u,t,X0);


desSystem = ss(Ac,Bc,Cc,Dc);
[Yc,tc,Xc] = lsim(desSystem,u,t,X0);

%% CME7.4C

% build tthe state feedback gain vector with shape
% A'=  Ac 0
%     -Cc 0
% 
% B'= Bc
%      0

%create the closed loop state equation
temp = zeros(5,1);
A1 = [A;-C];
Af = [A1 temp];

Bf = [B;0];

Kf = place(Af,Bf,[desEig2' -220]);

%now apply gain vector to state equation
Br = [0;0;0;0;1];

Kf_ki = -Kf(5);
Kf_K = Kf(1:4);

Asf_temp = A-B*Kf_K;
Bsf_temp = B*Kf_ki;
Csf_temp = -C;

Asf_1 = [Asf_temp Bsf_temp];
Asf = [Asf_1; Csf_temp 0];

Csf = [C 0];
Dsf = [0];

sysSF = ss(Asf,Br,Csf,Dsf);

[Ysf, tsf, Xsf] = lsim(sysSF, u, t, [ 0.1 X0]);

%% normalize everything then plot
Yo_n = Yo/max(max(abs(Yo)));
Yc_n = Yc/max(max(abs(Yc)));
Ysf_n = Ysf/max(max(abs(Ysf)));

Xo_n = Xo/max(max(abs(Xo)));
Xc_n = Xc/max(max(abs(Xc)));
Xsf_n = Xsf/max(max(abs(Xsf)));

plot(tc, Ysf_n, tc, Yc_n, tc, Yo_n)
legend('State Feedback',  'Open Loop', 'Closed Loop')
xlabel('t (s)');
ylabel('Y')

figure;

plot(t, Xsf_n(:,1), t, Xo_n(:,1), t, Xc_n(:,1));
legend('State Feedback',  'Open Loop', 'Closed Loop')
xlabel('t (s)');
ylabel('x1')

figure;

plot(t, Xsf_n(:,2), t, Xo_n(:,2), t, Xc_n(:,2));
legend('State Feedback',  'Open Loop', 'Closed Loop')
xlabel('t (s)');
ylabel('x2')

figure;

plot(t, Xsf_n(:,3), t, Xo_n(:,3), t, Xc_n(:,3));
legend('State Feedback',  'Open Loop', 'Closed Loop')
xlabel('t (s)');
ylabel('x3')

figure;

plot(t, Xsf_n(:,4), t, Xo_n(:,4), t, Xc_n(:,4));
legend('State Feedback',  'Open Loop', 'Closed Loop')
xlabel('t (s)');
ylabel('x4')

%% 
%% 
disp('No, it does not appear that the control law design goals were met')
disp('Following the textbook and screencast, I cannot identify what went')
disp('incorrectly. It appears as though the solution does not settle at 1')
disp('I must doubt the construction of the state feedback system')