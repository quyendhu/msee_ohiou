% % Quyen Hua
% % EE6283
% % M4
% % CME3.4A
% % 
% % Compute the controllability of system given by CME1.4
% % 
% % Recall CME1.4
% % [x1dot; x2dot; x3dot; x4dot] = ...
% %     [0 1 0 0; 0 0 1 0; 0 0 0 1; -962 -126 -67 -4]x + [0; 0; 0; 1]u

clc
clear all


A = [0 1 0 0; 0 0 1 0; 0 0 0 1; -962 -126 -67 -4];
B = [0; 0; 0; 1];

% for a system with 4 inputs, P = [B BA BA^2 BA^3]
P = [B A*B (A^2)*B (A^3)*B];

Prref = rref(P);

Prank = rank(P);

disp('Evaluating P of the the given system, the RREF form is as follows:');
Prref
if Prank == 4;
    disp('The rank of P for this system is 4, therefore the system is controllable');
end   
