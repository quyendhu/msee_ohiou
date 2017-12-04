% Quyen Hua
% EE5853
% M11
% 
% Loran-C Hyperbolic Positioning
% 
% Assumptions:
% - World is flat and 2D
% - radio signals propagate in a straight line and at constant velocity 3e8m/s

clear all
close all

%signal propagation velocity
c = 3e8; %m/s

%Loran-C Stations:
s7139m = [0 0]; %(y, x) coordinates in km
s7139y = [0 1000];
EDy = 13000e-6; %emission delay, seconds
s7139z = [800 300];
EDz = 29000e-6;

%time difference measurements:
TDym = 13735e-6; %seconds
TDzm = 27610e-6;

%% Task 1: Draw LOPs
% draw a map with LOP for every 500us
% map must span -500km to 1500km in both x and y directions
step = 10; %km

range_min = -500; %km
range_max = 1500; %km


%adjust station position constants given to reflect 10km step and axis:
s7139m_adj = s7139m+abs(range_min)/step;
s7139y_adj = s7139y/step+abs(range_min)/step;
s7139z_adj = s7139z/step+abs(range_min)/step;


%initialize LOPs...
LOPym = zeros((range_max-range_min)/step);
LOPzm = zeros((range_max-range_min)/step);

%now, go through matrix...
for x = 1:1:(range_max-range_min)/step
    for y = 1:1:(range_max-range_min)/step
        %estimate TOAm, TOAy, TOAz
        range_m = sqrt((s7139m_adj(1)-x)^2+(s7139m_adj(2)-y)^2); %unit is 10km...
        range_y = sqrt((s7139y_adj(1)-x)^2+(s7139y_adj(2)-y)^2); %unit is 10km...
        range_z = sqrt((s7139z_adj(1)-x)^2+(s7139z_adj(2)-y)^2); %unit is 10km...

        TOAm = (range_m*step*1e3)/c; %seconds
        TOAy = EDy + (range_y*step*1e3)/c;
        TOAz = EDz + (range_z*step*1e3)/c;
        
        %estimate TDym, if equal to given, store a 1
        est_TDym = TOAy-TOAm;
        %estimate TDzm, if equal to given, store a 1
        est_TDzm = TOAz-TOAm;

        LOPym(x,y) = est_TDym;
        LOPzm(x,y) = est_TDzm;
    end
end

hold on
[~,py]=contour(LOPym, 14);
set(py,'LineColor','blue');
set(py,'LineWidth',2);
set(py,'ShowText','on');
set(py,'LabelSpacing',350);
[~,pz]=contour(LOPzm, 14);
set(pz,'LineColor','red');
set(pz,'LineWidth',2);
set(pz,'ShowText','on');
set(pz,'LabelSpacing',280);
scatter(50, 50,100,'filled','black');
text(30,40,'S7139M')
scatter(150, 50, 100,'filled', 'blue');
text(150,60,'S7139Y')
scatter(80, 130,100,'filled','red');
text(70,140,'S7139Z')

temp = -300:200:1500;
set(gca,'XTickLabel',temp);
set(gca,'YTickLabel',temp);
xlabel('X-Position (km)')
ylabel('Y-Position (km)')
title('Loran-C Hyperbolic Positioning, EE5853, M12')


scatter(85,105,100,'filled','magenta')
grid('on')