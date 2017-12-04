% Quyen Hua
% EE5853
% M6

% Consider an accelerometer that has aits sensitive axis perpendicular to
% the earth's surface. You may assume that the gravity vector is also
% perpindicular to teh earth's surface. The measured acceleraction, A, is
% corrected for gravity, g(h), and integrated twice to obtain displacement.
% The true location of the accelerometer is Lat, Long, H (N39, W82, 0)

% h(t) = h(0) + integral(integral_from_0_to_tau(A-g(h))dtau.dkappa

% where g(h) ~ 9.8-3.084x10E-6*h (m/s^2)

% calculate teh vertical position error after 1000 seconds if initial
% horizontal position error is zero and teh error in vertical position is
% 10m

%display assumptions/givens
disp('our time interval is 1000 seconds, so dt = 1000')
dt = 1000;

disp('Since coordinate given is N39, W82, 0, height is 0, therefore h(0) = 0')
h0 = 0; %m

disp('Initial vertical position eror is 10m, let h = 10')
h=10; %m

disp('since the user is stationary, let A = g = 9.8m/s^2')
A = 9.8; %m/s^2

disp('therefore we have g(h) =')
gh = 9.8-(3.084E-6)*h; %m/s^2
disp(gh)

disp('double integrating the function h(t), analytically, we have:')
disp('(1/2)*(A-g(h))*t^2')

disp('therefore, we the following vertical position error:')
errorV = 0.5*(A-gh)*dt^2;
disp([num2str(errorV),'m'])
