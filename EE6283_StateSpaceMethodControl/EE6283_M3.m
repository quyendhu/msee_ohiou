% a = [-3 0; 0 -4];
% b = [1;1];
% c = [1 1];
% d = [0];
% 
% sys = ss(a,b,c,d);
% charpoly(a)
% tf(sys)
% 
% impulse(sys)

syms a0 a1 a2 b2 b1 b0
a = [0 0 -a0; 1 0 -a1; 0 1 -a2];
b = [1; 0; 0];
c = [b2 b1 b0]*inv([1 a2 a1; 0 1 a2; 0 0 1]);
d = 0



