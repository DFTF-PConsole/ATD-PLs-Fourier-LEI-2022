function out = trapezio(f_x, x1, xn, n)

    % calcula h para o nº de pontos n
    h = (xn-x1)/n;      

    % Obter valores intermédios de tempo
    x = x1+h:h:xn-h;    

    % Obter valores extremos
    f_x1 = double(subs(f_x, x1));
    f_xn = double(subs(f_x, xn));

    % Calcular o integral
    out = h*( ((f_x1+f_xn)/2) + sum(double(subs(f_x, x))) );

end