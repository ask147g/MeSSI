%% Практическая работа 2 по МеРСИ...
..."Материальные расчеты процесса ректификации"
clear; clc; format; close all;

%% Исходные данные
x = [4.2 8.2 10.3 12.7 15.8 19.4 22.6 23.6 27.1 29.4 30.7 43.3 55 66.8 76.1 93.5];
y = [10.8 22.5 25.7 31 35.6 43.3 56.4 58 63 66 70.8 84.4 92 96.6 98.1 88.7];

t = [112.1 0 107.4 106.1 104.6 101.4 94.3 92.5 90.4 87 86 78.6 70.8 65.6 63.6 60.7];

GF = 11;
xD = 0.92;
xF = 0.52;
xW = 0.12;

M1 = 12*3+6+16;
M2 = 12*2+4+16*2;

%% Зависимость x от y
plot(y, x, 'ko-'); grid on;
xlabel('y, %', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('x, %', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Зависимость x от y ', 'FontSize', 14, 'FontName', 'TimesNewRoman');
set(gca, 'FontSize', 12, 'FontName', 'TimesNewRoman');

%% Массовые доли
MF = M1*xF + M2*(1-xF);
MW = M1*xW + M2*(1-xW);
MD = M1*xD + M2*(1-xD);

xFm = M1*xF / (M1*xF + M2* (1-xF));
xWm = M1*xW / (M1*xW + M2* (1-xW));
xDm = M1*xD / (M1*xD + M2* (1-xD));

%% Решение системы уравнений материального баланса
A = [MD MW; MD*xDm MW*xWm];
B = [GF*MF; GF*MF*xFm];
Gi = linsolve(A,B);
GD = Gi(1);
GW = Gi(2);

%% Флегмовое число
for i = 1:length(t)-1
    if (xF >= x(i)/100) && (xF < x(i+1)/100)
        yFs = y(i)/100 + (xF-x(i)/100)/(x(i+1)/100-x(i)/100)*(y(i+1)/100-y(i)/100);
        break;
    end
end
Rmin = (xD-yFs)/(yFs-xF);
R = 1.3*Rmin + 0.3;