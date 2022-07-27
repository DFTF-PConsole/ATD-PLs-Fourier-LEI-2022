function vet_coef = Ex5(x, y, grau)
    vet_coef = polyfit(x, y, grau);

    g = vet_coef(1) * x .* x + vet_coef(2) * x + vet_coef(3);

    %x2=0:0.2:10;
    %ge=polyval(vet_coef, x2);

    figure;
    plot(x, y, 'o', x, g, '-r');
    title('Numerico: plot()');
    xlabel('Tempo [s]');
    ylabel('y(t)');
    legend('Dados','Ajuste de 2ª ordem','Location','northwest');
    
end

