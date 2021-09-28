%% Практическая работа 1 по ТКРДИС...
..."Изучение описания программного обеспечения для расчета каскадов и проведения расчетов" 
clear; clc; format; close all;

%% Данные расчета
N = [1 2 3 4]; % номер ступени
teta = [0.730842721362533 0.535364159383622 0.349634119842423 0.102340714536424]; % коэффициент деления потока
X = [2.26185114505698 2.1501816049639 2.18079009320235 2.26372692936943]; % полный коэффициент разделения ступеней
Eeff = [0.225996095897646 0.415990609208414 0.29592035176362 0.087643957341513]; % эффективная разделительная способность ступеней
Efact = [0.225996064404838 0.597018210534065 0.485282224956114 0.0876439524372612]; % фактическая разделительная способность ступеней

%% Графики 
figure(1);
plot(N, teta, 'k.-'); grid on;
xlabel('N', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('teta', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Коэффициент деления потока', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

figure(2);
plot(N, X, 'k.-'); grid on;
xlabel('N', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('X', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Полный коэффициент разделения ступеней', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

figure(3);
plot(N, Eeff, 'k.-'); grid on;
xlabel('N', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('Eeff, r/c', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Эффективная разделительная способность ступеней', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

figure(4);
plot(N, Efact, 'k.-'); grid on;
xlabel('N', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('Efact, r/c', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Фактическая разделительная способность ступеней', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');
