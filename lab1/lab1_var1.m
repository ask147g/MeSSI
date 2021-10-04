clear;clc;
w1=[4405]; w2=[3119]; w3=[2309]; w4=[1639];
T=[940 1100 1400];
%Функция Бигеляйзена
Uf=[1:0.01:25];
Jf=1/2 - 1./Uf + 1 ./ (exp(Uf) - 1);
plot(Uf, Jf, 'k.'); grid on;
xlabel('U', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('J', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Функция Бигеляйзена', 'FontSize', 14, 'FontName', 'TimesNewRoman');
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');
%Приведенные частоты
U1 = zeros(length(T), 1);
for i = 1:length(T)
    U1(i,1) = 1.44 * w1 / T(i);
end
U2 = zeros(length(T), 1);
for i = 1:length(T)
    U2(i,1) = 1.44 * w2 / T(i);
end
U3 = zeros(length(T), 1);
for i = 1:length(T)
    U3(i,1) = 1.44 * w3 / T(i);
end
U4 = zeros(length(T), 1);
for i = 1:length(T)
    U4(i,1) = 1.44 * w4 / T(i);
end
%Расчет J
J1 = zeros(length(T), 1);
for i = 1:length(T)
    J1(i) = 1/2 - 1/U1(i) + 1/(exp(U1(i)) - 1);
end
J2 = zeros(length(T), 1);
for i = 1:length(T)
    J2(i) = 1/2 - 1/U2(i) + 1/(exp(U2(i)) - 1);
end
J3 = zeros(length(T), 1);
for i = 1:length(T)
    J3(i) = 1/2 - 1/U3(i) + 1/(exp(U3(i)) - 1);
end
J4 = zeros(length(T), 1);
for i = 1:length(T)
    J4(i) = 1/2 - 1/U4(i) + 1/(exp(U4(i)) - 1);
end
%Расчет dUi
dU2 = U2 - U3;
dU1 = U1 - U4;
%Факторы Бигеляйзена
f1 = [];
f2 = [];
for i = 1:length(T)
    f2(i,1) = J2(i,1)*dU2(i,1)+J3(i,1)*dU2(i,1)+1;
end
for i = 1:length(T)
    f1(i,1) = J1(i,1)*dU1(i,1)+J4(i,1)*dU1(i,1)+1;
end
%Занчения однократного коэффициента разделения
alpha = [];
for i = 1:length(T)
    alpha(i,1) = f1(i,1) / f2 (i,1);
end
disp(alpha);