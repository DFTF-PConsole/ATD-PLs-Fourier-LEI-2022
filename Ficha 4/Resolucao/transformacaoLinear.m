function [n_alterado, x_n_alterado] = transformacaoLinear(n, x_n, a, b)
    % transformação linear da variável independentede de um sinal de tempo discreto
    % x[n] -> x[a*n - b]

    % escala alterada
    n_alterado_aux = (n+b)/a;
    
    % sinal nos pontos (inteiros) da nova escala
    x_n_alterado_aux = x_n(mod(n_alterado_aux, 1)==0);
    
    % tempo discreto (só com inteiros)
    n_alterado_aux_int = n_alterado_aux(mod(n_alterado_aux, 1)==0);
    
    % escala temporal normalizada
    n_alterado = min(n_alterado_aux_int):max(n_alterado_aux_int);

    % sinal resultante de acordo com escala normalizada
    x_n_alterado(n_alterado_aux_int - min(n_alterado_aux_int) + 1) = x_n_alterado_aux;
    
end

