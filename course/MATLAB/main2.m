%% Course project
% from CP to CW
clear; clc; format; close all;

%% Initial data
T = 25; % Celsius
CW = 0.86;
P = 100; % kg/y

CF = 0.925;
CP = 0.995;
mu = (CP*7+(1-CP)*6)*10^(-3); 
P = P/mu / (365*24); %mol/h

r = 0.5; % per cent
TT = 20; %quantity

%% Calculations
a = 1 + 4755/(T+273)^2 - 0.803/(T+273);
e = a - 1;
%e = 0.0545;

nE = 2/e * log(CP*(1-CF) / (CF*(1-CP))); nE = ceil(nE);
nR = 2/e * log(CF*(1-CW) / (CW*(1-CF))); nR = ceil(nR);
nB = nE + nR;
N = nB / TT; N = ceil(N);

dN = 0:1:N;
dC1 = zeros(1,length(dN));
dC1(1) = CW;
for i = 2:length(dC1)
    dC1(i) = (CW/(1-CW) * exp(e*dN(i)*TT)) / (1 + CW/(1-CW) * exp(e*dN(i)*TT));
end

Lb = zeros(1,length(dN)-1);
Le = zeros(1,length(dN)-1);
x1 = zeros(1,length(dN)-1);
x2 = zeros(1,length(dN)-1);

% Math
Lin = 2 * P * (CP - CF) / (e*CF * (1-CF));
for i = 1:N
    Le(i) = Lin * (1-r/100)^(TT*i);
    Lb(i) = Lin * (1-r/100)^(TT*(i-1));
end
L = (Lb + Le) ./ 2;
%clear Le Lb;

dC2 = zeros(1,length(dN));
dC2(N+1) = CP;
for i = 2:length(dC2)
    x1(i-1) = 1/2 * (1 + P/(e*L(i-1))) + sqrt(1/4*(1+P/(e*L(i-1)))^2 - P * CP / (e*L(i-1)));
    x2(i-1) = 1/2 * (1 + P/(e*L(i-1))) - sqrt(1/4*(1+P/(e*L(i-1)))^2 - P * CP / (e*L(i-1)));
    %disp([x1 x2 dN(i)*TT]);
    dC2(i-1) = (x2(i-1) * (x1(i-1) - CP) / (CP - x2(i-1)) * exp(e*dN(N+1+2-i)*TT*(x1(i-1) - x2(i-1))) + x1(i-1)) / ( 1 + (x1(i-1) - CP) / (CP - x2(i-1)) * exp(e*dN(N+1+2-i)*TT*(x1(i-1) - x2(i-1))));
end

% Change Lin
dh = 0.00001;
k = 0;
more = 0;
while ((abs(dC2(1)-CW) > 0.000009) || dC2(1) < CW)
    more = 0;
    Lin = 2 * P * (CP - CF) / (e*CF * (1-CF));
    Lin = Lin * (1-dh*k);
for i = 1:N
    Le(i+1) = Lin * (1-r/100)^(TT*i);
    Lb(i+1) = Lin * (1-r/100)^(TT*(i-1));
end
L = (Lb + Le) ./ 2;
%clear Lin Le Lb;

dC2 = zeros(1,length(dN));
dC2(N+1) = CP;
for i = 2:length(dC2)
    x1(i-1) = 1/2 * (1 + P/(e*L(i))) + sqrt(1/4*(1+P/(e*L(i)))^2 - P * CP / (e*L(i)));
    x2(i-1) = 1/2 * (1 + P/(e*L(i))) - sqrt(1/4*(1+P/(e*L(i)))^2 - P * CP / (e*L(i)));
    dC2(i-1) = (x2(i-1) * (x1(i-1) - CP) / (CP - x2(i-1)) * exp(e*dN(N+1+2-i)*TT*(x1(i-1) - x2(i-1))) + x1(i-1)) / ( 1 + (x1(i-1) - CP) / (CP - x2(i-1)) * exp(e*dN(N+1+2-i)*TT*(x1(i-1) - x2(i-1))));
    if (dC2(i) > 1)
        more = 1;
    end
end
k = k + 1;
if more
    continue;
end
if (L(2) < 0) 
    disp('L is less then 0');
    break;
end
end
in = 2*(1-dh*k);
text = num2str(in,10);
text = ['increased in ', text];
disp(text);

figure(1);
plot(dN, dC1, 'k-o', dN, dC2, 'r-s'); grid on;
xlabel('N, column', 'FontSize', 14, 'FontName', 'TimesNewRoman');
ylabel('C', 'FontSize', 14, 'FontName', 'TimesNewRoman');
title('CONCENTRATION CHANGE', 'FontSize', 14, 'FontName', 'TimesNewRoman'); 
legend('C1', 'C2');
set(gca, 'FontSize', 14, 'FontName', 'TimesNewRoman');
dimen = [ceil(nR/TT)/N*0.8+1/8 0.9 0 -0.2];
%a = annotation('arrow','Position',dimen);

A = [1 -1; CF -dC2(1)];
B = [P; P*dC2(length(dC2))];
S = linsolve(A,B);
F = S(1); W=S(2);
clear S;
text = ['Flow F is ', num2str(F), ' mol/h'];
disp(text);
text = ['Flow W is ', num2str(W), ' mol/h'];
disp(text);