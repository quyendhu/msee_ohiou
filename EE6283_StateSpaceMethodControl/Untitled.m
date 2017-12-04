Aa = [0 1; -14 -4];
Ab = [0 1; -14 4];
Ac = [0 1; 0 -4];
Ad = [0 1; -14 0];

Q = eye(2);

Aal = lyap(Aa', Q);
Abl = lyap(Ab', Q);
% Acl = lyap(Ac', Q);
Adl = lyap(Ad', Q);

