% Quyen Hua
% EE5673
% M7 MATLAB project
% 
% 2)	Given ?1 = 2x10-4 failures/hr and ?2 = 1x10-5 failures/hr and 
% ?t = 0.1 hr, generate a graph of the state probabilities as a function of time.
clear all
close all
format long
% create my state vector
t = 0:.1:20000;
nstep = length(t);
% initial state
%x = [1, 0, 0, 0, 0, 0, 0, 0];
x = zeros(8,nstep);
x(1,1) = 1;
A = EE5673_M7(2E-4,1E-5,0.1);
for i = 2:nstep
    x(:,i) = x(:,i-1)'*A;
end

plot(x')
legend('3,2','2,2','1,2','3,1','2,1','1,1','F1','F2')
xlabel('time (deltaT)')
ylabel('probability')
title('State Probabilities as a function of time')

% 3) calculate the steady state probability vector
[eigvector,eigI] = eig(A);

steadyState=eigvector(:,8)/norm(eigvector(:,8),1);