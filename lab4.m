%% Лабораторная работа 4 по дисциплине "Междисциплинарный проект"...
..."Определение теплоты испарения неизвестной соли"
clear; clc; format; close all;

%% Экспериментальные данные
t = 0:0.5:9.5;
T = [41.5 41.4 41.3 41.25 41.15 41.1 41.05 41 40.9 40.7 40.45 40.3 40.15 40 39.95 39.9 39.85 39.8 39.7 39.65];
g = 3.033; % г
V = 250; % мл

%% График
figure(1);
plot(t, T, 'ko'); grid on;
hold on;
p = polyfit(t(2:9),T(2:9),1); % linear
disp('a1='); disp(p(1));
y0 = polyval(p,0:0.1:t(11));
point1 = y0(length(y0));
plot(0:0.1:t(11),y0, 'r.-'); hold off;
pp = polyfit(t(13:length(t)),T(13:length(T)),1); % linear
y0 = polyval(pp,t(11):0.1:9.5);
point2 = y0(1);
disp('a2='); disp(pp(1));
k = (p(1)+pp(1))/2;
disp('Mean a'); disp(k);
kk = num2str(k);
kk1 = num2str(p(1));
kk2 = num2str(pp(1));
cc1 = num2str(p(2));
cc2 = num2str(pp(2));
k_text = ['T=', kk, 't+[', cc1,';',cc2,']'];
text(4.1, 41.2, k_text,'FontSize', 14, 'FontName', 'Times New Roman'); % менять
k_text1 = ['T_1=', kk1, 't+', cc1];
text(0.5, 40.1, k_text1,'FontSize', 14, 'FontName', 'Times New Roman'); % менять
k_text2 = ['T_2=', kk2, 't+',cc2];
text(0.5, 39.9, k_text2,'FontSize', 14, 'FontName', 'Times New Roman'); % менять

tt = p(1)*4.5+p(2);
tt2 = pp(1)*4.5+pp(2);
dt = abs(tt2-tt);
dt2 = p(2) - pp(2);
disp('dt1='); disp(dt);
disp('dt2='); disp(dt2);

hold on;
plot(t(11):0.1:9.5, y0, 'r.-'); hold off;

hold on;
plot([5 5], [point1 point2], 'k');
text(4.2,40.4, '\Deltat', 'FontSize', 14, 'FontName', 'Times New Roman');
hold on;
ps = polyfit(t(9:13),T(9:13),4); % linear
ys = polyval(ps,t(9):0.1:t(13));
plot(t(9):0.1:t(13), ys, 'k'); 

xlabel('t, min', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('T, ^oC', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Зависимость температуры от времени', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');
