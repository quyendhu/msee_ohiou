% EE6283
% Quyen Hua
% Learning Module 1, Problem 2

% Submit a MATLAB® script m-file that creates a 
% state-space model for the component values L = 2H, R = 10?, C = 0.25F 
% and converts that to a transfer function model. 

clear all;
close all;


L = 2;
R = 10;
C = 0.25;

% From problem 1, we have:

A = [0 1/L; 1/C -1/(R*C)];
B = [-1/L; 0];
C = [0 1/R];
D = 0;

% define model from state space
RLC_circuit = ss(A,B,C,D);

% convert to transfer function
RLC_tf = tf(RLC_circuit);
[RLC_num, RLC_den] = tfdata(RLC_circuit, 'v');

% convert to zero pole description
% RLC_zp = zpk(RLC_circuit);
% [RLC_z, RLC_p, RLC_k] = zpkdata(RLC_circuit, 'v');


