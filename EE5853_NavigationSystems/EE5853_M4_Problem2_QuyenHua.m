% Quyen Hua
% EE5853
% M4
% Problem 2
% 
% Given are two vectors:
% 
% x-vector = (6.2323    7.9905    9.4089   -9.9209    2.1204    2.3788  -10.0776   -7.4204   10.8229   -1.3150)
% 
% y-vector= (9.7413    8.7824    3.6897  -14.9571    6.1132   -6.1703   -3.0470   -2.2998    3.4275   -3.7055)
% 
%             Calculate cov (x-vector, y-vector)
%             Calculate the correlation coefficient between x-vector and y-vector.
%             Calculate the covariance of: [5 2; 2 10] x
%             covariance-matrix
%             Calculate the sample mean of x-vector and the variance of the sample mean of x-vector.
%             Calculate the sample standard deviation of x-vector and the variance of the sample standard deviation of x-vector.

%% calculate the covariance of (x,y)

x = [6.2323,7.9905,9.4089,-9.9209,2.1204, 2.3788,-10.0776,-7.4204,10.8229,-1.3150];
y = [9.7413,8.7824,3.6897,-14.9571,6.1132,-6.1703,-3.0470,-2.2998,3.4275,-3.7055];

xbar = mean(x);
ybar = mean(y);

covar=0;

for i = [1:1:10]
    covar = covar+(x(i)-xbar)*(y(i)-ybar);
end

covar = covar/9;
disp(['the covarience of x,y is : ',num2str(covar)]);

%OR, use matlab's cov function//not sure why output is 4x4...
covar_matlab=cov(x,y);

%% calculate the correlation coefficent
xs = std(x);
ys = std(y);


correl = covar/(xs*ys);
correl_matlab=corrcoef(x,y);

%% Calculate the covariance of: [5 2; 2 10] x

%cov[5 2; 2 10] x = Acov(x)At
A = [5 2;2 10];
covA = A*cov(x)*A';

disp(['the covariance of [5 2; 2 10] x = ',num2str(covA(1,2))])
%% Calculate the sample mean of x-vector and the variance of the sample mean of x-vector.

disp('the sample mean of x is: ')
disp(xbar)

disp('the variance of the sample mean is:')
disp(sqrt(xs))
%% Calculate the sample standard deviation of x-vector and the variance of the sample standard deviation of x-vector.
disp('the sample standard deviation of x is:')
disp(xs)

disp('the variance of the sample standard deviation of x is:')
disp((0.71*sqrt(xs)/sqrt(10)))
