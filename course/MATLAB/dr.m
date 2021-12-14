%% Change k, plot graph
clear; clc; format; close all;

T = 15; % Celsius
CW = 0.9;
P = 150; % kg/y

CF = 0.925;
CP = 0.995;
mu = (CP*7+(1-CP)*6)*10^(-3); 
P = P/mu / (365*24); %mol/h

%r = 0.5/100; % per cent
TT = 20; %quantity

a = 1 + 4755/(T+273)^2 - 0.803/(T+273);
e = a - 1;
k = 2;

n = 6;
syms r;
Lin = k*P*(CP-CF)/(e*CF*(1-CF));
L = 1/2*Lin*(1-r)^(TT*n)*(1+(1-r)^(-20));
x1 = 1/2*(1+P/(L*e))+sqrt(1/4*(1+P/(L*e))^2-P/(L*e)*CP);
x2 = 1/2*(1+P/(L*e))-sqrt(1/4*(1+P/(L*e))^2-P/(L*e)*CP);
c1 = ((CW-x2)/(x1-CW)*exp(TT*n*e*(x1-x2))*x1+x2)/(1+(CW-x2)/(x1-CW)*exp(TT*n*e*(x1-x2)));

n = 5;
Lin = k*P*(CP-CF)/(e*CF*(1-CF));
L = 1/2*Lin*(1-r)^(TT*n)*(1+(1-r)^(-20));
x1 = 1/2*(1+P/(L*e))+sqrt(1/4*(1+P/(L*e))^2-P/(L*e)*CP);
x2 = 1/2*(1+P/(L*e))-sqrt(1/4*(1+P/(L*e))^2-P/(L*e)*CP);
c2 = ((CW-x2)/(x1-CW)*exp(TT*n*e*(x1-x2))*x1+x2)/(1+(CW-x2)/(x1-CW)*exp(TT*n*e*(x1-x2)));

delta = c1 - c2; %disp(delta);

v = symvar(delta);
f = @(x) double(subs(delta,v,x));
r = 0.2/100:0.01/100:0.5/100;
df = f(r);
plot(r*100,df,'k.-'); grid on;
xlabel('r, %', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('dC', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('C(6)-C(5)', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');

bool = true;
i = 1;
while bool
    if (df(i) > 0)
        text = ['minimum r is ', num2str(r(i)*100), ' %'];
        disp(text);
        bool = false;
    end
    i = i +1;
    if (i > length(df)) break; end
end