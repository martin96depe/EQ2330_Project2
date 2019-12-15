function mat = mydct(in_img, dct_mask)
    [r_in, c_in] = size(in_img);
    M = size(dct_mask,1);
    block_x = floor(c_in/M);
    block_y = floor(r_in/M);
    
    out = zeros(block_y*M,block_x*M);
    
    for i=1:M:(block_y*M)  %i #row
        for j=1:M:(block_x*M)   %j #cols
            out(i:i+(M-1),j:j+(M-1)) = dct_mask.*in_img(i:i+(M-1),j:j+(M-1)).*dct_mask';
        end
    end
    
    mat = out;
   
end