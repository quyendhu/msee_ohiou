clear all

N = 86400; %24 hours, in seconds
beta = 1/7200; %time constant is 2 hours
dt = 1; %timestep is 1 second
wnoise1 = randn(N,1); %generate unity gaussian
wnoise2 = randn(N,1); %generate unity gaussian
t= zeros(N,1);
x1 = zeros(N,1); %preallocate for speed
x1(1,1) = 0; %initial condition, 100m
t(1,1) = 0;

x2 = zeros(N,1); %preallocate for speed
x2(1,1) = 0; %initial condition, 100m

%establish noise for one range measurement
for i = 2:1:N
    t(i,1)=i;
    x1(i,1)=exp(-beta*dt)*x1(i-1,1)+wnoise1(i,1);
end

%establish noise for the other range measurement
for i = 2:1:N
    t(i,1)=i;
    x2(i,1)=exp(-beta*dt)*x2(i-1,1)+wnoise2(i,1);
end

% now, let these errors be in kilometers, so divide by 1000meters

x1km = x1/1000;
x2km = x2/1000;
% 
% now, apply these to the trilateration ranging measurements.
% let x1km be the error induced on range1 from station 1 (0,0)
% let x2km be the error induced on range2 from station 2 (50,0)

r1x = zeros(N,1);
r1y = zeros(N,1);
%convert the error to x and y components
% and add the errors together...
% since x2km is in the y direction only...
for i = 1:1:N
    rx(i,1)=50+x1km(i,1)*sind(45);
    ry(i,1)=50+r1x(i,1)+x2km(i,1);
end


hold on;
plot(rx,ry);
xlim([49,51]);
ylim([49,51]);
title('Gauss Markov error (with variance 100m) in range measurements')
xlabel('xposition (km)')
ylabel('y position (km)')

    


    