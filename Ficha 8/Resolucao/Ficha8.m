%% MAIN

%%% Ficha Prática nº 8 de ATD 2022

%%% Objetivo: Pretende-se usar a Transformada de Fourier Discreta (DFT) 
% para ilustrar os conceitos de frequência em sinais áudio e em imagens e 
% para efetuar a sua análise no tempo e na frequência, usando a 
% Transformada de Fourier em Janelas (STFT) de dimensão fixa.

% Remove items from workspace, freeing up system memory
clear;

% Clear Command Window
clc;



%% 1.

%%% Exercício 1. Considerar o sinal de áudio do ficheiro 'escala.wav'




%% 1.1.

%%% Exercício 1.1. Ler e escutar o sinal áudio, utilizando as funções do 
% Matlab audioread e sound.




%% 1.2.

%%% Exercício 1.2. Indicar a frequência de amostragem ( fs ), o período 
% fundamental ( N ) e a frequência fundamental ( Ω0 ) do sinal de tempo 
% discreto  x[n]  e a resolução em frequência (em Hz).





%% 1.3.

%%% Exercício 1.3. Obter e representar o espetro (magnitude) de  x[n] , 
% usando as funções fft, fftshift e abs.





%% 1.4.

%%% Exercício 1.4. Identificar as frequências angulares ( Ω  em  rad ) e 
% as frequências ( f  em Hz) mais relevantes do sinal (considerar as 
% frequências cujas componentes têm magnitude superior a, por exemplo, 
% 20\% do valor máximo).




%% 1.5.

%%% Exercício 1.5. Determinar as notas musicais associadas às frequências 
% mais relevantes do sinal, considerando a seguinte tabela:





%% 1.6.

%%% Exercício 1.6. Repetir o exercício para outro sinal de áudio como, 
% por exemplo, o 'sax-phrase-short.wav'.





%% 2.

%%% Exercício 2. A Transformada de Fourier Discreta (DFT) possibilita o 
% processamento de imagens permitindo, por exemplo, a análise computacional 
% de imagens, a filtragem de imagens, a extração de características, a 
% compressão / reconstrução de imagens, etc. A aplicação da DFT permite 
% decompor uma imagem em termos das suas componentes sinusoidais, aceitando 
% como entrada uma imagem definida no domínio do espaço real, produzindo 
% como saída uma imagem definida no domínio das frequências espaciais. Um 
% ponto na imagem de saída corresponde a uma frequência na imagem de 
% entrada. Por exemplo, o pixel no centro geométrico da imagem de saída 
% corresponde à componente DC da imagem. Quando os restantes pixéis são 
% percorridos do centro para a periferia obtêm-se valores crescentes de 
% frequências na imagem de entrada. Considerar a imagem do ficheiro 
% 'peppers.bmp'.





%% 2.1.

%%% Exercício 2.1. Ler a imagem usando a função imread.





%% 2.2.

%%% Exercício 2.2. Representar a imagem original, usando a função imshow.





%% 2.3.

%%% Exercício 2.3. Obter as componentes de frequência da imagem usando as 
% funções fft2 e fftshift e representar graficamente a sua magnitude em 
% função do domínio definido em termos das dimensões (entre  −N/2  e  N/2 ) 
% da imagem (considere a função mesh e  20∗log10(abs()) ). Caraterizar a 
% magnitude do espetro da imagem e obter a cor média da imagem (vetor do 
% mapa de cores correspondente à componente DC da imagem ou à frequência 
% zero).





%% 3.

%%% Exercício 3. Para efetuar a análise de sinais simultaneamente no tempo 
% e na frequência pode recorrer-se à Transformada de Fourier em Janelas 
% (STFT – Short Time Fourier Transform).






%% 3.1.

%%% Exercício 3.1. Ler o sinal áudio do ficheiro 'escala.wav' e determinar 
% a frequência mais relevante em sucessivas janelas temporais com duração e 
% sobreposição apropriadas (i.e., duração: 128ms e sobreposição: 64ms). Em 
% cada janela, determinar a magnitude do espetro recorrendo a uma janela de 
% Hamming (função hamming do Matlab) e selecionar a frequência fundamental 
% como sendo a frequência mais relevante (valor da DFT com maior amplitude).





%% 3.2.

%%% Exercício 3.2. Indicar a resolução em frequência em cada janela e 
% representar graficamente a sucessão temporal de frequências mais 
% relevantes do sinal em função da frequência  f  em Hz.





%% 3.3.

%%% Exercício 3.3. Comparar o resultado com o espectrograma obtido com a 
% função spectrogram.





%% 3.4.

%%% Exercício 3.4. Determinar a sequência de notas musicais associadas a 
% essas frequências do sinal.



