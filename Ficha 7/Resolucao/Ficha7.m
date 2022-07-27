%% MAIN

%%% Ficha Prática nº 7 de ATD 2022

%%% Objetivo: Pretende-se continuar a ilustrar os conceitos de frequência 
% e efetuar a análise de sinais periódicos, de tempo contínuo e de tempo 
% discreto, pela Série de Fourier trigonométrica e complexa. Pretende-se 
% também aplicar o Teorema da Amostragem para determinar a frequência de 
% amostragem a usar na obtenção da representação em tempo discreto de um 
% sinal e usar a Transformada de Fourier Discreta (DFT) para ilustrar os 
% conceitos de frequência em sinais de tempo discreto.

% Remove items from workspace, freeing up system memory
clear;

% Clear Command Window
clc;



%% 1.

%%% Exercício 1. Considerar uma sequência de dados x[n] que resultou da 
% amostragem de um determinado sinal de tempo contínuo x(t) com um período 
% de amostragem  Ts=4ms




%% 1.1.

%%% Exercício 1.1. Assumindo que o sinal é periódico, utilizar o script, com 
% eventuais adaptações, da ficha 6 para:






%% 1.1.1.

%%% Exercício 1.1.1. Determinar e representar graficamente os valores dos 
% coeficientes ( Cm  e  θm ) da Série de Fourier trigonométrica do sinal  
% x[n]  com um valor adequado de  m_max  (sugestão:  m_max=80 ) da Série de 
% Fourier.





%% 1.1.2.

%%% Exercício 1.1.2. Obter e representar graficamente a sobreposição do 
% sinal original e dos sinais aproximados a partir dos coeficientes da Série 
% de Fourier trigonométrica para vários valores de  m_max .







%% 1.1.3.

%%% Exercício 1.1.3. Obter e representar graficamente a amplitude e a fase 
% dos valores do coeficiente  cm  da Série de Fourier complexa do sinal  
% x[n] , a partir dos coeficientes ( Cm  e  θm ).




%% 1.1.4.

%%% Exercício 1.1.4. Determinar e representar graficamente a Transformada 
% de Fourier Discreta (DFT) do sinal  x[n] , usando as funções do Matlab 
% fft e fftshift, em módulo e em fase, em função da frequência angular  ω  
% (em  rad/s ) e em função da frequência angular  Ω  (em  rad ). Comparar 
% os resultados obtidos com os valores do coeficiente  cm  da Série de 
% Fourier complexa do sinal  x[n] .






%% 1.2.

%%% Exercício 1.2. A partir da análise efetuada, identificar as componentes 
% de frequência do sinal de tempo discreto  x[n]  e do sinal de tempo 
% contínuo  x(t) .








%% 2.

%%% Exercício 2. Considerar o sinal periódico de tempo contínuo  
% x(t)=−1+3sin(50πt)+4cos(20πt+π/4)sin(40πt) .





%% 2.1.

%%% Exercício 2.1. Aplicando o Teorema da Amostragem, escolher uma 
% frequência de amostragem  fs  adequada, e que seja múltipla da frequência 
% fundamental  f0 . Obter a expressão de  x[n] .






%% 2.2.

%%% Exercício 2.2. Indicar as frequências angulares ( ω  e  Ω ), as 
% frequências fundamentais ( ω0  e  Ω0 ) e os períodos fundamentais 
% ( T0  e  N ) dos sinais de tempo contínuo  x(t)  e de tempo discreto  
% x[n] .






%% 2.3.

%%% Exercício 2.3. Representar graficamente a sobreposição do sinal de 
% tempo contínuo (com um passo temporal reduzido e traço contínuo) e o 
% correspondente sinal amostrado (ponto a ponto).







%% 2.4.

%%% Exercício 2.4. Determinar e representar graficamente a Transformada de 
% Fourier Discreta (DFT) do sinal  x[n] , usando as funções do Matlab fft e 
% fftshift, em módulo e em fase, em função da frequência angular  ω  
% (em rad/s) e em função da frequência angular  Ω  (em rad).





%% 2.5.

%%% Exercício 2.5. Determinar e representar graficamente os coeficientes da 
% Série de Fourier complexa do sinal,  cm , a partir da DFT.







%% 2.6.

%%% Exercício 2.6. Determinar e representar graficamente os parâmetros da 
% Série de Fourier trigonométrica ( Cm  e  θm ) do sinal.








%% 2.7.

%%% Exercício 2.7. Reconstruir o sinal  x(t)  a partir dos parâmetros da 
% Série de Fourier trigonométrica, obtidos em 2.6. Comparar graficamente 
% com o sinal original.








