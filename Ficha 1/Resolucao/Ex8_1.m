function [g, Hg, Pg] = Ex8_1(a, k, c, N, H0, P0)
    g = 0 : 1 : N;
    Hg = NaN(N+1,1);
    Pg = NaN(N+1,1);

    Hg(1) = H0;
    Pg(1) = P0;

    for kg=2 : N+1
        Hg(kg) = k * Hg(kg-1) * exp(-1 * a * Pg(kg-1));
        Pg(kg) = c * Hg(kg-1) * (1 - exp(-1 * a * Pg(kg-1)));
    end
    
end

