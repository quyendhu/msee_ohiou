% % Quyen Hua
% % EE5713
% % M7
% % 
% % The provided matlab function gaussian_samples.m
% % demonstrates how to use the Gaussian random number generator,
% % randn, to produce independent random samples from a Gaussian density
% % function with a user controlled mean and variance. It also shows how to 
% % plot a histogram of data samples scaled to approximate the density 
% % function. Study this function. In particular, notice the use of randn, 
% % and the plotting tricks used to control the axes, labels, and overlaying
% % of multiple plots. Modify the function as necessary to answer the 
% % following questions:
% % 
% % 
% %   1  Plot the scaled histogram and theoretical density function 
% %     for Gaussian random numbers with mean=2, variance=9, 
% %         and 100,000 sample values.
% %   2  Repeat 1 for 10,000 samples.
% %   3  Repeat 1 for 1,000 samples.
% %   4  Discuss the differences you notice in the plots.
% % 
% %   

function EE5713_M7_QuyenHua_MATLAB

%set the mean and variance

% for problem 1
mu = 2;
sig2 = 9;
sig = sqrt(sig2);

% default settings
% mu=1; 
% sig2=4;
% sig=sqrt(sig2);     %standard deviation is the sqrt of variance

sampleSize = 10000;

%generate 100000 independent samples from a gaussian density function
x=randn(sampleSize,1)*sig+mu;

%generate a histogram of the samples using bins from -10:.1:10
xbins=-10:.1:10;
xcounts=hist(x,xbins);

%scale the histogram counts to approximate a density function from the histogram
xcscaled = xcounts/(.1*sampleSize);

%create a theoretical density function for plotting, using the Gaussian pdf
%equation
fx = (1/sqrt(2*pi*sig2))*exp(-(xbins-mu).^2/(2*sig2));

%plot the scaled histogram, with theoretical overlay
figure(1), clf
bar(xbins,xcscaled,'c');
hold on
plot(xbins,fx,'r','LineWidth',2)
grid on
hold off
axis([-10 10 0 1.5*max(fx)])
xlabel('x')
ylabel('f_X(x)')
title(['\mu = ', num2str(mu), '   \sigma^2 = ', num2str(sig2)])