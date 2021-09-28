%% Практическая работа 1 по МеРСИ...
..."Расчет коэффициентов разделения и констант равновесия в процессе изотопного обмена" 
clear; clc; format; close all;

% Программа рассчитывает значение однократного коэффициента разделения
% alpha для всех предложенных значениях частот и для каждого значения
% температуры
% Реакция вида k1X1+k2X2 -> k3X3 + k4X4
% k = [k1 k2 k3 k4];
% T = [T1 T2 T3]; 

%% Исходные данные
T = [570 610 690];
w1 = [3825 1654 3936]; w3 = 1580; w2 = [3816 1648 3919]; w4 = 1490;

%% Функция Бигеляйзена 
Uf = 1:0.01:25;
Jf = 1/2 - 1./Uf + 1 ./ (exp(Uf) - 1);
plot(Uf, Jf, 'k.'); grid on;
xlabel('U', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('J', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Функция Бигеляйзена', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

%% Приведенные частоты 
U1 = zeros(length(T), length(w1));
for k = 1:length(T)
    for i = 1:length(w1)
        U1(i,k) = 1.44 * w1(i) / T(k);
    end
end

U2 = zeros(length(T), length(w2));
for k = 1:length(T)
    for i = 1:length(w2)
        U2(i,k) = 1.44 * w2(i) / T(k);
    end
end

U3 = zeros(length(T), 1);
for i = 1:length(T)
    U3(i,1) = 1.44 * w3 / T(i);
end

U4 = zeros(length(T), 1);
for i = 1:length(T)
    U4(i,1) = 1.44 * w4 / T(i);
end

%% Расчет J 
J1 = zeros(length(T), length(U1));
for k = 1:length(T)
    for i = 1:length(U1)
        J1(k,i) = 1/2 - 1/U1(k,i) + 1/(exp(U1(k,i))-1);
    end
end

J2 = zeros(length(T), length(U2));
for k = 1:length(T)
    for i = 1:length(U2)
        J2(k,i) = 1/2 - 1/U2(k,i) + 1/(exp(U2(k,i))-1);
    end
end

J3 = zeros(length(U3), 1);
for i = 1:length(U3)
    J3(i) = 1/2 - 1/U3(i) + 1/(exp(U3(i)) - 1);
end

J4 = zeros(length(U4), 1);
for i = 1:length(U4)
    J4(i) = 1/2 - 1/U4(i) + 1/(exp(U4(i)) - 1);
end

%% Расчет dUi 
dU1 = U1 - U2;
dU2 = U3 - U4;

%% Факторы Бигеляйзена 
% f1
f1 = [];
f2 = [];
for k = 1:length(T)
    for i = 1:length(dU1)
        f1(k,i) = J1(k,i)*dU1(k,i)+J3(k,1)*dU2(k,1)+1;
    end
end

% f2
for k = 1:length(T)
    for i = 1:length(dU1)
        f2(k,i) = J2(k,i)*dU1(k,i)+J4(k,1)*dU2(k,1)+1;
    end
end
%% Значения однократного коэффициента разделения
alpha = [];
for k = 1:length(T)
    for i = 1:length(dU1)
        alpha(k,i) = f1(k,i) / f2 (1, k);
    end
end