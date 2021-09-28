%% Практическая работа 7 по МеРСИ...
..."Расчет кинетики процессов экстрагирования"
clear; clc; format; close all;

%% Исходные данные
x = [0.19 0.25 0.59 0.21];
y = [0.16 0.24 0.57 0.11];
Vorg = 0.26;

%% Коэффициент разделения
D = zeros(1, length(x));
for i = 1:length(x)
    D(i) = x(i)/y(i);
end

%% Извлечение на одной ступени экстракции
Vwater = 3/100*Vorg;
etta = zeros(1, length(x));
for i = 1:length(x)
    etta(i) = y(i) * Vorg / (x(i) * Vwater + y(i) * Vorg);
end

clear i;