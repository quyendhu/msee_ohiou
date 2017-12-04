% % Quyen Hua
% % EE6283
% % M7
% % CME4.4B
% % 
% % Compute the observer canonical form of system given by CME1.4
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
D = 0;

% for a four input system, 
% a3 a2 a1 1
% a2 a1 1 0
% a1 1 0 0
% 1 0 0 0
aa = charpoly(A);
t1 = [aa(4) aa(3) aa(2) 1; aa(3) aa(2) 1 0; aa(2) 1 0 0; 1 0 0 0];

% and [C; CA; CA^2; CA^3]
t2 = [C; C*A; C*A^2; C*A^3];

Tocf = inv(t1*t2);

Aocf = inv(Tocf)*A*Tocf
Bocf = inv(Tocf)*B
Cocf = C*Tocf
Docf = [0]

disp('it appears as though duality concept cements itself when comparing the results')
disp('of the OCF vs CCF is compared. Aocf = Accf^T, Bocf = Cccf^T, Cocf = Bocf^T')



