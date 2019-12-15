function [im_rec, coefficient_bins_q, coefficient_bins] = blockDCT(img,M,step)

rowblock = size(img,1)/M; 
colblock = size(img,2)/M; 

coefficient_bins = zeros(rowblock, colblock, M, M);
coefficient_bins_q = zeros(rowblock, colblock, M, M);
im_rec = zeros(size(img));

for i=1:rowblock
    for j=1:colblock
        %extract block form image
        row_idx = (i-1)*M +1:i*M;
        cols_idx = (j-1)*M +1:j*M;
        
        b = img(row_idx,cols_idx);
        
        %block dct
        dct_b = dct2(b);
        
        %quantization
        dct_b_q = quan(dct_b, 1/step);
        
        %store coefficient
        coefficient_bins(i,j,:,:) = dct_b;
        coefficient_bins_q(i,j,:,:) = dct_b_q; %quantized
        
        %inverse dct
        bhat = idct2(dct_b_q);
        im_rec(row_idx,cols_idx) = bhat;
        
    end
end


end