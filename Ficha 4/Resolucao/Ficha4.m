%% MAIN

%%% Ficha Prática nº 4 de ATD 2022

%%% Objetivo: Pretende-se adquirir sensibilidade para as questões 
% fundamentais de sinais e sistemas, em particular para as propriedades 
% de sinais e de sistemas lineares em tempo discreto, como a linearidade, 
% a invariância e a resposta a impulso.

% Remove items from workspace, freeing up system memory
clear;

% Clear Command Window
clc;



%% 1.

%%% Exercício 1. Implementar um script em Matlab que receba um sinal x[n] e 
% devolva a resposta do sistema caracterizado pela seguinte equação de 
% diferenças: y[n]=b0x[n]+b1x[n−1]+b2x[n−2]+b3x[n−3]+b4x[n−4] , em que:
% b0=0.1(mod(PL#,2)+1) ,  b1=0.4mod(PL#,2) ,  b2=0.4mod(1+PL#,2) ,  
% b3=0.3(mod(PL#,3)+1) ,  b4=−0.1(mod(PL#,4)+1)

PL = 6;

b0 = 0.1 * (mod(PL, 2) + 1);
b1 = 0.4 * (mod(PL, 2) + 2);
b2 = 0.4 * (mod(1 + PL, 2) + 2);
b3 = 0.3 * (mod(1 + PL, 3) + 1);
b4 = -0.1 * (mod(PL, 4) + 1);

b = [b0 b1 b2 b3 b4];



%% 1.1.

%%% Exercício 1.1 Definindo, através duma função, o sinal  
% x[n]=1.5sin[0.025πn](u[n+40]−u[n−40]) , em que o sinal  u[n−m]  é 
% um degrau unitário que tem o valor 0 para  n<m  e o valor 1 para  n≥m , 
% obter e representar graficamente o sinal de entrada  x[n]  e a resposta 
% do sistema,  y[n] , para  −50≤n<50 .


%%% ***** NUMERICO ***** :

% −50 ≤ n < 50, [-50 -49 -48 -47 ... -1 0 1 2 ... 47 48 49]
n = -50:49;

% tempo discreto com a memória necessária para o sistema, x[n−4] -> -50 -> -54
m = -54:49; 

% determinar a entrada
x_n = entradaSistema(m);

% y[n] = b0x[n] + b1x[n−1] + b2x[n−2] + b3x[n−3] + b4x[n−4] 
y_n = b0 * x_n(5:end) + b1 * x_n(4:end-1) + b2 * x_n(3:end-2) + b3 * x_n(2:end-3) + b4 * x_n(1:end-4);

figure();
plot(n, x_n(5:end), '-+', n, y_n, '-o');
xlabel('n');
title('[NUMERICO] Resposta do sistema ao sinal sem ruído');
legend('x[n]', 'y[n]', 'Location', 'northwest');



%%% ***** SIMBOLICO ***** :

% Set symbolic preferences
oldparam = sympref('HeavisideAtOrigin', 1);

% Create symbolic scalar variables and functions
syms n;

% heaviside(): unit step function (degrau)
% x[n]=1.5sin[0.025πn](u[n+40]−u[n−40])
x_n_syms = (1.5 * sin(0.025 * pi * n)) * (heaviside(n+40) - heaviside(n-40));

% y[n] = b0x[n] + b1x[n−1] + b2x[n−2] + b3x[n−3] + b4x[n−4] 
y_n_syms = b0 * x_n_syms + b1 * subs(x_n_syms, n-1) + b2 * subs(x_n_syms, n-2) + b3 * subs(x_n_syms, n-3) + b4 *subs(x_n_syms, n-4);

% −50 ≤ n < 50, [-50 -49 -48 -47 ... -1 0 1 2 ... 47 48 49]
n = -50:49;

% subs(): Symbolic substitution
% double(): Double-precision arrays
x_n_syms_num = double(subs(x_n_syms));
y_n_syms_num = double(subs(y_n_syms));

figure();
plot(n, x_n_syms_num, '-+', n, y_n_syms_num, '-o');
xlabel('n');
title('[SIMBOLICO] Resposta do sistema ao sinal sem ruído');
legend('x[n]', 'y[n]', 'Location', 'northwest');



%% 1.2.

%%% Exercício 1.2 Adicionar ao sinal  x[n] , definido em 1.1, ruído uniforme 
% com amplitude no intervalo  [−0.2,0.2] . Utilize a função rand do Matlab. 
% Obter e representar graficamente o sinal de entrada  x[n]  com ruído e a 
% correspondente resposta do sistema,  y[n] , para  −50≤n<50 .


%%% ***** NUMERICO ***** :

% Uniformly distributed random numbers
x_n_ruido = x_n + 0.4*rand(size(x_n)) - 0.2;

% y[n] = b0x[n] + b1x[n−1] + b2x[n−2] + b3x[n−3] + b4x[n−4] 
y_n_ruido = b0*x_n_ruido(5:end) + b1*x_n_ruido(4:end-1) + b2*x_n_ruido(3:end-2) + b3*x_n_ruido(2:end-3) + b4*x_n_ruido(1:end-4);

figure();
plot(n, x_n(5:end), n, x_n_ruido(5:end), n, y_n, n, y_n_ruido);
xlabel('n');
title('[NUMERICO] Resposta do sistema ao sinal com e sem ruído');
legend('x[n]', 'y[n]', 'xr[n]', 'yr[n]', 'Location', 'northwest');



%%% ***** SIMBOLICO ***** :

% Create symbolic scalar variables and functions
syms n;

% heaviside(): unit step function (degrau)
% x[n]=1.5sin[0.025πn](u[n+40]−u[n−40])
x_n_syms = (1.5 * sin(0.025 * pi * n)) * (heaviside(n+40) - heaviside(n-40));

% tempo discreto com a memória necessária para o sistema, x[n−4] -> -50 -> -54
m = -54:49; 

% Uniformly distributed random numbers
x_n_ruido_syms_num = double(subs(x_n_syms, m)) + 0.4*rand(size(m)) - 0.2;

% y[n] = b0x[n] + b1x[n−1] + b2x[n−2] + b3x[n−3] + b4x[n−4] 
y_n_ruido_syms_num = b0*x_n_ruido_syms_num(5:end) + b1*x_n_ruido_syms_num(4:end-1) + b2*x_n_ruido_syms_num(3:end-2) + b3*x_n_ruido_syms_num(2:end-3) + b4*x_n_ruido_syms_num(1:end-4);

figure();
plot(m(5:end), x_n_syms_num, m(5:end), x_n_ruido_syms_num(5:end), m(5:end), y_n_syms_num, m(5:end), y_n_ruido_syms_num);
xlabel('n');
title('[SIMBOLICO] Resposta do sistema ao sinal com e sem ruído');
legend('x[n]', 'y[n]', 'xr[n]', 'yr[n]', 'Location', 'northwest');



%% 1.3.

%%% Exercício 1.3 Comparar, analisar e comentar os resultados obtidos em 1.1 
% e em 1.2.

%%% RESPOSTA:
% A adição de ruído ao sinal de entrada do sistema refletiu-se na 
% sua saída e é, neste caso, amplificado tal como o sinal original



%% 2.

%%% Exercício 2. Considerar o sinal de tempo discreto  
% x[n]=1.5sin[0.025πn](u[n+40]−u[n−40]) , o sistema  y1[n] , dado pela 
% equação de diferenças  y[n] , e os seguintes sistemas de tempo discreto:
% y2[n]=0.6x[2n−4];
% y3[n]=0.5x[n−2]x[n−3];
% y4[n]=(n−2)x[n−3].


%% 2.1.

% Exercício 2.1 Determinar e apresentar a resposta dos sistemas ao sinal 
% de entrada x[n] , para −50≤n≤50.


% [n_alterado, x_n_alterado] = transformacaoLinear(n, x_n, a, b)



%% 2.2.

%%% Exercício 2.2 Analisar a linearidade dos sistemas dados por  y1[n] ,  
% y2[n] ,  y3[n]  e  y4[n] .


%%% ***** SIMBOLICO ***** :

% Create symbolic scalar variables and functions
syms n x1(n) x2(n) a;

% Set assumption on symbolic object
assume(n, 'integer');



%%% Verificar a linearidade do sistema dado por y1[n]
% y1[n] = b0x[n] + b1x[n−1] + b2x[n−2] + b3x[n−3] + b4x[n−4] 

% 1º -> y1[n] = T{x1[n]}, y2[n] = T{x2[n]}
y1_1_n = b0*x1(n) + b1*x1(n-1) + b2*x1(n-2) + b3*x1(n-3) + b4*x1(n-4);
y1_2_n = b0*x2(n) + b1*x2(n-1) + b2*x2(n-2) + b3*x2(n-3) + b4*x2(n-4);

% 2º -> y[n] = T{x1[n] + x2[n]}
y1_a1a2_n = b0*a*(x1(n) + x2(n)) + b1*a*(x1(n-1) + x2(n-2)) + b2*a*(x1(n-2) + x2(n-2)) + b3*a*(x1(n-3) + x2(n-3)) + b4*a*(x1(n-4) + x2(n-4));

% 3º -> y_c[n] = a * (y1[n] + y2[n])
y1_c_n = a*(y1_1_n + y1_2_n);

% 4º -> Comparar
% expand(): Expand tree node
% simplify(): Algebraic simplification
if simplify(expand(y1_c_n)) == simplify(expand(y1_a1a2_n))
    disp('y1[n] é Linear');
else 
    disp('y1[n] é Não linear');
end



%%% Verificar a linearidade do sistema dado por y2[n]
% y2[n] = 0.6x[2n−4]

% 1º -> y1[n] = T{x1[n]}, y2[n] = T{x2[n]}
y2_1_n = 0.6*x1(2*n-4);
y2_2_n = 0.6*x2(2*n-4);

% 2º -> y[n] = T{x1[n] + x2[n]}
y2_a1a2_n = 0.6*a*(x1(2*n-4) + x2(2*n-4));

% 3º -> y_c[n] = a * (y1[n] + y2[n])
y2_c_n = a*(y2_1_n + y2_2_n);

% 4º -> Comparar
% expand(): Expand tree node
% simplify(): Algebraic simplification
if simplify(expand(y2_c_n)) == simplify(expand(y2_a1a2_n))
    disp('y2[n] é Linear');
else 
    disp('y2[n] é Não linear');
end



%%% Verificar a linearidade do sistema dado por y3[n]
% y3[n] = 0.5x[n−2] * x[n−3]

% 1º -> y1[n] = T{x1[n]}, y2[n] = T{x2[n]}
y3_1_n = 0.5*x1(n-2)*x1(n-3);
y3_2_n = 0.5*x2(n-2)*x2(n-3);

% 2º -> y[n] = T{x1[n] + x2[n]}
y3_a1a2_n = 0.5*a*(x1(n-2) + x2(n-2))*a*(x1(n-3) + x2(n-3));

% 3º -> y_c[n] = a * (y1[n] + y2[n])
y3_c_n = a*(y3_1_n + y3_2_n);

% 4º -> Comparar
% expand(): Expand tree node
% simplify(): Algebraic simplification
if simplify(expand(y3_c_n)) == simplify(expand(y3_a1a2_n))
    disp('y3[n] é Linear');
else 
    disp('y3[n] é Não linear');
end



%%% Verificar a linearidade do sistema dado por y4[n]
% y4[n] = (n−2) * x[n−3]

% 1º -> y1[n] = T{x1[n]}, y2[n] = T{x2[n]}
y4_1_n = (n-2)*x1(n-3);
y4_2_n = (n-2)*x2(n-3);

% 2º -> y[n] = T{x1[n] + x2[n]}
y4_a1a2_n = (n-2)*a*(x1(n-3) + x2(n-3));

% 3º -> y_c[n] = a * (y1[n] + y2[n])
y4_c_n = a*(y4_1_n + y4_2_n);

% 4º -> Comparar
% expand(): Expand tree node
% simplify(): Algebraic simplification
if simplify(expand(y4_c_n)) == simplify(expand(y4_a1a2_n))
    disp('y4[n] é Linear');
else 
    disp('y4[n] é Não linear');
end



%% 2.3.

%%% Exercício 2.3 Analisar a Invariância no tempo dos sistemas dados por  
% y1[n] ,  y2[n] ,  y3[n]  e  y4[n] .


%%% RESPOSTA:
% y1[n] é invariante no tempo
% y2[n] é variante no tempo
% y3[n] é invariante no tempo
% y4[n] é variante no tempo



%% 2.4.

%%% Exercício 2.4 Determinar a expressão e representar graficamente a 
% resposta a impulso do sistema  h1[n] .

% Obtenção da saída do sistema y2[n]

% −50 ≤ n < 50, [-50 -49 -48 -47 ... -1 0 1 2 ... 47 48 49]
n = -50:49;

% y[n] = b0x[n] + b1x[n−1] + b2x[n−2] + b3x[n−3] + b4x[n−4] 
y1_n = b0 * x_n(5:end) + b1 * x_n(4:end-1) + b2 * x_n(3:end-2) + b3 * x_n(2:end-3) + b4 * x_n(1:end-4);

% transformação linear da variável independentede de um sinal de tempo discreto
% x[n] -> x[a*n - b]
[n_alterado, x_n_alterado] = transformacaoLinear(n, x_n(5:end), 2, 4);

% y2[n] = 0.6x[2n−4]
y2_n = 0.6*x_n_alterado;

% y3[n] = 0.5x[n−2]x[n−3]
y3_n = 0.5*x_n(3:end-2).*x_n(2:end-3);

% y4[n] = (n−2)x[n−3]
y4_n = m(3:end-2).*x_n(2:end-3);


figure();
subplot;
plot(n, x_n(5:end), '.', n_alterado, x_n_alterado, '.');
title('Transformação linear da variável independente de x');
xlabel('n');
legend('x[n]', 'x_transf[n]', 'Location', 'northwest');

figure();
subplot(411);
plot(n, x_n(5:end), '.', n, y1_n, '.');
title('Resposta do sistema y1');
legend('x[n]', 'y1[n]', 'Location', 'northwest');

subplot(412);
plot(n, x_n(5:end), '.', n_alterado, y2_n, '.');
title('Resposta do sistema y2');
legend('x[n]', 'y2[n]', 'Location', 'northwest');

subplot(413);
plot(n, x_n(5:end), '.', n, y3_n, '.');
title('Resposta do sistema y3');
legend('x[n]', 'y3[n]', 'Location', 'northwest');

subplot(414);
plot(n, x_n(5:end), '.', n, y4_n, '.');
title('Resposta do sistema y4');
xlabel('n');
legend('x[n]', 'y4[n]', 'Location', 'northwest');



%% 2.5.

%%% Exercício 2.5 Com base na resposta a impulso do sistema  h1[n] , 
% determinar a saída do sistema para o sinal de entrada  x[n] .

% Resposta a impulso do sistema, h[n]
h1 = b;   

figure();

% stem(): Plot discrete sequence data
stem(0:length(h1)-1, h1);

% axis(): Set axis limits and aspect ratios
axis([-2 length(h1)+2 min(h1) max(h1)]);

title('Resposta a impulso do sistema h1[n]');
xlabel('n');




%% 2.6.

%%% Exercício 2.6 Representar graficamente os sinais de entrada e de saída 
% considerados em 2.5, para  −50≤n≤50 .

% x[n]=1.5sin[0.025πn](u[n+40]−u[n−40])
% y1[n] = b0x[n] + b1x[n−1] + b2x[n−2] + b3x[n−3] + b4x[n−4] 

% Convolução (Convolution and polynomial multiplication), y[n] = h[n]*x[n]
y_n_h1_x = conv(h1, x_n(5:end));

% ajuste da dimensão da saída
y_n_h1_x = y_n_h1_x(1:end-length(h1)+1);


%%% y1[n] = T{x[n]} == y1[n] = h1[n]*x[n]

figure();

% Stairstep graph
stairs(n, x_n(5:end), '*');

% Retain current plot when adding new plots
hold on;

% Stairstep graph
stairs(n, y1_n, 'o');
stairs(n, y_n_h1_x, '+');

% Retain current plot when adding new plots
hold off;

title('Resposta do sistema y1 com base em h[n]*x[n]');
xlabel('n');
legend('x[n]', 'y1[n]=T\{x[n]\}', 'y1[n]=h1[n]*x[n]', 'Location', 'northwest')



