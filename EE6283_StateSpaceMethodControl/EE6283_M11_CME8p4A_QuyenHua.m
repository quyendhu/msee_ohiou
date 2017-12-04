% 
% Quyen Hua
% EE6283
% M11
% CME8.4A
% 
% For the system in CME1.4
% A. design an observer-based compensator using the control law of CME7.4b
% use observer error eigenvalues that are the desired state feedback eigenvalues
% of  CME7.4A scaled by 10. Compare Open Loop, Closed loop with state feedback,
% and closed loop with observer responsses to a unit step input.
% Introduce an initial observer error, otherwise, the closed loop with state
% feedback and closed loop with observer responses will be identical

close all
clear all

% define t...
t = [0:0.1:5];
u = ones(size(t));
%% 
% from CME7.4:



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
% disp('CME7.4A: Desired eigenvalues for 2% overshoot and 2s settling time:')
% disp(desEig2)
des2 = tf(num2,den2);
[y1, t1, x1]= step(des2);

% now design a state feedback control law (following Chapter 7.6 of text)
K = place(A,B,desEig2');

Ac = A-B*K;
Bc = B;
Cc = C;
Dc = D;


JbkRc = ss(Ac, Bc, Cc, Dc);
X0 = [0 0 0 0];
[Yc, tc, Xc] = lsim(JbkRc, u, t, X0);
[Yo, to, Xo] = lsim(system_Orig, u, t, X0);
%% 
%
% CME 8.4: FROM DISCUSSION BOARD
%
%  The system is not observable (recall CME4.4 (a)).
%  Insert this code to calculate an observer gain vector L.
%
%  This patch involves the notion of detectability discussed
%  in Section 8.2 of the textbook, which involves the so-called standard
%  form for unobservable state equations discussed in Ch. 4, pp. 171-173.
%
%  Detectability will be covered in Module 13.
%
%  Fill in the blank | |
%                    V V
ObsEig2         =  [ -20+1.6061i -20-1.6061i ];         % Speficify TWO eigenvalues for the
                                    % observer error dynamics, scaled by 10
q               = rank( obsv(A,C) );
Ti              = [C; C*A; 0 0 1 0; 0 0 0 1];


Ahat            = Ti * A / Ti;
Chat            = C / Ti;

Ao              = Ahat(1:q, 1:q);
Co              = Chat(1:q);

Lo              = place(Ao', Co', [ObsEig2 -200 -210])'; % this is throwing errors
Lhat            = [Lo]; %; 0; 0; 0]; #this is throwing errors for size agreement

L               = Ti \ Lhat;


Ar = [(A-B*K) B*K; zeros(size(A)) (A-L*C)];
Br = [B; zeros(size(B))];
Cr = [C zeros(size(C))];
Dr = D;

JbkRr = ss(Ar, Br, Cr, Dr);

r = [zeros(size(t))];
Xr0 = [0.1 0.2 0.4 0 0 0 0 0];
[Yr, tr, Xr] = lsim(JbkRr, r, t, Xr0);
    
%% Compare Open, Closed, and W/Observer
figure;
plot(t, Yo, 'g', t, Yc, 'r', t, Yr, 'b'); grid;
legend('Open','Closed','Observer');
xlabel('time (sec)');
ylabel('y');

figure;
plot(t, Xr(:,3), t, Xr(:,4));
grid;
legend('Obs error 1', 'Obs error 2');

disp('I am having trouble with the patch provided via discussion board.');
disp('However, I dont see a viable method to complete this problem at');
disp('time as I am unsure how to create L with an UNobservable state');

disp('observation wise, the closed response is much faster to respond to the input.');
disp('The observer errors are quite high, but that is to be exopected with such');
disp('large eigenvalues.');



