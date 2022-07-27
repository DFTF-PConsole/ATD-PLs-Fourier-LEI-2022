%% MAIN

%%% Ficha Prática nº 5 de ATD 2022

%%% Objetivo: Pretende-se analisar as propriedades de sistemas lineares e 
% invariantes no tempo (SLITs) em tempo discreto, usando a Transformada de 
% Z, e determinar e representar a sua resposta a determinados sinais de 
% entrada e a sua resposta em frequência.

% Remove items from workspace, freeing up system memory
clear;

% Clear Command Window
clc;



%% 1.

%%% Exercício 1. Considerar o sistema (SLIT) caracterizado pela seguinte 
% equação de diferenças: 
% y[n]=b0x[n]+b1x[n−1]+b2x[n−2]+b3x[n−3]+b4x[n−4]−a1y[n−1]−a2y[n−2] ,
% em que: b0=0 ,  b1=0 ,  b2=0 ,  b3=0.3 ,  b4=−0.18 ,  a1=−1.5 ,  a2=0.56

PL = 6;

b0 = 0;
b1 = 0;
b2 = 0;
b3 = 0.3;
b4 = -0.18;

a0 = 1;
a1 = -1.5;
a2 = 0.56;
a3 = 0;
a4 = 0;

b = [b0 b1 b2 b3 b4];

a = [a0 a1 a2 a3 a4];



%% 1.1.

%%% Exercício 1.1. Determinar a expressão da função de transferência do 
% sistema,  G(z) .


syms z;
disp('Função de transferência G(z):');


% G(Z) = Y(Z)/X(Z)
% Y(Z) (1+a1*z^-1+a2*z^-2) = X(Z) (b3*z^-3+b4*z^-4)
Gz=(b3*z^-3+b4*z^-4)/(1+a1*z^-1+a2*z^-2);

% pretty(X): prints X in a plain-text format that resembles typeset 
% mathematics. 
pretty(Gz);




%% 1.2.

%%% Exercício 1.2. Calcular os pólos e os zeros do sistema e apresentar a 
% sua localização no plano  z .

% Polynomial roots
disp('zeros:');
zGz = roots(b);

% Polynomial roots
disp('pólos:');
pGz = roots(a);

figure(1);

% plot zplane
zplane(b, a);



%% 1.3.

%%% Exercício 1.3. Verificar, justificadamente, a estabilidade do sistema.

if all(abs(pGz) < 1)
    disp('O sistema é estável');
else
    disp('O sistema é instável');
end



%% 1.4.

%%% Exercício 1.4. Obter o ganho do sistema em regime estacionário.

disp('ganho do sistema:');

% computes the steady state gain of the discrete polynomial transfer 
% function system G(z) = NUM(z)/DEN(z) where NUM and DEN contain the 
% polynomial coefficients in descending powers of z.
ddcgain(b,a);



%% 1.5.

%%% Exercício 1.5. Determinar a expressão da resposta a impulso do sistema,  
% h[n] , com condições iniciais nulas. Para determinar a expressão de  
% h[n] , pode usar a função de cálculo simbólico iztrans, que recebendo a 
% expressão de  H(z)  obtém a expressão de  h[n]  válida para  n≥0 , ou 
% expandindo  H(z)  em frações parciais (por exemplo com o apoio da função 
% numérica residuez) e calculando  h[n]  pela transformada inversa de  Z  
% de cada parcela, sabendo que:



disp('Expressão de h[n]:');

% H(Z) = G(Z)
Hz=Gz;

% h[n]
hn = iztrans(Hz);

%pretty(hn);

% expansão em frações parciais sem o atraso puro
% r -> residuos
% p -> polos
% k -> 
[r, p, k] = residuez([b3 b4], [a0 a1 a2]);

H2z_r = z^-3*(r(1)/(1-p(1)*z^-1))+z^-3*(r(2)/(1-p(2)*z^-1));

h2n_r = iztrans(H2z_r);

%pretty(h2n_r);

nv = 0:50;

syms n;

figure(2);

stem(nv,double(subs(hn, n, nv)));
hold on;

stem(nv,double(subs(h2n_r, n, nv)),'+')
title('Resposta a impulso do sistema via iztrans (o) e residuez (+)');
xlabel('n');



%% 1.6.

%%% Exercício 1.6. Representar graficamente  h[n]  para  0≤n≤50 , usando a 
% função stem. Comparar o resultado com a saída do sistema obtida através 
% da função dimpulse.


n = 0:50;

h = double(subs(hn));

h1 = dimpulse(b, a, length(n));

figure(3);
stem(n, h, 'o');
hold on;
stem(n, h1, '+');
hold off;
title('Resposta a impulso do sistema via iztrans (o) e dimpulse (+)');
xlabel('n');



%% 1.7.

%%% Exercício 1.7. Com base na resposta a impulso do sistema,  h[n] , 
% verificar se o sistema é estável e causal.

S2=sum(abs(h));

disp(' O sistema é estável porque sum(h[n]) é finita');

disp(' O sistema é causal porque h[n]=0 para n<0');



%% 1.8.

%%% Exercício 1.8. Determinar a expressão da resposta a degrau unitário do 
% sistema,  y[n] .

syms n;

% Set symbolic preferences
sympref('HeavisideAtOrigin', 1);

% Z-transform
Xz = ztrans(heaviside(n));

disp('Transformada de z de x[n]:');
pretty(Xz);


% Y(Z) = H(Z) * X(Z)
Yz = Hz*Xz;

% Inverse Z-transform
yn = iztrans(Yz);

disp('Expressão de y[n]:');
pretty(yn);


%% 1.9.

%%% Exercício 1.9. Representar graficamente  y[n]  para  0≤n≤50 , usando a 
% função stairs. Comparar o resultado com a saída do sistema obtida 
% através da função dstep.


nv = 0:50;
y = double(subs(yn, n, nv));

% Step response of discrete-time linear systems.
% plots the response of the discrete system 
y1 = dstep(b, a, length(nv));

figure(4)
stairs(nv,y,'-o')
hold on
stairs(nv,y1,'-+')
hold off
title('Resposta a degrau do sistema via h[n] (o) e dstep (+)');
xlabel('n');


%% 1.10.

%%% Exercício 1.10. Aplicar o Teorema do Valor Final para determinar o 
% valor de  limn→∞y[n]  para a entrada em degrau unitário. Comparar com o 
% valor do ganho do sistema em regime estacionário.


disp('y[infinito]=');

yinf = double(limit((1-z^-1)*Yz,1));

yinf1 = double(limit(yn,inf));

ynd(end);



%% 1.11.

%%% Exercício 1.11. Determinar e representar graficamente a resposta do 
% sistema (usando, por exemplo, a função dlsim) à entrada  
% x[n]=3(u[n−2]−u[n−10])  para  0≤n≤50 .


syms n;

% x[n] = 3(u[n−2]−u[n−10])
xn = 3*(heaviside(n-2) - heaviside(n-10));

disp('Transformada de z de x[n]:');

% Z-transform
Xz = ztrans(xn);

% Prettyprint symbolic expressions
pretty(Xz);

% Y(Z) = H(Z) * X(Z)
Yz = Hz*Xz;

% Inverse Z-transform
yn = iztrans(Yz);

% 0≤n≤50
n = 0:50;

% subs(): Symbolic substitution
% double(): Double-precision arrays
y = double(subs(yn));
x = double(subs(xn));

% Simulation of discrete-time linear systems;
% plots the time response of the discrete system;
% dlsim(NUM,DEN,U) plots the time response of the transfer function 
% description  G(z) = NUM(z)/DEN(z)  where NUM and DEN contain the
% polynomial coefficients in descending powers of z;
y1 = dlsim(b, a, x);

figure(5);

% Stairstep graph
stairs(n, x, '-*');

% Retain current plot when adding new plots
hold on;

% Stairstep graph
stairs(n, y, '-+');
stairs(n, y1, '-o');

% Retain current plot when adding new plots
hold off;

title('Resposta do sistema a um pulso (*) via h[n] (o) e dlsim (+)');
xlabel('n');



%% 1.12.

%%% Exercício 1.12. Obter e representar graficamente (amplitude em dB e 
% fase em graus, recorrendo à função unwrap para evitar eventuais saltos 
% na sequência de valores da fase) a resposta em frequência do sistema,  
% H(Ω) , para  Ω  entre  0  e  π   rad  (com 100 elementos). Os gráficos 
% da amplitude,  |H(Ω)| , e da fase,  ∠H(Ω) , devem ser representados 
% separadamente numa mesma figura, considerando a frequência normalizada. 
% Comparar com a resposta em frequência do sistema,  H(Ω) , obtida com a 
% função freqz.

% Shift phase angles
unwrap();

% Frequency response of digital filter
freqz()


%% 1.13.

%%% Exercício 1.13. Determinar o valor de  H(0)  e comparar com o valor do 
% ganho do sistema em regime estacionário (pode usar a função ddcgain).




%% 1.14.

%%% Exercício 1.14 Determinar e representar graficamente a resposta do 
% sistema a uma entrada  x[n]=2sin[0.1πn]  , com base em  H(Ω) , para  
% 0≤n≤50 . Comparar o resultado com a saída do sistema obtida através da 
% função dlsim.







