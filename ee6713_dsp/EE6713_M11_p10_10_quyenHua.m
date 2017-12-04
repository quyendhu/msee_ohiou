% quyen hua
% EE6713
% M11
% p10-10

ws = 0.3*pi;
wp = 0.5*pi;
As = 50; %dB
Ap = 0.001; %dB
% % a , taken from page 566 of textbook.
deltap = (10^(Ap/20)-1) / (10^(Ap/20)+1);
deltas = (1+deltap)/(10^(As/20));
delta = min(deltap, deltas);
A = -20*log10(delta);

Deltaw = abs(ws-wp);
omegac = (ws+wp)/2;

L = ceil(6.6*pi/Deltaw)+1;
M = L-1; %window length and order...

n = 0:M;
hd = idealhp(omegac, M);
h = hd.*hamming(L)';

% % b - use fir1
% b = fir1(40, ws/(2*pi), 'high')