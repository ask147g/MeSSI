%% Изучение закономерности распределения газов во вращающемся роторе центрифуги
clear; clc; format("default"); close all;

%% Данные
F = [24, 22, 6, 20, 50, 170, 90, 70, 150];
ro = [7.86, 8.00, 2.70, 2.73, 8.90, 7.85, 4.6, 1.9, 1.33];
v = 1500;

%% Расчет
u = sqrt(9.8*10^3.*F./ro);
r = u./(2*pi()*v);

mu1 = 0.132;
mu2 = 0.134;
T = 300;
L = 0.6;
R = 8.32;
ra = 0.06;
raq = 0:0.01:0.1;
eta = 4*10^(-5)*sqrt((mu1+mu2)/(2*T));
qr = 27/16*pi()^5*eta*L*((mu2-mu1)/(R*T))^2.*(v*raq).^4;
figure();
plot(raq,qr); grid on;
xlabel('r_a, м', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('q, кг/с', 'FontSize', 14, 'FontName', 'TimesNewRoman');
Lq = 0:0.01:1;
qL = 27/16*pi()^5*eta.*Lq.*((mu2-mu1)/(R*T))^2*(v*ra)^4;
figure();
plot(Lq, qL); grid on;
xlabel('L, м', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('q, кг/с', 'FontSize', 14, 'FontName', 'TimesNewRoman');