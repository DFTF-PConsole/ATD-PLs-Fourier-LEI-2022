function x_n = entradaSistema(m) % função que define um dado sinal de tempo discreto

    % Create array of all zeros
    x_n = zeros(size(m));
    
    % Find indices and values of nonzero elements
    % (u[n+40]−u[n−40])
    indices = find((m>=-40) & (m<40));
    
    % calculo dos valores
    % x[n]=1.5sin[0.025πn](u[n+40]−u[n−40])
    x_n(indices) = 1.5 * sin(0.025 * pi * m(indices));
    
end

