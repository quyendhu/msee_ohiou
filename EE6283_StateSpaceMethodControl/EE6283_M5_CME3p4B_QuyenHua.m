% % Quyen Hua
% % EE6283
% % M5
% % CME4.2B
% % 
% % Compute the OCF of system given by CME1.4, case i only.
% % 
% % Recall CME1.4
% % [x1dot; x2dot; x3dot; x4dot] = ...
% %     [0 1 0 0; 0 0 1 0; 0 0 0 1; -962 -126 -67 -4]x + [0; 0; 0; 1]u
% %  y = [100 20 10 0]*[x] + [0]u

clc
clear all


A = [0 1 0 0; 0 0 1 0; 0 0 0 1; -962 -126 -67 -4];
B = [0; 0; 0; 1];
C = [100 20 10 0];
% D = 0;

% for a system with 4 inputs, P = [B BA BA^2 BA^3]
P = [B A*B (A^2)*B (A^3)*B];

% Tccf = P*[a1 a2 a3 1 ...] with a-n being the characteristic polynomials
% get characteristic polynomial values off of A
cpA= charpoly(A);
a1 = cpA(4);
a2 = cpA(3);
a3 = cpA(2);

pp = [a1 a2 a3 1; a2 a3 1 0; a3 1 0 0; 1 0 0 0];
disp('Calculate Tccf using P*Pccf')
disp('P = ')
disp(P)
disp('Pccf = ')
disp(pp)
disp('Tccf = ')
Tccf = P*pp;
disp(Tccf)

disp('Since Tccf is the identity matrix, Controller Canonical Form of the')
disp(' specified system is simply A, B, C, and D')
disp('Accf = ')
disp(A)
disp('Bccf = ')
disp(B)
disp('Cccf = ')
disp(C)


