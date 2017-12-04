% Quyen Hua
% EE6283
% M10
% CE7.2
close all
clear all
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

disp('Suggested eigenvalues for this system with natural freq of 3rad/s:')
disp(desEig);

desSys = tf(1,denA);
plot(step(desSys));
title('Desired Closed Loop Response');


%% 

% Case ia; Zero initial state, unit impulse force F(t)
L = 0.75;
m1 = 2;
m2 = 1;
x1 = 0; %cart position
x2 = 0; %cart velocity
x3 = 0; %beam angle
x4 = 0; %beam angle radial velocity
u1 = 1; %applied force (unit impulse)
u2 = 0; %torque // not used in case ia
g = 9.81;

y1a = (g*m2/m1);
h1b =g*(m1+m2)/(m1*L);

%define the system
A1 = [0 1 0 0; 0 0 y1a 0; 0 0 0 1; 0 0 h1b 0];
B1 = [0; 1/(m1+m2-m2*cos(x3)^2); 0; cos(x3)/(L*m1+L*m2-L*m2*cos(x3)^2)];
C1 = [1 0 0 0];
D1 = [0];

%find K
K1 = place(A1,B1,desEig);

%Create closed loop feedback system
Ac1=A1-B1*K1;
systemI = ss(A1,B1,C1,D1);
systemID = ss(Ac1,B1,C1,D1);
[y0, t0, x0]= step(systemI);
[yI, tI, xI]= step(systemID);

%calculate "gain"
temp = charpoly(A1);
gA0 =temp(5);
gain =10^25;% gA0^2/a0^2; %%hardcoded...gA0 (Wn') = 0....????

figure;
plot(tI,xI(:,1)*gain, t0, x0(:,1))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_1');
title('Case 1')
figure;
plot(tI,xI(:,2)*gain, t0, x0(:,2))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_2');
title('Case 1')
figure;
plot(tI,xI(:,3)*gain, t0, x0(:,3))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_3');
title('Case 1')
figure;
plot(tI,xI(:,4)*gain, t0, x0(:,4))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_4');
title('Case 1')

%% 

% case ii; inpulse input f(t), initial condition theta(t) = w(t) = 0
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
C2 = [1 0 0 0];
D2 = [0];

%find K
K2 = place(A2,B2,desEig);

%Create closed loop feedback system
Ac2=A2-B2*K2;
systemI = ss(A2,B2,C2,D2);
systemID = ss(Ac2,B2,C2,D2);
[y0, t0, x0]= step(systemI);
[yI, tI, xI]= step(systemID);

%calculate "gain"
temp = charpoly(A2);
gA0 =temp(5);
gain =10^25;% gA0^2/a0^2; %%hardcoded...????

figure;
plot(tI,xI(:,1)*gain, t0, x0(:,1))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_1');
title('Case 2')
figure;
plot(tI,xI(:,2)*gain, t0, x0(:,2))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_2');
title('Case 2')
figure;
plot(tI,xI(:,3)*gain, t0, x0(:,3))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_3');
title('Case 2')
figure;
plot(tI,xI(:,4)*gain, t0, x0(:,4))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_4');
title('Case 2')
%% 
% case iii; inpulse input f(t) and tau(t), initial condition theta(t) = w(t) = 0
L= 0.75;
m1 = 2;
m2 = 1;
x1 = 0; %cart position
x2 = 0; %cart velocity
x3 = 0; %beam angle
x4 = 0; %beam angle radial velocity
u1 = 1; %applied force (unit impulse)
u2 = 1; %torque
g = 9.81;

y1a = (g*m2/m1);
h1b =g*(m1+m2)/(m1*L);

A3 = [0 1 0 0; 0 0 y1a 0; 0 0 0 1; 0 0 h1b 0];
B3 = [0; 1/(m1+m2-m2*cos(x3)^2); 0; cos(x3)/(L*m1+L*m2-L*m2*cos(x3)^2)];
C3 = [1 0 0 0];
D3 = [0];

%find K
K3 = place(A3,B3,desEig);

%Create closed loop feedback system
Ac3=A3-B3*K3;
systemI = ss(A3,B3,C3,D3);
systemID = ss(Ac3,B3,C3,D3);
[y0, t0, x0]= step(systemI);
[yI, tI, xI]= step(systemID);

%calculate "gain"
temp = charpoly(A1);
gA0 =temp(5);
gain =10^25;% gA0^2/a0^2; %%hardcoded...????


figure;
plot(tI,xI(:,1)*gain, t0, x0(:,1))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_1');
title('Case 3')
figure;
plot(tI,xI(:,2)*gain, t0, x0(:,2))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_2');
title('Case 3')
figure;
plot(tI,xI(:,3)*gain, t0, x0(:,3))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_3');
title('Case 3')
figure;
plot(tI,xI(:,4)*gain, t0, x0(:,4))
legend('Closed Loop', 'Open Loop');
xlabel('ittime (sec)');
ylabel('x_4');
title('Case 3')

%% 

disp(' I am not sure how to interpret these charts. I had previously')
disp('assumed that the step responses would settle, but instead they')
disp('explode.')
