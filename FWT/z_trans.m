function F = z_trans(f)
    z = sym('z');
    F = 0;
    for i = 0:length(f)-1
        F=F+f(i+1)*z^(-i);
    end
end