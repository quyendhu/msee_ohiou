% Quyen Hua
% EE6283
% M11
% CE8.2 Case ii only
close all
clear all
% Since this is a fourth order system, we will need four desired eigenvalues
% for future control law design in CE2. Use fourth order ITAE approach
%     with undamped natural frequency Wn = 3rad/s to generate four desired
%     eigenvalues.
% 

% % define some stuff
t = [0:0.1:5]; %time
u = [ones(size(t))]; %step function

%% Desired Controlled Response

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

disp('Suggested eigenvalues for this system with natural freq of 3rad/s:')
disp(desEig);

desSys = tf(1,denA);
% plot(step(desSys));
% title('Desired Closed Loop Response');

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

A2 = [0 1 0 0; 0 0 y1a 0; 0 0 0 1; 0 0 h1b 0];
B2 = [0; 1/(m1+m2-m2*cos(x3)^2); 0; cos(x3)/(L*m1+L*m2-L*m2*cos(x3)^2)];
C2 = [1 0 0 0; 0 0 1 0];
D2 = [0];

K2 = place(A2,B2,desEig);
%Create closed loop feedback system
Ac2=A2-B2*K2;

X0 = [0 0 0 0]; %initial state

sysOrig = ss(A2,B2,C2,D2);
[Yo, to, Xo] = lsim(sysOrig, u, t, X0);

sysClose = ss(Ac2,B2,C2,D2);
[Yc, tc, Xc] = lsim(sysClose, u, t, X0);

%% Compute the observer response

obsEig = desEig*10;
disp('Amplified eignenvalues for observer');
disp(obsEig);

Qo =[C2; C2(1,:)*A2; C2(2,:)*A2; C2(1,:)*A2^2; C2(2,:)*A2^2; C2(1,:)*A2^3; C2(2,:)*A2^3];

coeffo = charpoly(A2);

L = place(A2', C2', obsEig)';


Ar = A2-L*C2;
Br = B2;
Cr = C2;
Dr = D2;

sysObs = ss(Ar, Br, Cr, Dr);
Xr0 = [0.1 0.2 0.3 0]; %different initial values so we see some difference?
[Yr, tr, Xr] = lsim(sysObs, u, t, Xr0);

%% Compare Open, Closed, and W/Observer
figure;
plot(t, Yc(:,1), t, Yr(:,1)); grid;
title('Cart Position')
legend('Closed','Observer');
xlabel('time (sec)');
ylabel('y');

figure;
plot(t, Yc(:,2), t, Yr(:,2)); grid;
title('Angle')
legend('Closed','Observer');
xlabel('time (sec)');
ylabel('y');

figure;
plot(t, Xr(:,3), t, Xr(:,4));
grid;
legend('Obs error 1', 'Obs error 2');


disp('both closed loop with state feedback and closed loop with observer responses')
disp('achieve asymptotic stability. This is vastly different than the open system')
disp('which appears to be very unstable. In this case, the observer appears to')
disp('settle at a much faster rate than the state feedback response. However, the')
disp('overshoot is much more extreme in the observer as well.')