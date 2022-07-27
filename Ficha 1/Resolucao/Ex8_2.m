function Ex8_2(a, k, c, N, H0, P0)
    [g, Hg, Pg] = Ex8_1(a, k, c, N, H0, P0);
    
    figure;
    plot(g, Hg, 'b-*', g, Pg, 'r-o');
    title('Nicholson–Bailey: Evolução das populações de Hospedeiros e Parasitas');
    xlabel('Gerações');
    ylabel('Crescimento Populacional');
    legend({'Hospedeiros','Parasitas'},'Location','northeast');

end

