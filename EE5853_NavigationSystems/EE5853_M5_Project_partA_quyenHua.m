clear all

%proabablity given in problem statement
pe = 0.9;

%compute our H matrix using range measurements.... did it by hand...
h = [0.7071 0.7071;0 1];

temp = inv(h'*h)*300^2;
varx = temp(1,1);
vary = temp(2,2);
covxy = temp(1,2);
covyx = temp(2,1);

lambda1 = (varx+vary+sqrt(varx+vary+4*covxy))/2;
lambda2 = (varx+vary-sqrt(varx+vary+4*covxy))/2;

kappa = -2*log(1-pe);

major = sqrt(kappa*lambda1)/1000; %convert to km
minor = sqrt(kappa*lambda2)/1000;

theta = 0.5*atan(2*covxy/(varx-vary));

A = [cos(theta) sin(theta); -sin(theta) cos(theta)];
    
%create time vector
t = linspace(0,2*pi);

%compute x vector
x = major*cos(t);

%compute y vector
y = minor*sin(t);

%rotate it!
ellipse = [x;y]'*A;

%plot it! remember to add user position
hold on;
plot(ellipse(:,1)+50, ellipse(:,2)+50);
xlim([45,55]);
ylim([45,55]);
xlabel('x position (km)')
ylabel('y position (km)')
title('Error ellipse for trilateration case')