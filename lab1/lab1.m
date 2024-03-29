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
figure(1);
plot(Uf, Jf, 'k.'); grid on;
fig2_label1 = xlabel('U', 'FontSize', 14, 'FontName', 'TimesNewRoman');
delta = Uf(length(Uf))-Uf(1); delta = delta*(1/2+1/10);
pos1 = get(fig2_label1, 'position');
pos1(1) = pos1(1) + delta;
delta = Jf(length(Jf))-Jf(1); delta = delta*(5*10^(-20000));
pos1(2) = pos1(2) - 0.025;
set(fig2_label1,'position',pos1);
fig2_label2 = ylabel('J', 'FontSize', 14, 'FontName', 'TimesNewRoman', 'rotation', 0);
pos1 = get(fig2_label2, 'position');
delta = Jf(length(Jf))-Jf(1); delta = delta*(1/2+1/8);
pos1(2) = pos1(2) + delta;
pos1(1) = pos1(1) + 0.8;
set(fig2_label2,'position',pos1);
title('Функция Бигеляйзена', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

%% Приведенные частоты 
U1 = zeros(length(T), length(w1));
for k = 1:length(T)
    for i = 1:length(w1)
        U1(k,i) = 1.44 * w1(i) / T(k);
    end
end

U2 = zeros(length(T), length(w2));
for k = 1:length(T)
    for i = 1:length(w2)
        U2(k,i) = 1.44 * w2(i) / T(k);
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
dU1 = U1 - U4;
dU2 = U2 - U3;

%% Факторы Бигеляйзена 
% f1
f1 = [];
f2 = [];
for k = 1:length(T)
    for i = 1:length(dU1)
        f1(k,i) = J1(k,i)*dU1(k,i)+J4(k,1)*dU1(k,1)+1;
    end
end

% f2
for k = 1:length(T)
    for i = 1:length(dU1)
        f2(k,i) = J2(k,i)*dU2(k,i)+J3(k,1)*dU2(k,1)+1;
    end
end
%% Значения однократного коэффициента разделения
alpha = [];
for k = 1:length(T)
    for i = 1:length(dU1)
        alpha(k,i) = f1(k,i) / f2 (k, i);
    end
end

%% График
figure(2);
plot(T, alpha(:,1), 'k.-', T, alpha(:,2), 'ro-', T, alpha(:,3), 'bs-'); grid on;
fig2_label1 = xlabel('T, К', 'FontSize', 14, 'FontName', 'TimesNewRoman');
delta = T(length(T))-T(1); delta = delta*(2/3+1/55);
pos1 = get(fig2_label1, 'position');
pos1(1) = pos1(1) + delta;
delta = alpha(length(T),1)-alpha(1,1); delta = delta/5;
pos1(2) = pos1(2) - delta;
set(fig2_label1,'position',pos1);
fig2_label2 = ylabel('\alpha', 'FontSize', 14, 'FontName', 'TimesNewRoman', 'rotation', 0);
pos1 = get(fig2_label2, 'position');
delta = alpha(length(T),1)-alpha(1,1); delta = delta*(5/2+1/5);
pos1(2) = pos1(2) - delta;
set(fig2_label2,'position',pos1);
title('Однократные коэффициенты разделения', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
legend('w_1', 'w_2', 'w_3');
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');
