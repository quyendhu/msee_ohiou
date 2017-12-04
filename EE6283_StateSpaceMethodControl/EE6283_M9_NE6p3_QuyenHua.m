% Quyen Hua
% EE6283
% M9 NE6.3
% 
% produce phase portrait (x2 vs x1) for each part

B = [0;1];
C = [1 0];
D = [0];

Aa = [0 1; -14 -4];
Ab = [0 1; -14 4];
Ac = [0 1; 0 -4];
Ad = [0 1; -14 0];

sA = ss(Aa,B,C,D);
sB = ss(Ab,B,C,D);
sC = ss(Ac,B,C,D);
sD = ss(Ad,B,C,D);

x0 = [10; 10];

[yA, tA, xA] = initial(sA,x0);

[yB, tB, xB] = initial(sB,x0);

[yC, tC, xC] = initial(sC,x0);

[yD, tD, xD] = initial(sD,x0);

figure;
plot(xA(:,2),xA(:,1))
title('Phase portrait of x2 vs x1 of NE6.3A')


figure;
plot(xB(:,2),xB(:,1))
title('Phase portrait of x2 vs x1 of NE6.3B')

figure;
plot(xC(:,2),xC(:,1))
title('Phase portrait of x2 vs x1 of NE6.3C')

figure;
plot(xD(:,2),xD(:,1))
title('Phase portrait of x2 vs x1 of NE6.3D')
