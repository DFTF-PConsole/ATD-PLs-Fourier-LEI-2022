function out = Ex7(n)
    if n <= 0
        out = 0;
    elseif n == 1
        out = 1;
    else
        cache = NaN(n+1,1);
        cache(1) = 0;
        cache(2) = 1;

        for k=3:n+1
            cache(k) = cache(k-1) + cache(k-2);
        end

        out = cache(n+1);
    end
end

