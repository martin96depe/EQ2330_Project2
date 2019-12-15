function bits = bitRate(coefficient_bins, M)

H = zeros(M);

for row = 1:M
    for column = 1:M
        i_coeff = coefficient_bins(:,:,row,column);
        
        [occ, ~] = hist(i_coeff(:), unique(i_coeff(:)));
        p = occ ./ sum(occ);
        
        entropy = -sum(p .* log2(p));
        H(row, column) = entropy;
    end
end
% figure;
% surf(H);   
bits = mean2(H);

end

