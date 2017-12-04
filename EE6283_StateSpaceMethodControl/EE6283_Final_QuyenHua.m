% Quyen Hua
% EE6283
% Final Exam
% 
% The system model describes the linearized longitudinal dynamics of a
% fighter aircraft on landing approach: 
% 
% [x1dot; x2dot; x3dot] = [-0.5164 1 -0.0717; 1.4168 -0.4932 -1.6450; 0 0 -10]*[x1; x2; x3]
%                         + [0;0;10]u
%                     y = [-121.15 0 -16.821]*[x1;x2;x3]                        
% 
% with x1 = (alpha) angle of attack (rad)
%      x2 = q, pitch rate (rad/sec)
%      x3 = delta, elevator surface deflection (rad)
%      y  = normal acceleration (ft/s2)
% This system incorporates first-order elevator actuator with time constant
% tau = 0.1 sec

close all
clc
clear all
% using the system described above, we have state matrices as follows:

disp('System under evaluation is as follows:')
A = [-0.5164 1 -0.0717; 1.4168 -0.4932 -1.6450; 0 0 -10]
B = [0; 0; 10]
C = [-121.15 0 -16.821]
D = [0]

%% Step 1: Verify controllability and observability of system
disp('______________________ STEP 1 ____________________________')
% for a system with 3 inputs, P = [B BA BA^2]
disp('P = [B A*B (A^2)*B]')
P = [B A*B (A^2)*B];

disp('Evaluating P of the the given system:');
P
disp('Whose RREF form is as follows:');
rref(P)
if rank(rref(P)) == 3;
    disp('The rank of P for this system is 3, therefore the system is controllable');
    disp('  '); % line break
else
    disp('The rank of this system does not equal the number of inputs, therefore');
    disp(' this system is deemed uncontrollable');
    disp('  '); % line break
end   

% for a system with 3 inputs, Q = [C ; CA ; CA^2]
disp('Q = [C; C*A; C*(A^2)]')
Q = [C; C*A; C*(A^2)];

disp('Evaluating Q of the the given system:');
Q
disp('Whose RREF form is as follows:');
rref(Q)
if rank(rref(Q)) == 3;
    disp('The rank of Q for this system is 3, therefore the system is controllable');
    disp('  '); % line break
else
    disp('The rank of this system does not equal the number of inputs, therefore');
    disp(' this system is deemed uncontrollable');
    disp('  '); % line break
end   


%% Step 2: Assess stability without compensation
disp('______________________ STEP 2 ____________________________')
disp('The eigenvalues of the A matrix are as follows:')
eigA = eig(A)
disp('These eigenvalues imply that:')

boolEig = (eigA<=0);
if min(boolEig) == 0
    disp(' System is not stable by eigenvalue test because')
    disp(' one or more eigenvalues have a positive real component')
    disp('  '); % line break
elseif real(eigA) == 0
    disp(' System is marginally stable by eigenvalue')
    disp(' test all eigenvalues have a real component which <= 0')
    disp('  '); % line break
else
    disp(' System is stable by eigenvalue test because')
    disp(' all eigenvalues have a negative real component')
    disp('  '); % line break
end


%% Step 3: Derive the Controller Canonical and Observer Canonical Forms
disp('______________________ STEP 3 ____________________________')
% CCF
disp('Derive the Controller Canonical Form')
cpA= charpoly(A);
a1 = cpA(3);
a2 = cpA(2);

disp('Using the characteristic polynomial of A, find Pccf')
Pccf = [a1 a2 1; a2 1 0;  1 0 0]
disp('  '); % line break

disp('Calculate Tccf using P*Pccf')
Tccf = P*Pccf
disp('  '); % line break

disp('Therefore, the controller canonical form may be defined as:')
Accf = inv(Tccf)*A*Tccf
Bccf = inv(Tccf)*B
Cccf = C*Tccf
Dccf = D

disp('  '); % line break

% OCF
disp('Derive the Observer Canonical Form')
disp('Calculate Tocf using Pccf*Q')
Tocf = inv(Pccf*Q)

disp('Therefore, the observer canonical form may be defined as:')
Aocf = inv(Tocf)*A*Tocf
Bocf = inv(Tocf)*B
Cocf = C*Tocf
Docf = D

%% Step 4: Formulate performance specifications to be achieved
% include zero steady-state error for a step reference input signal and appropriate
% transient response characteristics that do not demand unrealistic control effort
disp('______________________ STEP 4 ____________________________')

disp('It may be best to observe natural system response to step input')
t = [0:0.01:10];
u = ones(size(t));
X0 = [0 0 0];

system_Orig = ss(A,B,C,D);
[Yo, to, Xo] = lsim(system_Orig, u, t, X0);
disp('well, that wasnt too terribly enlightening...')
disp('are planes supposed to accelerate on landing?')
disp('  '); % line break
disp('in any case, Id select percent overshoot of 2 and settling time of 3s')
disp(' because, on guess and check, this gave what I thought would be a ')
disp(' reasonable transient response without drastic input swings')
disp('  '); % line break

% recall settling time follows the formula
% ts ~= 4/EWn
% 
% with percent overshoot given by:
% PO = 100e^{(-E*pi)/(sqrt(1-E^2))}

% Following example 7.2 of the text...
PO = 2; %2 percent overshoot
Tsettle = 3; %4 second settling time

Eprime = abs(log(PO/100))/sqrt(pi^2+(log(PO/100))^2);
Wnprime = 4/(Eprime*Tsettle);
Wdprime = Wnprime*sqrt(1-(Eprime)^2);

numer = Wnprime^2;

denom = [1 2*Eprime*Wnprime Wnprime^2];
system_des = tf(numer,denom);
desEig = [roots(denom); -10];
[Yd, td, Xd] = lsim(system_des, u, t, X0);

disp('With selected Percent Overshoot and Settling Time, Desired Eigenvalues:')
desEig
disp('  ') %line break

%% Step 5: Design a state feedback control law
disp('______________________ STEP 5 ____________________________')

disp('Use desired eigenvalues to determine K')
K = place(A,B,desEig');

Afcl = A-B*K;
Bfcl = B;
Cfcl = C;
Dfcl = D;

system_fcl = ss(Afcl, Bfcl, Cfcl, Dfcl);

disp('State Feedback Control Law now given by:')
system_fcl
disp('  ') %line break
[Yfcl, tfcl, Xfcl] = lsim(system_fcl, u, t, X0);


%% Step 6: Design a state estimator (observer)
disp('______________________ STEP 6 ____________________________')

disp('Scale eigenvalues used in State Feedback Control Law for Observer')
obsEig = 3*desEig
disp('  ') %line break

disp('And use these observer eigenvalues to determine L');
L = place(A',C',obsEig)'


Ahat = A-L*C;
eig(Ahat);

Xr0 = [0 0 0 -0.1 0.1 -0.1];
Aobs = [(A-B*K) B*K; zeros(size(A)) (A-L*C)];
Bobs = [B; zeros(size(B))];
Cobs = [C zeros(size(C))];
Dobs = D;

disp('Now, we have Observer System given by:')
system_obs = ss(Aobs, Bobs, Cobs, Dobs)
disp('  ') %line break
[Yobs, tobs, Xobs] = lsim(system_obs, u, t, Xr0);
%% Step 7: Design an Observer-Based Type 1 Servomechanism
disp('______________________ STEP 7 ____________________________')

% build tthe state feedback gain vector with shape
% A'=  Ac 0
%     -Cc 0
% 
% B'= Bc
%      0

%create the closed loop state equation
temp = zeros(4,1);
A1 = [A;-C];
Af = [A1 temp];

Bf = [B;0];

Kf = place(Af,Bf,[desEig' -11]);

%now apply gain vector to state equation
Br = [0;0;0;0;1];

Kf_ki = -Kf(4);
Kf_K = Kf(1:3);

% build the matrix AObCL
AObCL_top = [A B*Kf_ki -B*Kf_K];
AObCL_mid = [-C zeros(1,4)];
AObCL_bot = [L*C B*Kf_ki A-B*Kf_K-L*C];

AObCL = [AObCL_top; AObCL_mid; AObCL_bot];

BObCL = [zeros(3,1);1;zeros(3,1)];

CObCL = [C zeros(1,4)];

disp('And after some crunching, we have a servomechanism described by:')
sysObCL = ss(AObCL, BObCL, CObCL, D)
disp('  ')% line break

Xobcl0 = [0 0 0 -0.1 0.2 0 0];
[YObCL, tObCL, XObCL] = lsim(sysObCL, u, t, Xobcl0);


%% PLOT EVERYTHING
disp('_____________________ AND NOW PLOTTING ____________________________')

% used to normalize plots (just kidding, i dont know how to use these)
norm_fcl = -C*inv(A-B*K)*B;
norm_open = -C*inv(A)*B;

%plot the open loop response
plot(to, Xo(:,1),to, Xo(:,2),to, Xo(:,3))
title('Open Loop State Response, Inputs X1,X2,X3')
legend('X1','X2','X3')
xlabel('Time (seconds)')
figure;

plot(to, Yo)
title('Open Loop State Response, Output Y')
xlabel('Time (seconds)')
ylabel('ft/s^2')
figure;

% plot the state feedback control response
plot(tfcl, Xfcl(:,1),tfcl, Xfcl(:,2),tfcl, Xfcl(:,3))
title('State Feedback Control Law, Inputs X1,X2,X3')
legend('X1','X2','X3')
xlabel('Time (seconds)')
figure;

plot(tfcl, Yfcl)
title('State Feedback Control Law, Output Y')
xlabel('Time (seconds)')
ylabel('ft/s^2')
figure;

% plot the state observer response and the observers
plot(tobs, Xobs(:,1),tobs, Xobs(:,2),tobs, Xobs(:,3))
title('State Estimator (Observer), Inputs X1,X2,X3')
legend('X1','X2','X3')
xlabel('Time (seconds)')
figure;

plot(tobs, Xobs(:,4),tobs, Xobs(:,5),tobs, Xobs(:,6))
title('State Estimator (Observer), Inputs X1hat,X2hat,X3hat')
legend('X1hat','X2hat','X3hat')
xlabel('Time (seconds)')
figure;

plot(tobs, Yobs)
title('State Estimator (Observer), Output Y')
xlabel('Time (seconds)')
ylabel('ft/s^2')
figure;

%plot the servomechanism response
plot(tobs,XObCL(:,1),tobs,XObCL(:,2),tobs,XObCL(:,3))
title('Observer Based Type 1 Servomechanism, Inputs X1,X2,X3')
legend('X1','X2','X3')
xlabel('Time (seconds)')
figure;

plot(tobs,XObCL(:,4))
title('Observer Based Type 1 Servomechanism, Input Xi')
legend('Xi')
xlabel('Time (seconds)')
figure;

plot(tobs,XObCL(:,5),tobs,XObCL(:,6),tobs,XObCL(:,7))
title('Observer Based Type 1 Servomechanism, Inputs X1hat,X2hat,X3hat')
legend('X1hat','X2hat','X3hat')
xlabel('Time (seconds)')
figure;

plot(tobs, YObCL)
title('Observer Based Type 1 Servomechanism, Output Y')
xlabel('Time (seconds)')
ylabel('ft/s^2')