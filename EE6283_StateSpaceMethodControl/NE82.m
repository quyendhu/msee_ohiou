% A = [0 1 0; 0 0 1; -4 -4 -1];
% B = [0; 0; 1];
% C = [1 0 0];
% curCoef = [1 4 4]
% 
% desEig = [-1, -2, -3];
% desCoef = [6 11 6];
% 
% L = inv([4 1 1; 1 1 0; 1 0 0]*eye(3))*[2; 7; 5];


% % A

A = [-1 0; 0 -4];
C = [1 1];
curCoef = [1 5 4];

desCoef = [1 40 1300];

Accf = [0 1; -4 -5];
Cccf = [0 1];


L = inv([5 1; 1 0]*[1 1; -1 -4])*[1296; 35];

AA=A-L*C;

% % B
% 
% A=[0 1; -6 -8];
% C = [1 0];
% curCoef = [1 8 6];
% 
% desCoef = [1 90 2000];
% 
% Accf = [0 1; -4 -5];
% Cccf = [0 1];
% 
% 
% L = inv([8 1; 1 0]*eye(2))*[1994; 82];
% 
% AA=A-L*C


% % C
% A=[0 1; -6 0];
% C = [1 0];
% curCoef = [1 0 6];
% 
% desCoef = [1 90 2000];
% 
% Accf = [0 1; -4 -5];
% Cccf = [0 1];
% 
% 
% L = inv([0 1; 1 0]*eye(2))*[1994; 90];
% 
% AA=A-L*C

% % % D
% A=[0 8; 1 10];
% C = [0 1];
% curCoef = [];
% 
% desCoef = [1 20 200];
% 
% 
% L = inv([-10 1; 1 0]*[0 1; 1 10])*[208; 30];
% % 
% AA=A-L*C