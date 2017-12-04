% Quyen Hua
% EE5713
% M10 - MATLAB
% 
% Use MATLAB to plot your solution for problems 9.6-1a and 9.6-2a

% IE plot Hopt(f)

%recall Hopt = Sm(f) / [Sm(f)+Sn(f)]

close all
clear all



%% 9.6-1a
freq1 = -5e2:1:5e2; %Bandwidth 1kHz sufficient?
Sm1 = 20./(900+(2*pi*freq1).^2);
Sn1 = 6*rectpuls(freq1/200);

Hopt1 = Sm1./ (Sm1+Sn1);

subplot(3,1,1);
plot(Sm1);
set(gca, 'XTickLabel', [-500:1000/5: 500+1000/5]);
ylabel('Sm(f)');
title('9.6-1a');
grid on;

subplot(3,1,2);
plot(Sn1);
set(gca, 'XTickLabel', [-500:1000/5: 500+1000/5]);%freq1);
ylabel('Sn(f)')
ylim([-1 7]);
grid on;

subplot(3,1,3);
plot(Hopt1);
set(gca, 'XTickLabel', [-500:1000/5: 500+1000/5]);%freq1);
ylabel('Hopt(f)')
ylim([-1 2]);
grid on;
xlabel('Frequency (Hz)');



%% 9.6-2a

freq2 = -1e2:1:1e2; %Bandwidth 1kHz sufficient?
Sm2 = 4./(4+(2*pi*freq2).^2);
Sn2 = 32./(64+(2*pi*freq2).^2);

Hopt2 = Sm2./ (Sm2+Sn2);

figure;
subplot(3,1,1);
plot(Sm2);
set(gca, 'XTickLabel', [-100 -50 0 50 100 150]);%freq2);
% ax = gca;
% ax.XTick = [-100, 50, 0, 50, 100];
ylabel('Sm(f)');
title('9.6-2a');
grid on;

subplot(3,1,2);
plot(Sn2);
set(gca, 'XTickLabel', [-100 -50 0 50 100 150]);
ylabel('Sn(f)')
ylim([-0.5 0.8]);
grid on;

subplot(3,1,3);
plot(Hopt2);
set(gca, 'XTickLabel', [-100 -50 0 50 100 150]);
ylabel('Hopt(f)')
ylim([0 1]);
grid on;
xlabel('Frequency (Hz)');

% END
syms f;
% tSm1 = 20./(900+(2*pi*f).^2);
% tSn1 = 6*rectpuls(f/200);
% 
% tNo1 = (tSm1.*tSn1)./ (tSm1+tSn1);



tSm2 = 4./(4+(2*pi*f).^2);
tSn2 = 32./(64+(2*pi*f).^2);

tNo2 = (tSm2.*tSn2)./ (tSm2+tSn2);

