% MAIN

clear;
clc;


%% 1.
clear;
clc;

% 1.1
A = [1 2 3 4 ; 5 6 7 8];

% 1.2
B = [2 3 4 5 ; 6 7 8 9];

% 1.3
save('abfile.mat', 'A', 'B');

% 1.4
clear;

clc;

% 1.5
load('abfile.mat');

% 1.6
A(:, 2) = [];
B(:, 3) = [];

% 1.7
Ca = [10 ; 30];
Cb = [20 ; 50];

A = [Ca A];
B = [B Cb];

% 1.8
Cp = [A(1, :) ; B(end, :)];

% 1.9.1
C1 = A + B;

% 1.9.2
C2 = A - B;

% 1.9.3
C3 = A * B';

% 1.9.4
C4 = A .* B;

% 1.9.5
C5 = A / B;

% 1.9.6
C6 = A ./ B;


%% 2.
clear;
clc;

% 2.1
t_vetorTempo = -10 : 0.01 : 10;
dimensao = length(t_vetorTempo);
disp("Dimensao:");
disp(dimensao);

% 2.2
f(:) = sin(2 * pi * t_vetorTempo) + sin(pi * t_vetorTempo);

%f=zeros(1,dimensao);
%for k=1:dimensao
%    f(k)=sin(2 * pi * t_vetorTempo(k)) + sin(pi * t_vetorTempo(k));
%end

figure;
plot(t_vetorTempo, f,'-ob');
title('Gráfico de f(t) - Numerico, plot()')
xlabel('tempo [s]');
ylabel('f(t)');


%% 3.
clear;
clc;

syms f(t);  % t=sym('t')
f(t) = sin(2 * pi * t) + sin(pi * t);   % ft=sym('sin(4*pi*t)+sin(pi*t)')

figure;
fplot(f, [-10 10], "r");
title('Gráfico de f(t) - Simbolico, fplot()');
xlabel('tempo [s]');
ylabel('f(t)');



%% 4.
clear;
clc;

Ex4('a');


%% 5.
clear;
clc;

x = 0 : 1 : 10;
y = [0 0.7 2.4 3.1 4.2 4.8 5.7 5.9 6.2 6.4 6.3];

vet_coef = Ex5(x, y, 2);
disp("Vet. Coef.:");
disp(vet_coef);


%% 6.
clear;
clc;

output = Ex6(9);
disp("Fatorial:");
disp(output);


%% 7.
clear;
clc;

output = Ex7(20);
disp("Fibonacci:");
disp(output);


%% 8.
clear;
clc;

% 8.1
%[g, Hg, Pg] = Ex8_1(a, k, c, N, H0, P0);

% 8.2

% 8.2.1
Ex8_2(0.025, 1.0, 2, 30, 20, 10)

% 8.2.2
Ex8_2(0.025, 1.5, 2, 30, 20, 10)

% 8.2.3
Ex8_2(0.025, 1.5, 2, 30, 15, 10)

