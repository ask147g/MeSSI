%% Практическая работа 7 по МеРСИ...
..."Расчет характеристик термодиффузионного разделения"
clear; clc; format; close all;

%% Исходные данные
T1 = 973; % К
T2 = 273; % К
ro = 1430*10^6; % г/см3
etta =  4779 * 10^8; % Па*с
w = 0.01; % м
L = 0.4; % м
D12 = 0.019;

g = 9.81;
dT = T1-T2;
T_mean = (T1-T2)/2;

% Смесь изотопов

%% Пересчет в СИ
ro = ro / 1000 * (10^6); % кг/м3

%% Максимальная скорость потока
syms X;
U = @(X) ro*g/(12*etta) * dT / (w*T_mean) * X * (w^2 - X^2);
dU = diff(sym(U),X);
dU = @(xx) double(subs(dU,X,xx));

cc = dU(0); kk = dU(1) - cc; % функция вида u = kk*x^2+cc
% Вспоминая математику класса 6 можно найти x при u=0
% x^2 = -cc/kk
% x = +- sqrt (-cc/kk)
% нас интересует только положительное значение, тогда
x_max= sqrt(abs(-cc/kk));
u_max = U(x_max);

%% Средняя скорость потока
u_mean = ro*g/(48*etta) * dT/T_mean * w^2;

%% Коэффициент разделения колонны
qe = exp(2*