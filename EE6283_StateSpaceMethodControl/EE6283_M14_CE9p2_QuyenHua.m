% Quyen Hua
% EE6283
% M14
% CE9.2

% Design and evaluate a linear quadratic ragulator for the CE2.2.i.b
% system. Use equal weighting on the state and inpu. In addition to
% plotting th eopen-loop and closed-loop quadratic regulator state
% responses, separately plot the input signals. Compare with the CE7.2
% results.

clear all
close all
% recall CE2.2.i.b
% % define some stuff
t = [0:0.1:5]; %time
u = [ones(size(t))]; %step function


% Since this is a fourth order system, we will need four desired eigenvalues
% for future control law design in CE2. Use fourth order ITAE approach
%     with undamped natural frequency Wn = 3rad/s to generate four desired
%     eigenvalues.
% 
%% 

% ITAE method:
% for a fourth order system with Wn,
% s^4 + 2.1*Wn*s^3 + 3.4*Wn^2*s^2 + 2.7*Wn^3*s + Wn^4
% therefore
Wn = 3;
a0 = Wn^4;
a1 = 2.7*Wn^3;
a2 = 3.4*Wn^2;
a3 = 2.1*Wn;
a4 = 1;

denA=[a4 a3 a2 a1 a0];

desEig= roots(denA);

disp('Recall in CE7.2')
disp('Suggested eigenvalues for this system with natural freq of 3rad/s:')
disp(desEig);

desSys = tf(1,denA);
%% Compute the closed loop response
L= 0.75;
m1 = 2;
m2 = 1;
x1 = 0; %cart position
x2 = 0; %cart velocity
x3 = 0.1; %beam angle
x4 = 0; %beam angle radial velocity
u1 = 0; %applied force (unit impulse)
u2 = 0; %torque
g = 9.81;


y1a = (g*m2/m1);
h1b =g*(m1+m2)/(m1*L);

A = [0 1 0 0; 0 0 y1a 0; 0 0 0 1; 0 0 h1b 0];
B = [0; 1/(m1+m2-m2*cos(x3)^2); 0; cos(x3)/(L*m1+L*m2-L*m2*cos(x3)^2)];
C = [1 0 0 0; 0 0 1 0];
D = [0];

K2 = place(A,B,desEig);
%Create closed loop feedback system
Ac2=A-B*K2;

disp('We then have A-BK as follows:')
disp(Ac2)

X0 = [0 0 0 0]; %initial state

sysOrig = ss(A,B,C,D);
[Yo, to, Xo] = lsim(sysOrig, u, t, X0);

sysClose = ss(Ac2,B,C,D);
[Yc, tc, Xc] = lsim(sysClose, u, t, X0);
disp('With closed loop system:')
sysClose
%% now do CE9.2


%i'm not sure why i use this Q or R, I tried my best to follow text, but came up
%with no great ideas or interpretations
Qweight = 20*eye(4);
R = [1];
BB = B*inv(R)*B';
Pbar = are(A,BB,Qweight);
KLQR = inv(R)*B'*Pbar;
ALQR = A-B*KLQR;

JbkRLQR = ss(ALQR,B,C,D);
disp('Using Q:')
disp(Qweight)
disp('and R:')
disp(R)
disp('We have LQR system:')
JbkRLQR

[Ylqr, tlqr, Xlqr] = lsim(JbkRLQR,u,t,X0);

figure;
plot(tc, Yc(:,1), tc, Ylqr(:,1))
title('Angle')
legend('Closed','LQR');
xlabel('time (sec)');
ylabel('y');

figure;
plot(tc, Yc(:,2), tc, Ylqr(:,2))
title('Position')
legend('Closed','LQR');
xlabel('time (sec)');
ylabel('y');

figure;
plot(t, Xc(:,1), t, Xlqr(:,1))
title('X1')
legend('Closed','LQR');
xlabel('time (sec)');
ylabel('y');

figure;
plot(t, Xc(:,2), t, Xlqr(:,2))
title('X2')
legend('Closed','LQR');
xlabel('time (sec)');
ylabel('y');

figure;
plot(t, Xc(:,3), t, Xlqr(:,3))
title('X3')
legend('Closed','LQR');
xlabel('time (sec)');
ylabel('y');

figure;
plot(t, Xc(:,4), t, Xlqr(:,4))
title('X4')
legend('Closed','LQR');
xlabel('time (sec)');
ylabel('y');

disp('After comparing the figures, it appears that the LQR system responds');
disp('At using much smoother responses than the closed loop system');
disp('I think passengers in automated vehicles would appreciate that');
