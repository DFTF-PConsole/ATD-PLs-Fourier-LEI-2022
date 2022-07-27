%% MAIN

%%% Ficha Prática nº 6 de ATD 2022

%%% Objetivo: Pretende-se ilustrar os conceitos de frequência e efetuar a 
% análise de sinais periódicos pela Série de Fourier trigonométrica e 
% complexa.

% Remove items from workspace, freeing up system memory
clear;

% Clear Command Window
clc;



%% 1.

%%% Exercício 1. Pretende-se determinar e representar os coeficientes da 
% Série de Fourier trigonométrica de um sinal periódico,  x(t) , e 
% apresentar graficamente o sinal original e o aproximado pela Série com um 
% dado número de harmónicos.



%% 1.1.

%%% Exercício 1.1. Para isso, escrever um script que efetue as seguintes 
% operações:


%%% Exercício 1.1.1. Pedir o valor do período fundamental,  T0, do sinal 
% a analisar.

%%% Exercício 1.1.2. Definir a sequência temporal  t, durante um período, 
% com, por exemplo, 500 elementos.

%%% Exercício 1.1.3. Obter o sinal  x(t)  usando um menu que permita 
% escolher uma onda quadrada periódica (use a função square), uma onda 
% periódica em dente de serra (use a função sawtooth) ou uma expressão 
% simbólica a introduzir. Representar graficamente  x(t).

%%% Exercício 1.1.4. Determinar e representar graficamente os valores dos 
% coeficientes (Cm  e  θm) da Série de Fourier trigonométrica com o 
% valor de  m_max  da Série de Fourier pedido ao utilizador. Considerar o 
% seguinte algoritmo para o cálculo dos coeficientes: (ver enunciado)

%%% Exercício 1.1.5. Obter e representar graficamente a sobreposição do 
% sinal original e dos sinais aproximados a partir dos coeficientes da 
% Série de Fourier trigonométrica para vários valores limites de  m  
% (entre 0 e  m_max), pedidos ao utilizador através de um vetor.

%%% Exercício 1.1.6. Obter e representar graficamente a amplitude e a fase 
% dos coeficientes da Série de Fourier complexa  cm, para  m  entre  
% –m_max  e  m_max, a partir dos coeficientes  Cm  e  θm.



% Em SerieFourier.m:
% [C_m, teta_m] = SerieFourier(t, x_t, T0, m_max)




%% 1.2.

%%% Exercício 1.2. Aplicar o script de 1.1 para os seguintes sinais:


% Set symbolic preferences
sympref('HeavisideAtOrigin', 1);



%% 1.2.1.

%%% Exercício 1.2.1. Onda quadrada periódica de amplitude 1 e período  2πs  
% (sugestão  m_max=50).


% ***** 1.1.1. *****

% Request user input
%T0 = input('Valor do período fundamental: ');

T0 = 2*pi;


% ***** 1.1.2. *****

t = 0 : T0/500 : T0-T0/500;

% Generate linearly spaced vector
%t = linspace(0, T0-T0/500, 500)


% ***** 1.1.3. *****

% Create multiple-choice dialog box
%opcao = menu('Sinal x(t)', 'Onda quadrada periódica', 'Onda periódica em dente de serra', 'Expressão simbólica a introduzir');

opcao = 1;

switch opcao
    case 1
        % onda quadrada periódica

        % Square wave
        x = square(2*pi/T0*t);
    
        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        % Heaviside step function
        x_t = heaviside(t) - 2*heaviside(t - T0/2);
        t = 0 : T0/500 : T0-T0/500;

        % double: Double-precision arrays
        % subs: Symbolic substitution
        %x = double( subs(x_t) );

    case 2
        % onda periódica em dente de serra

        % Sawtooth or triangle wave
        x = sawtooth(2*pi/T0*t);

        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        x_t = (t-T0/2)*2/T0;
        t = 0 : T0/500 : T0-(T0/500);
        
        % double: Double-precision arrays
        % subs: Symbolic substitution
        %x = double( subs(x_t) );

    otherwise
        % expressão simbólica a introduzir

        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        % Request user input
        x_t = input('x(t)= ');
        t = 0 : T0/500 : T0-T0/500;


        % double: Double-precision arrays
        % subs: Symbolic substitution
        x = double( subs(x_t) );
end


figure(1);

% 2-D line plot
plot(t, x);
title('Sinal periódico de tempo contínuo x(t)')
xlabel('t[s]')
ylabel('Amplitude');

m_max = 50;

% Request user input
%m_max = input('Valor de m_max: ');

% Determine whether array is empty
if isempty(m_max)
    m_max = 50;
end


% ***** 1.1.4. *****

[C_m, teta_m] = SerieFourier(t', x', T0, m_max);

m = 0 : m_max;

figure(2);

% Create axes in tiled positions
subplot(2, 1, 1);

% 2-D line plot
plot(m, C_m, 'bo');
title('Coeficientes da Série de Fourier trigonométrica')
ylabel('C_m');
xlabel('m');

% Create axes in tiled positions
subplot(2, 1, 2);

% 2-D line plot
plot(m, teta_m, 'bo');
ylabel('teta_m (rad)');
xlabel('m');


% ***** 1.1.5. *****

figure(3);

% 2-D line plot
plot(t, x, 'r');

% Retain current plot when adding new plots
hold on;

mt = [0 1 3 5 10 50];

%mt = input('Valores limites de m (como vetor): ');

if isempty(mt)
    mt = [0 1 3 5 10 50];
end

for k = 1 : length(mt)
    
    % Create array of all zeros
    x1 = zeros(size(t));
    
    for m = 0 : mt(k)

        x1 = x1 + C_m(m + 1)*cos(m*2*pi/T0*t + teta_m(m + 1));
    end

    % 2-D line plot
    plot(t, x1, '-.b');
end

% Retain current plot when adding new plots
hold off;


% ***** 1.1.6. *****

% Flip order of elements
c_m = [flip(C_m(2 : end)/2.*exp(-1i*teta_m(2 : end)));   C_m(1)*cos(teta_m(1));   C_m(2 : end)/2.*exp(1i*teta_m(2 : end))];




%% 1.2.2.

%%% Exercício 1.2.2. Onda periódica em dente de serra de amplitude 1 e 
% período  2πs  (sugestão  m_max=50).


% ***** 1.1.1. *****

% Request user input
%T0 = input('Valor do período fundamental: ');

T0 = 2*pi;


% ***** 1.1.2. *****

t = 0 : T0/500 : T0-T0/500;

% Generate linearly spaced vector
%t = linspace(0, T0-T0/500, 500)


% ***** 1.1.3. *****

% Create multiple-choice dialog box
%opcao = menu('Sinal x(t)', 'Onda quadrada periódica', 'Onda periódica em dente de serra', 'Expressão simbólica a introduzir');

opcao = 2;

switch opcao
    case 1
        % onda quadrada periódica

        % Square wave
        x = square(2*pi/T0*t);
    
        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        % Heaviside step function
        x_t = heaviside(t) - 2*heaviside(t - T0/2);
        t = 0 : T0/500 : T0-T0/500;

        % double: Double-precision arrays
        % subs: Symbolic substitution
        %x = double( subs(x_t) );

    case 2
        % onda periódica em dente de serra

        % Sawtooth or triangle wave
        x = sawtooth(2*pi/T0*t);

        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        x_t = (t-T0/2)*2/T0;
        t = 0 : T0/500 : T0-(T0/500);
        
        % double: Double-precision arrays
        % subs: Symbolic substitution
        %x = double( subs(x_t) );

    otherwise
        % expressão simbólica a introduzir

        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        % Request user input
        x_t = input('x(t)= ');
        t = 0 : T0/500 : T0-T0/500;


        % double: Double-precision arrays
        % subs: Symbolic substitution
        x = double( subs(x_t) );

end


figure(1);

% 2-D line plot
plot(t, x);
title('Sinal periódico de tempo contínuo x(t)')
xlabel('t[s]')
ylabel('Amplitude');

m_max = 50;

% Request user input
%m_max = input('Valor de m_max: ');

% Determine whether array is empty
if isempty(m_max)
    m_max = 50;
end


% ***** 1.1.4. *****

[C_m, teta_m] = SerieFourier(t', x', T0, m_max);

m = 0 : m_max;

figure(2);

% Create axes in tiled positions
subplot(2, 1, 1);

% 2-D line plot
plot(m, C_m, 'bo');
title('Coeficientes da Série de Fourier trigonométrica')
ylabel('C_m');
xlabel('m');

% Create axes in tiled positions
subplot(2, 1, 2);

% 2-D line plot
plot(m, teta_m, 'bo');
ylabel('teta_m (rad)');
xlabel('m');


% ***** 1.1.5. *****

figure(3);

% 2-D line plot
plot(t, x, 'r');

% Retain current plot when adding new plots
hold on;

mt = [0 1 3 5 10 50];

%mt = input('Valores limites de m (como vetor): ');

if isempty(mt)
    mt = [0 1 3 5 10 50];
end

for k = 1 : length(mt)
    
    % Create array of all zeros
    x1 = zeros(size(t));
    
    for m = 0 : mt(k)

        x1 = x1 + C_m(m + 1)*cos(m*2*pi/T0*t + teta_m(m + 1));
    end

    % 2-D line plot
    plot(t, x1, '-.b');
end

% Retain current plot when adding new plots
hold off;


% ***** 1.1.6. *****

% Flip order of elements
c_m = [flip(C_m(2 : end)/2.*exp(-1i*teta_m(2 : end)));   C_m(1)*cos(teta_m(1));   C_m(2 : end)/2.*exp(1i*teta_m(2 : end))];




%% 1.2.3.

%%% Exercício 1.2.3. Sinal  x(t)=−2+cos(πt)+sin(πt+π/4 ) 
% (sugestão: m_max=5).


% ***** 1.1.1. *****

% Request user input
%T0 = input('Valor do período fundamental: ');

T0 = 2;


% ***** 1.1.2. *****

t = 0 : T0/500 : T0-T0/500;

% Generate linearly spaced vector
%t = linspace(0, T0-T0/500, 500)


% ***** 1.1.3. *****

% Create multiple-choice dialog box
%opcao = menu('Sinal x(t)', 'Onda quadrada periódica', 'Onda periódica em dente de serra', 'Expressão simbólica a introduzir');

opcao = 3;

switch opcao
    case 1
        % onda quadrada periódica

        % Square wave
        x = square(2*pi/T0*t);
    
        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        % Heaviside step function
        x_t = heaviside(t) - 2*heaviside(t - T0/2);
        t = 0 : T0/500 : T0-T0/500;

        % double: Double-precision arrays
        % subs: Symbolic substitution
        %x = double( subs(x_t) );

    case 2
        % onda periódica em dente de serra

        % Sawtooth or triangle wave
        x = sawtooth(2*pi/T0*t);

        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        x_t = (t-T0/2)*2/T0;
        t = 0 : T0/500 : T0-(T0/500);
        
        % double: Double-precision arrays
        % subs: Symbolic substitution
        %x = double( subs(x_t) );

    otherwise
        % expressão simbólica a introduzir

        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        % Request user input
        %x_t = input('x(t)= ');
        x_t = -2 + cos(pi*t) + sin(pi*t + pi/4);
        t = 0 : T0/500 : T0-T0/500;


        % double: Double-precision arrays
        % subs: Symbolic substitution
        x = double( subs(x_t) );
end


figure(1);

% 2-D line plot
plot(t, x);
title('Sinal periódico de tempo contínuo x(t)')
xlabel('t[s]')
ylabel('Amplitude');

m_max = 5;

% Request user input
%m_max = input('Valor de m_max: ');

% Determine whether array is empty
if isempty(m_max)
    m_max = 50;
end


% ***** 1.1.4. *****

[C_m, teta_m] = SerieFourier(t', x', T0, m_max);

m = 0 : m_max;

figure(2);

% Create axes in tiled positions
subplot(2, 1, 1);

% 2-D line plot
plot(m, C_m, 'bo');
title('Coeficientes da Série de Fourier trigonométrica')
ylabel('C_m');
xlabel('m');

% Create axes in tiled positions
subplot(2, 1, 2);

% 2-D line plot
plot(m, teta_m, 'bo');
ylabel('teta_m (rad)');
xlabel('m');


% ***** 1.1.5. *****

figure(3);

% 2-D line plot
plot(t, x, 'r');

% Retain current plot when adding new plots
hold on;

mt = [0 1 3 5];

%mt = input('Valores limites de m (como vetor): ');

if isempty(mt)
    mt = [0 1 3 5 10 50];
end

for k = 1 : length(mt)
    
    % Create array of all zeros
    x1 = zeros(size(t));
    
    for m = 0 : mt(k)

        x1 = x1 + C_m(m + 1)*cos(m*2*pi/T0*t + teta_m(m + 1));
    end

    % 2-D line plot
    plot(t, x1, '-.b');
end

% Retain current plot when adding new plots
hold off;


% ***** 1.1.6. *****

% Flip order of elements
c_m = [flip(C_m(2 : end)/2.*exp(-1i*teta_m(2 : end)));   C_m(1)*cos(teta_m(1));   C_m(2 : end)/2.*exp(1i*teta_m(2 : end))];




%% 1.2.4.

%%% Exercício 1.2.4. Sinal  x(t)=2sin(5πt)2+4cos(20πt−π/4)sin(45πt)  
% (sugestão:  m_max=20).


% ***** 1.1.1. *****

% Request user input
%T0 = input('Valor do período fundamental: ');

T0 = 0.4;


% ***** 1.1.2. *****

t = 0 : T0/500 : T0-T0/500;

% Generate linearly spaced vector
%t = linspace(0, T0-T0/500, 500)


% ***** 1.1.3. *****

% Create multiple-choice dialog box
%opcao = menu('Sinal x(t)', 'Onda quadrada periódica', 'Onda periódica em dente de serra', 'Expressão simbólica a introduzir');

opcao = 3;

switch opcao
    case 1
        % onda quadrada periódica

        % Square wave
        x = square(2*pi/T0*t);
    
        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        % Heaviside step function
        x_t = heaviside(t) - 2*heaviside(t - T0/2);
        t = 0 : T0/500 : T0-T0/500;

        % double: Double-precision arrays
        % subs: Symbolic substitution
        %x = double( subs(x_t) );

    case 2
        % onda periódica em dente de serra

        % Sawtooth or triangle wave
        x = sawtooth(2*pi/T0*t);

        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        x_t = (t-T0/2)*2/T0;
        t = 0 : T0/500 : T0-(T0/500);
        
        % double: Double-precision arrays
        % subs: Symbolic substitution
        %x = double( subs(x_t) );

    otherwise
        % expressão simbólica a introduzir

        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        % Request user input
        %x_t = input('x(t)= ');

        x_t = 2*sin(5*pi*t)^2 + 4*cos(20*pi*t - pi/4)*sin(45*pi*t);

        t = 0 : T0/500 : T0-T0/500;


        % double: Double-precision arrays
        % subs: Symbolic substitution
        x = double( subs(x_t) );

end


figure(1);

% 2-D line plot
plot(t, x);
title('Sinal periódico de tempo contínuo x(t)')
xlabel('t[s]')
ylabel('Amplitude');

m_max = 20;

% Request user input
%m_max = input('Valor de m_max: ');

% Determine whether array is empty
if isempty(m_max)
    m_max = 50;
end


% ***** 1.1.4. *****

[C_m, teta_m] = SerieFourier(t', x', T0, m_max);

m = 0 : m_max;

figure(2);

% Create axes in tiled positions
subplot(2, 1, 1);

% 2-D line plot
plot(m, C_m, 'bo');
title('Coeficientes da Série de Fourier trigonométrica')
ylabel('C_m');
xlabel('m');

% Create axes in tiled positions
subplot(2, 1, 2);

% 2-D line plot
plot(m, teta_m, 'bo');
ylabel('teta_m (rad)');
xlabel('m');


% ***** 1.1.5. *****

figure(3);

% 2-D line plot
plot(t, x, 'r');

% Retain current plot when adding new plots
hold on;

mt = [0 1 3 5 10 20];

%mt = input('Valores limites de m (como vetor): ');

if isempty(mt)
    mt = [0 1 3 5 10 50];
end

for k = 1 : length(mt)
    
    % Create array of all zeros
    x1 = zeros(size(t));
    
    for m = 0 : mt(k)

        x1 = x1 + C_m(m + 1)*cos(m*2*pi/T0*t + teta_m(m + 1));
    end

    % 2-D line plot
    plot(t, x1, '-.b');
end

% Retain current plot when adding new plots
hold off;


% ***** 1.1.6. *****

% Flip order of elements
c_m = [flip(C_m(2 : end)/2.*exp(-1i*teta_m(2 : end)));   C_m(1)*cos(teta_m(1));   C_m(2 : end)/2.*exp(1i*teta_m(2 : end))];




%% 1.2.5.

%%% Exercício 1.2.5. Sinal  x(t)=−2+4cos(4πt+π/3)−2sin(10πt)  
% (sugestão:  m_max=10).


% ***** 1.1.1. *****

% Request user input
%T0 = input('Valor do período fundamental: ');

T0 = 1;


% ***** 1.1.2. *****

t = 0 : T0/500 : T0-T0/500;

% Generate linearly spaced vector
%t = linspace(0, T0-T0/500, 500)


% ***** 1.1.3. *****

% Create multiple-choice dialog box
%opcao = menu('Sinal x(t)', 'Onda quadrada periódica', 'Onda periódica em dente de serra', 'Expressão simbólica a introduzir');

opcao = 3;

switch opcao
    case 1
        % onda quadrada periódica

        % Square wave
        x = square(2*pi/T0*t);
    
        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        % Heaviside step function
        x_t = heaviside(t) - 2*heaviside(t - T0/2);
        t = 0 : T0/500 : T0-T0/500;

        % double: Double-precision arrays
        % subs: Symbolic substitution
        %x = double( subs(x_t) );

    case 2
        % onda periódica em dente de serra

        % Sawtooth or triangle wave
        x = sawtooth(2*pi/T0*t);

        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        x_t = (t-T0/2)*2/T0;
        t = 0 : T0/500 : T0-(T0/500);
        
        % double: Double-precision arrays
        % subs: Symbolic substitution
        %x = double( subs(x_t) );

    otherwise
        % expressão simbólica a introduzir

        % Create symbolic scalar variables, functions, and matrix variables
        syms t;

        % Request user input
        %x_t = input('x(t)= ');

        x_t = -2 + 4*cos(4*pi*t + pi/3) - 2*sin(10*pi*t);

        t = 0 : T0/500 : T0-T0/500;


        % double: Double-precision arrays
        % subs: Symbolic substitution
        x = double( subs(x_t) );

end


figure(1);

% 2-D line plot
plot(t, x);
title('Sinal periódico de tempo contínuo x(t)')
xlabel('t[s]')
ylabel('Amplitude');

m_max = 10;

% Request user input
%m_max = input('Valor de m_max: ');

% Determine whether array is empty
if isempty(m_max)
    m_max = 50;
end


% ***** 1.1.4. *****

[C_m, teta_m] = SerieFourier(t', x', T0, m_max);

m = 0 : m_max;

figure(2);

% Create axes in tiled positions
subplot(2, 1, 1);

% 2-D line plot
plot(m, C_m, 'bo');
title('Coeficientes da Série de Fourier trigonométrica')
ylabel('C_m');
xlabel('m');

% Create axes in tiled positions
subplot(2, 1, 2);

% 2-D line plot
plot(m, teta_m, 'bo');
ylabel('teta_m (rad)');
xlabel('m');


% ***** 1.1.5. *****

figure(3);

% 2-D line plot
plot(t, x, 'r');

% Retain current plot when adding new plots
hold on;

mt = [0 1 3 5 10 10];

%mt = input('Valores limites de m (como vetor): ');

if isempty(mt)
    mt = [0 1 3 5 50];
end

for k = 1 : length(mt)
    
    % Create array of all zeros
    x1 = zeros(size(t));
    
    for m = 0 : mt(k)

        x1 = x1 + C_m(m + 1)*cos(m*2*pi/T0*t + teta_m(m + 1));
    end

    % 2-D line plot
    plot(t, x1, '-.b');
end

% Retain current plot when adding new plots
hold off;


% ***** 1.1.6. *****

% Flip order of elements
c_m = [flip(C_m(2 : end)/2.*exp(-1i*teta_m(2 : end)));   C_m(1)*cos(teta_m(1));   C_m(2 : end)/2.*exp(1i*teta_m(2 : end))];




%% 1.3.

%%% Exercício 1.3. Determinar analiticamente os coeficientes da Série de 
% Fourier trigonométrica,  Cm  e  θm , dos sinais indicados em 1.2.3, 1.2.4 
% e 1.2.5. Comparar com os resultados obtidos em 1.2.


% Caderno



%% 1.4.

%%% Exercício 1.4. Determinar analiticamente os coeficientes da Série de 
% Fourier complexa,  cm , dos sinais indicados em 1.2.3, 1.2.4 e 1.2.5, 
% a partir dos coeficientes da Série de Fourier trigonométrica,  Cm  e  
% θm , obtidos em 1.3. Comparar com os resultados obtidos em 1.2.


% Caderno



%% 1.5.

%%% Exercício 1.5. Determinar os coeficientes da Série de Fourier complexa,  
% cm , dos sinais indicados em 1.2.3, 1.2.4 e 1.2.5, através da expressão  
% cm=1T0∫T0/2−T0/2x(t)e−jmω0tdt  . Comparar com os resultados obtidos em 
% 1.2 e em 1.4.

% Create symbolic scalar variables, functions, and matrix variables
syms t m;

% Definite and indefinite integrals
cms = int( x_t*exp(-1i*m*2*pi*t/T0)/T0, t, 0, T0 );

c_m_efetivo = [];

for m = -m_max : m_max
    % limit: Limit of symbolic expression
    % double: Double-precision arrays
    c_m_efetivo = [c_m_efetivo; double( limit(cms, m) )];
end

figure(4);

% Create axes in tiled positions
subplot(211);

% 2-D line plot
% Absolute value and complex magnitude
plot(-m_max : m_max, abs(c_m), 'bo', -m_max : m_max, abs(c_m_efetivo), 'g+');
title('Coeficientes da Série de Fourier complexa');
ylabel('abs(cm)');
xlabel('m');

% Create axes in tiled positions
subplot(212);
plot(-m_max : m_max, angle(c_m), 'bo', -m_max : m_max, angle(c_m_efetivo), 'g+');
ylabel('angle(cm)');
xlabel('m');

m = (-m_max : m_max)';

% Display value of variable
disp('m  |  c_m aproximado  |  c_m efetivo');
disp( [m  c_m  c_m_efetivo] );

% Display value of variable
disp('m: ');
disp(m);

% Display value of variable
disp('c_m aproximado: ');
disp(c_m);

% Display value of variable
disp('c_m efetivo: ');
disp(c_m_efetivo);



%% 1.6.

%%% Exercício 1.6. Determinar os coeficientes da Série de Fourier 
% trigonométrica,  Cm  e  θm , dos sinais indicados em 1.2.3, 1.2.4 e 
% 1.2.5, a partir dos coeficientes da Série de Fourier complexa,  cm , 
% obtidos em 1.4. Comparar com os resultados obtidos em 1.2 e em 1.3.

% Absolute value and complex magnitude
C_m_efetivo = [abs( c_m_efetivo(m == 0) );   2*abs( c_m_efetivo(m > 0) )];

% Phase angle
teta_m_efetivo = angle( c_m_efetivo(m >= 0) );

% Display value of variable
disp('m  |  C_m aproximado  |  C_m efetivo');
disp( [m(m >= 0)  C_m  C_m_efetivo] );

% Display value of variable
disp('m: ');
disp( m(m >= 0) );

% Display value of variable
disp('c_m aproximado: ');
disp(C_m);

% Display value of variable
disp('C_m efetivo: ');
disp(C_m_efetivo);

% Display value of variable
disp('m  |  teta_m aproximado  |  teta_m efetivo');
disp( [m(m >= 0)  teta_m  teta_m_efetivo] );

% Display value of variable
disp('m: ');
disp(m);

% Display value of variable
disp('c_m aproximado: ');
disp(c_m);

% Display value of variable
disp('c_m efetivo: ');
disp(c_m_efetivo);





