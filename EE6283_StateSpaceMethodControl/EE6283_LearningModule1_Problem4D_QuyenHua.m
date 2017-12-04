% EE6283
% Quyen Hua
% Learning Module 1, problem 4, D, MATLAB

% from the text, we have:
% 
% Y(s) = s^2 + 4s + 6
% U(s) = s^4 + 10s^3 + 11s^2 + 44s + 66

% we can then define
num = [1 4 6];
den = [1 10 11 44 66];

system4 = tf(num, den);

[A,B,C,D] = ssdata(system4);

disp('I notice that my hand calculations are much different than MATLAB')

