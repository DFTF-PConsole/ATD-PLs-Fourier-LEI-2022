function out = Ex6(n)
    if n <= 1
        out = 0;
        
    else
        out = 1;
        for k=2:n
            out = out * k;
        end

    end

end