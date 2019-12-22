function [d,PSNR,R] = dist_bitrate(step)

M=8;

    
boats = im2double(imread('boats512x512.tif'));
harbour = im2double(imread('harbour512x512.tif'));
peppers = im2double(imread('peppers512x512.tif'));

im_size = [size(boats,1),size(boats,2)];

img_list = zeros(im_size(1),im_size(2), 3);
img_list(:,:,1) = boats;
img_list(:,:,2) = harbour;
img_list(:,:,3) = peppers;


rowblock = im_size(1)/M; 
colblock = im_size(2)/M; 

coefficient_bins = zeros(rowblock,colblock,3,M,M);

distortion_list = zeros(1,3);

for idx=1:size(img_list,3)
    
    img = img_list(:,:,idx);
    img_rec = zeros(size(img));
    
    for i=1:rowblock
        for j=1:colblock
            
            %extract block form image
            row_idx = (i-1)*M +1:i*M;
            cols_idx = (j-1)*M +1:j*M;
            
            b = img(row_idx,cols_idx);
            
            %block dct
            dct_b = dct2(b);
            
            %quantization
            dct_b_q = quantizer(dct_b, step);

            %store coefficient
            coefficient_bins(i,j,idx,:,:) = dct_b_q;
            
            %inverse dct
            bhat = idct2(dct_b_q);
            img_rec(row_idx,cols_idx) = bhat;

            
        end
    end
    
    distortion_list(idx) = MSE(img_rec,img);
    
end

d = mean(distortion_list);
PSNR = 10 * log10( 255^2 / d );

H = zeros(M);

for row = 1:M
    for column = 1:M
        i_coeff = coefficient_bins(:,:,:,row,column);
        
        [occ, ~] = hist(i_coeff(:), unique(i_coeff(:)));
        p = occ ./ sum(occ);
        
        entropy = -sum(p .* log2(p));
        H(row, column) = entropy;
    end
end

R = sum(H(:));



end