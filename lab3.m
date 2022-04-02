%% Изучение закономерности распределения газов во вращающемся роторе центрифуги
clear; clc; format("default"); close all;

%% Данные
F = [24, 22, 6, 20, 50, 170, 90, 70, 150];
ro = [7.86, 8.00, 2.70, 2.73, 8.90, 7.85, 4.6, 1.9, 1.33];
v = 1500;

%% Расчет
u = sqrt(9.8*10^3.*F./ro);
r = u./(2*pi()*v);

%% График
mu1 = 0.132;
mu2 = 0.134;
T = 300;
R = 8.32*10^(-3);
ra = 0.06;
w = 600;
% Докритическая
L1=0.2; %м
r1=0.1; %м
% Надкритическая
L2=2; %м
r2=0.03; %м

dL = 0:0.1:3;
q1_dL = 12*dL.*(w/700)^2*(2*r1/0.12)^(0.4);
q2_dL = 12*dL.*(w/700)^2*(2*r2/0.12)^(0.4);

dr = 0:0.01:0.3;
q1_dr = 12*L1*(w/700)^2*(2*dr./0.12).^(0.4);
q2_dr = 12*L2*(w/700)^2*(2*dr./0.12).^(0.4);

dw = 300:1:700;
q1_dw = 12*L1*(dw./700).^2*(2*r1/0.12)^(0.4);
q2_dw = 12*L2*(dw./700).^2*(2*r2/0.12)^(0.4);

figure(1);
subplot(3,1,1);
plot(dL,q1_dL, dL, q2_dL); grid on;
title('Зависимость от длины', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
xlabel('L, м', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('q, ЕРР/год', 'FontSize', 14, 'FontName', 'TimesNewRoman');
legend('Докритическая', 'Надкритическая');
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

subplot(3,1,2);
plot(dr,q1_dr, dr, q2_dr); grid on;
title('Зависимость от радиуса', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
xlabel('r_a, м', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('q, ЕРР/год', 'FontSize', 14, 'FontName', 'TimesNewRoman');
legend('Докритическая', 'Надкритическая');
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

subplot(3,1,3);
plot(dw,q1_dw, dw, q2_dw); grid on;
title('Зависимость от скорости', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
xlabel('w, м/c', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('q, ЕРР/год', 'FontSize', 14, 'FontName', 'TimesNewRoman');
legend('Докритическая', 'Надкритическая');
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');