function Ex4(type)                             % type: s ou n    (a => all)
    if type == 's' || type == 'a'              % simbolico
        syms f(x,y);
        f(x,y) = sin(x * y) + cos(x);
        
        figure;
        fsurf(f, [-4 4]);
        title('f(x,y)=sin(xy)+cos(x) | Simbolico, fsurf()');
        xlabel('x');
        ylabel('y');
        zlabel('f(x,y)');

        %syms x y
        %fxy=sin(x*y)+cos(x);
        %figure;
        %fmesh(fxy,[-4 4 -4 4]);
        %xlabel('x');
        %ylabel('y');
        %zlabel('f(x,y)');
        %title('f(x,y)=sin(xy)+cos(x) | Simbolico, fmesh()')

    end

    if type == 'n' || type == 'a'              % numerico
        x = -4 : 0.1 : 4;
        y = x;

        [X, Y] = meshgrid(x, y);

        f = sin(X .* Y) + cos(X);
        
        %f = 2 * X.*X + 2 * Y.*Y - 4;  % teste
        
        figure;
        surf(X, Y, f);  % ou mesh(X,Y,f)
        title('f(x,y)=sin(xy)+cos(x) | Numerico, surf()');
        xlabel('x');
        ylabel('y');
        zlabel('f(x,y)');

        %figure;
        %contourf(X, Y, f);
        %title('Numerico: contourf()');
        %xlabel('x');
        %ylabel('y');
        %zlabel('f');

        %figure;
        %plot3(X, Y, f);
        %title('Numerico: plot3()');
        %xlabel('x');
        %ylabel('y');
        %zlabel('f');

    end

end