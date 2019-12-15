function out = entropy(mat)
    [r,c]= size(mat);
    out = zeros(r,c);
    for i = 1:r
        for j = 1:c
            val = sum(sum(mat == mat(i,j)));
            p = val/(r*c);
            h = sum(p.*log2(1./p));
            out(i,j) = h;
        end
    end
end
