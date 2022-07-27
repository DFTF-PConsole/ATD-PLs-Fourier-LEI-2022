clear;
clc;

%% 1. Hello World

% 1.1. Hello World
disp('Hello World');

fprintf('Hello World\n');

a = 'Hello World';

disp(a);

fprintf('%s\n', a);


% 1.2. Cálculos básicos

a = 10;
b = 20;
c = a + b;

disp(c);

fprintf("c = %d\n\n", c);

c = a*b;
disp(c);

c = a/b;
disp(c);

c = floor(a/b);
disp(c);

c = rem(a, b);  % returns the remainder after division of a by b
disp(c);

d = mod(a, b);
disp(d);

a = 10;
b = 2;
c = a^b;
disp(c);

a = 100;
c = sqrt(a);
disp(c);


% converter no jupyter para html:
% ! jupyter nbconvert --to html ATD_PL-aula-01-FP1-matlabBasics.ipynb



%% 2. Matrizes

A = [11 12 13 14; 21 22 23 24];

size(A);

whos A;

transpostaDeA = A';

B = [1 2; 3 4; 5 6];

transpostaDeB = B';

matrizDeZeros = zeros(3, 3);

matrizDeUns = ones(3, 3);

matrizIdentidadeQuadrada = eye(3);

matrizIdentidadeNxM = eye(5, 7);

A = [1 2; 3 4];
B = [5 6; 7 8];

somaAB = A+B;

subAB = A - B;

C = A*B;

multItemxItem=A.*B;     % multiplicaçao item a item

C = A/B;                    % divisão à direita -> A x B^-1
C = mrdivide(A, B);         % 
C = A\B;                    %  divisão à esquerda -> B^-1 x A
C = mldivide(A, B);         % 

C = A./B;   % divisao item a item

determinanteA = det(A);

concatAB = [A B]; % colunas / horizontalmente

concatAB = [A ; B]; % linhas / vertical

AA = A;
AA(:, 1) = [];  % remoção de colunas

AA = A;
AA(2, :) = []; % remoção de linhas

v = 0:5; % vetor com passo 1 (padrao)

v = 0:0.5:5; % vetor com passo 0.5 de 0 ate 5

v(1); % primeiro item

v(end); % ultimo elemento

v(1,3); % os 3 primeiros itens



%% 3. Calculo Simbolico

x = pi;
f = sin(x);             % que é de facto um valor "muito próximo" de 0, mas não deixa de ser uma aproximação

x = pi;
f = sin(sym(x));        % Quando realizamos o mesmo cálculo de forma algébrica, utilizando a funcionalidade de matemática simbólica do Matlab, podemos então obter resultados exatos, que não não aproximações

syms f(x);              % Ainda mais interessante é o potencial que esse tipo de uso permite, por exemplo, na manipulação/solução de equações, diferenciação, integração, etc.
f(x) = sin(x);
g = diff(f);            % differenciação

syms f(x);
f(x) = sin(x);
h = int(f);             % integração 

syms f(x);              % solução de equações polinomiais
f(x) = x^2 + 4*x + 1;
solve(f(x) == 0);

syms f(x);              % simplificação de equações
f(x) = (x^2 + x + 1)*(x-1)*(x + 1);
simplify(f(x));






