% % Quyen Hua
% % EE6283
% % M6
% % CME4.4B
% % 
% % Compute the Observability of system given by CME1.4
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

% for a system with 4 inputs, Q = [C ; CA ; CA^2 ; CA^3]
disp('Q = [C; C*A; C*(A^2); C*(A^3)]')
Q = [C; C*A; C*(A^2); C*(A^3)];

disp('The determinant of the Observability Matrix, Q, is equal to:')
det(Q)

disp('And the row reduced echelon form of Q is as follows:')
rref(Q)

disp('With this, we can say that the system given by CME1.4 is observable')



