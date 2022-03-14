%% Изучение закономерности распределения газов во вращающемся роторе центрифуги
clear; clc; format("default"); close all;

%% Данные
R = 8.32;
T = 300; % K
dT = 3; % K
v = 1500; 
ra = 0.06;
ri = 0.001;
L = 0.6;
pa = 13300;
c1 = 0.264;
c2 = 0.269;
c3 = 0.089/100;
c4 = 1.91/100;
c5 = 4.071/100;
c6 = 21.232/100;
c7 = 10.436/100;
c8 = 0.095/100;
c9 = 8.857/100;
mu1 = 129*10^(-3);
mu2 = 132*10^(-3);
mu3 = 126*10^(-3);
mu4 = 128*10^(-3);
mu5 = 130*10^(-3);
mu6 = 131*10^(-3);
mu7 = 134*10^(-3);
mu8 = 124*10^(-3);
mu9 = 136*10^(-3);

%% Расчет
mu = mu1*c1 + mu2*c2 + mu3*c3 + mu4*c4 + mu5*c5 + mu6*c6 + mu7*c7 + mu8*c8 + mu9*c9; % средний вес
disp('mu='); disp(mu);
D = 33.25*10^(-2)/pa * sqrt(T/mu); % коэффициент диффузии
disp('D='); disp(D);
p_mix = pa.*[c1, c2];
disp('p_mix='); disp(p_mix);
r = 0.03:0.01:0.06;
p = zeros(2,length(r));
for i=1:length(r)
    p(1,i) = p_mix(1)*exp(-2*pi^2*v^2*mu1*(ra^2-r(i)^2)/(R*T));
    p(2,i) = p_mix(2)*exp(-2*pi^2*v^2*mu2*(ra^2-r(i)^2)/(R*T));
end
figure(1);
plot(r,p(1,:),'ks-',r,p(2,:),'r.-'); grid on;
xlabel('r_a, м', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('p, Па', 'FontSize', 14, 'FontName', 'TimesNewRoman');

tD = (ra-ri)^2/(2*D);
t0 = L^2/(2*D);

rr = 0:0.001:0.06;
pr = zeros(2,length(rr));
for i=1:length(rr)
    pr(1,i) = p_mix(1)*exp(-2*pi^2*v^2*mu1*(ra^2-rr(i)^2)/(R*T));
    pr(2,i) = p_mix(2)*exp(-2*pi^2*v^2*mu2*(ra^2-rr(i)^2)/(R*T));
end

figure(2);
plot(rr,pr(1,:),'ks-',rr,pr(2,:),'r.-'); grid on;
xlabel('r_a, м', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('p, Па', 'FontSize', 14, 'FontName', 'TimesNewRoman');
figure(3);
subplot(1,2,1);
plot(rr(1:5),pr(1,1:5),'ks-',rr(1:5),pr(2,1:5),'r.-'); grid on;
xlabel('r_a, м', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('p, Па', 'FontSize', 14, 'FontName', 'TimesNewRoman');
subplot(1,2,2);
plot(rr(length(rr)-4:length(rr)),pr(1,length(rr)-4:length(rr)),'ks-',rr(length(rr)-4:length(rr)),pr(2,length(rr)-4:length(rr)),'r.-'); grid on;
xlabel('r_a, м', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('p, Па', 'FontSize', 14, 'FontName', 'TimesNewRoman');
figure(4);
plot(rr(57:59),pr(1,(57:59)),'ks-',rr(57:59),pr(2,57:59),'r.-'); grid on;
xlabel('r_a, м', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('p, Па', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('Точка пересечения', 'FontSize', 14, 'FontName', 'TimesNewRoman');
xlim([0.056 0.058]);