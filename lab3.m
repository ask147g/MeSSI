%% Лабораторная работа 3 по дисциплине "Междисципоинарный проект"...
..."Изучение кинетики реакции разложения пероксида водорода"
clear; clc; format; close all;

%% Экспериментальные данные
t = [0 0.5 1 1.5 2 2.5 3 4 5 6 8 10 12 15];
V = [3 6.4 8.3 9.7 11 12.1 13 14.6 16 17 18.5 19.5 20.4 21.2];
Vinf = 24;

%% Расчет
dV = Vinf - V; % 0
logdV = log(dV); % 1
div = 1./dV; % 2

%% Графики
figure(1);
plot(t, dV, 'k.-'); grid on;
xlabel('t, min', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('V_i_n_f-V', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Реакция нулевого порядка', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

figure(2);
plot(t, logdV, 'k.-'); grid on;
xlabel('t, min', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('ln(V_i_n_f-V)', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Реакция первого порядка', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

figure(3);
plot(t, div, 'k.-'); grid on;
xlabel('t, min', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('1/(V_i_n_f-V)', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Реакция второго порядка', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

%% Аппроксимация
p = polyfit(t(5:length(t)-4),logdV(5:length(t)-4),1); % linear
y0 = polyval(p,0:0.1:15);

figure(4);
plot(t, logdV, 'ko'); grid on;
xlabel('t, min', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('ln(V_i_n_f-V)', 'FontSize', 14, 'FontName', 'TimesNewRoman');
hold on;
plot(0:0.1:15, y0, 'r.-'); hold off;
k = num2str(p(1));
c = num2str(p(2));
k_text = ['y=', k, 'x+', c];
text(9, 3.1, k_text,'FontSize', 14, 'FontName', 'Times New Roman'); % менять
title('Реакция первого порядка', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

half_life = -0.693/p(1);