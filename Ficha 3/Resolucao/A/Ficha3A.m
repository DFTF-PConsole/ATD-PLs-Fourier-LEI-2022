%% MAIN

clear;
clc;



%% 1.



%% 1.1.

%  Contém: temp, months, years
load lisbon_temp_fmt.mat

% série temporal
x1 = temp; 

% escala temporal em meses
n = (0:length(x1)-1)'; 


%plot inline -w 1200

figure(1);
plot(n, x1, '-+');
legend('Série temporal', 'Location', 'northwest')
xlabel('n [meses]');
ylabel('T [ºC]')
title('Temperatura em Lisboa desde 1980');



%% 1.2.

% Há NaN por colunas?
ha_NaN = any(isnan(x1));

if ha_NaN
    fprintf('Foram encontrados elementos NaN.\n');

    % Elementos com NaN
    indices_NaN = find(isnan(x1));

    % Reconstruir as linhas eliminadas usando extrapolação (interp1)
    % Elimina linhas com NaN e reconstrói
    x1_reconstruida = x1;

    for k=1:length(indices_NaN)
        % admitindo que não há NaNs no início
        nn = n(indices_NaN(k)-4:indices_NaN(k)-1); 
        xx = x1_reconstruida(indices_NaN(k)-4:indices_NaN(k)-1);
        % interp1(x,v,xq) returns interpolated values of a 1-D function at specific query points using linear interpolation. Vector x contains the sample points, and v contains the corresponding values, v(x). Vector xq contains the coordinates of the query points.
        x1_reconstruida(indices_NaN(k)) = interp1(nn, xx, n(indices_NaN(k)), 'pchip', 'extrap');
    end

else
    fprintf('Não foram encontrados elementos NaN.\n');
end


figure(2);
plot(n, x1, '-+', n, x1_reconstruida, '-o');
legend('Série temporal', 'Série temporal sem NaN', 'Location', 'northwest');
ylabel('T [ºC]');
xlabel('n [meses]');



%% 1.3.

media = mean(x1_reconstruida)
desvio_padrao = std(x1_reconstruida)

indice1980 = 1;
indice1989 = find(years==1989)*12;
indice1990 = indice1989+1;
indice1999 = find(years==1999)*12;

temp1980 = x1_reconstruida(indice1980:indice1989);
temp1990 = x1_reconstruida(indice1990:indice1999);

correlacao = corrcoef(temp1980, temp1990);

fprintf('A correlação entre as duas séries temporais é: %.3f ', correlacao);



%% 1.4.

indices_outliers = find(abs(x1_reconstruida - media) > 3*desvio_padrao);

% Substituição dos outliers
x1_reconstruida_outliers = x1_reconstruida;

if ~isempty(indices_outliers)
    for k=1:numel(indices_outliers)
        if x1_reconstruida_outliers(indices_outliers(k)) > media
            x1_reconstruida_outliers(indices_outliers(k)) = media + 1.5*desvio_padrao;
        else
            x1_reconstruida_outliers(indices_outliers(k)) = media - 1.5*desvio_padrao;
        end
    end
end

figure(3);
plot(n, x1, '-+', n, x1_reconstruida, '-o', n, x1_reconstruida_outliers, '-d');
legend('Série temporal', 'Série sem NaN', 'Série sem outliers', 'Location', 'northwest')
xlabel('n [meses]');
ylabel('T [ºC]');



%% 2.



%% 2.1.

% tendência paramétrica (polinomial)

% trend de ordem 0 / media da serie
% Remove polynomial trend
x1_reconstruida_outliers_trend0 = detrend(x1_reconstruida_outliers, 'constant');

% componente da tendência
y1_trend0 = x1_reconstruida_outliers-x1_reconstruida_outliers_trend0;

% trend de ordem 1
x1_reconstruida_outliers_trend1 = detrend(x1_reconstruida_outliers, 'linear');

% componente da tendência
y1_trend1 = x1_reconstruida_outliers-x1_reconstruida_outliers_trend1;

figure(4);
subplot(211);
plot(n, x1_reconstruida_outliers, '-+', n, y1_trend0, '-*');
title('Série (+) e tendência (*) de grau 0')
xlabel('n [meses]');

subplot(212);
plot(n, x1_reconstruida_outliers_trend0, '-o');
title('Série sem tendência de grau 0')
xlabel('n [meses]');

figure(5);
subplot(211);
plot(n, x1_reconstruida_outliers, '-+', n, y1_trend1, '-*');
title('Série (+) e tendência (*) de grau 1')
xlabel('n [meses]');

subplot(212);
plot(n, x1_reconstruida_outliers_trend1, '-o');
title('Série sem tendência de grau 1')
xlabel('n [meses]');



%% 2.2.

% Aproximação linear de 2º grau
% trend de ordem 2

% coeficientes dos polinómios
% polyfit(x,y,n) returns the coefficients for a polynomial p(x) of degree n that is a best fit (in a least-squares sense) for the data in y.
coef_polim = polyfit(n, x1_reconstruida_outliers, 2);

% valores resultantes
% polyval(p,x) evaluates the polynomial p at each point in x. The argument p is a vector of length n+1 whose elements are the coefficients (in descending powers) of an nth-degree polynomial
y1_trend2 = polyval(coef_polim, n);
x1_reconstruida_outliers_trend2 = x1_reconstruida_outliers-y1_trend2;

figure(6);
subplot(211);
plot(n, x1_reconstruida_outliers, '-+', n, y1_trend2, '-*');
title('Série (+) e tendência (*) de grau 2');
xlabel('n [meses]');

subplot(212);
plot(n, x1_reconstruida_outliers_trend2, '-o');
title('Série sem tendência de grau 2');
xlabel('n [meses]');



%% 2.3.

% assumindo sazonalidade de 12 meses
periodo = 12; 

% Reshape array, reshape(A,sz1,...,szN) reshapes A into a sz1-by-...-by-szN array where sz1,...,szN indicates the size of each dimension.
x1_reconstruida_outliers_trend2_reshape = reshape(x1_reconstruida_outliers_trend2, periodo, floor(numel(x1_reconstruida_outliers_trend2))/periodo);

% repmat(A,r1,...,rN) specifies a list of scalars, r1,..,rN, that describes how copies of A are arranged in each dimension.
y1_saz1 = repmat(mean(x1_reconstruida_outliers_trend2_reshape, 2), floor(numel(x1_reconstruida_outliers_trend2))/periodo, 1);

x1_reconstruida_outliers_sazonalidade = x1_reconstruida_outliers-y1_saz1;

figure(7);
subplot(211);
plot(n, x1_reconstruida_outliers, '-+', n, x1_reconstruida_outliers_sazonalidade, '-o');
title('Série (+) e sem sazonalidade (o)')

subplot(212);
plot(n, y1_saz1, '-*');
title('Sazonalidade da Série')
xlabel('n [meses]');



%% 2.4.

% Estimar a componente irregular
y1_irreg1 = x1_reconstruida_outliers - y1_trend2 - y1_saz1;

% série temporal sem a componente irregular
x1_reconstruida_outliers_irreg = x1_reconstruida_outliers-y1_irreg1;

figure(8);
subplot(211);
plot(n, x1_reconstruida_outliers, '-+', n, x1_reconstruida_outliers_irreg, '-o');
title('Série com (+) e sem (o) componente irregular');

subplot(212);
plot(n, y1_irreg1, '-*');
title('Componente irregular da Série');
xlabel('n [Meses]');


