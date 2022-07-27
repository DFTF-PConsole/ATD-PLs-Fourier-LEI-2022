function out = simpson(f_x, x1, xn, n)

    % calcula h para o nº de pontos n (impar)
    h = (xn-x1)/n;    
    
    % Obter valor da função nos pontos intermédios separados por h un. de tempo
    
    % Para i par
    x_p = x1+h:2*h:xn+h;
    sum_f_p = sum(double(subs(f_x, x_p)));

    % Para i ímpar
    x_i = x1+2*h:2*h:xn-h;
    sum_f_i=sum(double(subs(f_x, x_i)));

    % Obter valores extremos
    f_x1 = double(subs(f_x, x1));
    f_xn = double(subs(f_x, xn));

    % Calcular o valor final do integral
    out = (h/3) * (f_x1 + f_xn + 4*sum_f_p + 2*sum_f_i);

end

