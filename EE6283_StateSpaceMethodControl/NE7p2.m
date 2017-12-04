% NE7.2A

% % A = [-1 0; 0 -4];
% % B = [1; 1];
% % lambda1 = -2 + 3i;
% % lambda2 = -2 - 3i;
% % 
% % P = [B A*B];
% % det(P)
% % 
% % 
% % desEig = [lambda1 lambda2];
% % 
% % place(A,B,desEig)

% NE7.2B

% % A = [0 1; -6 -8];
% % B = [0; 1];
% % lambda1 = -4;
% % lambda2 = -5;
% % 
% % P = [B A*B];
% % det(P);
% % 
% % 
% % desEig = [lambda1 lambda2];
% % 
% % place(A,B,desEig)

% NE7.2C
% % A = [0 1; -6 0];
% % B = [0; 1];
% % lambda1 = -4;
% % lambda2 = -5;
% % 
% % P = [B A*B]
% % 
% % det(P);
% % 
% % 
% % desEig = [lambda1 lambda2];
% % 
% % place(A,B,desEig)
% % 


% NE7.2D
A = [0 8; 1 10];
B = [1; 0];
lambda1 = -1+i;
lambda2 = -1-i;

P = [B A*B]

det(P);


desEig = [lambda1 lambda2];

place(A,B,desEig)