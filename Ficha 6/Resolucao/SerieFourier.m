function [C_m, teta_m] = SerieFourier(t, x_t, T0, m_max)
    %  Determinar e representar graficamente os valores dos coeficientes 
    % ( Cm  e  θm ) da Série de Fourier trigonométrica com o valor de  
    % m_max  da Série de Fourier pedido ao utilizador. Considerar o 
    % seguinte algoritmo para o cálculo dos coeficientes: (ver enunciado)

    % Input
    % t -> sequência temporal  t, durante um período, vetor coluna
    % x_t -> sinal  x(t), vetor coluna
    % T0 -> período fundamental,  T0, do sinal a analisar
    % m_max -> m maximo
    
    % Output: 
    % C_m -> Coeficiente Cm, Cm = (a.^2 + b.^2).^0.5
    % teta_m -> Coeficiente θm, θm = atan(b ./ a)

    
    % Create array of all zeros
    A = zeros(length(t), 2*m_max + 2);


    for k=0 : m_max
        A( : , k + 1) = cos(2*pi/T0*t*k);
        A( : , m_max + 1 + k + 1) = -sin(2*pi/T0*t*k);
    end
    
    % Moore-Penrose pseudoinverse
    % The Moore-Penrose pseudoinverse is a matrix that can act as a partial 
    % replacement for the matrix inverse in cases where it does not exist. 
    % This matrix is frequently used to solve a system of linear equations 
    % when the system does not have a unique solution or has many solutions.
    coef = pinv(A)*x_t;


    a = coef(1 : m_max + 1);


    b = coef(m_max + 2 : 2*m_max + 2);

    % Array size, nl-by-nc matrix, nl -> linhas, nc -> colunas
    [nl, nc] = size(a);
    
    % se a e b < 0.001, entao a e b = 0
    for lin = 1 : nl
        for col = 1 : nc
            if abs( a(lin, col) ) < 0.001 && abs( b(lin, col) ) < 0.001
                a(lin, col) = 0; 
                b(lin, col) = 0;
            end
        end
    end

    % C_m = (a.^2 + b.^2).^0.5
    C_m = abs(a + b*1i);       

    % teta_m = atan(b ./ a)
    teta_m = angle(a + b*1i);  

end

