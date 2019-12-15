function DWT = FWT2(im,filter,scale)
    [Lo_Lo, Lo_Hi,Hi_Lo, Hi_Hi] = FWT_2D(im,filter);
    
    % concatenate coefficients in a single image
    DWT = cat(1,[Lo_Lo Lo_Hi],[Hi_Lo Hi_Hi]);
    DWT = mat2gray(DWT);

    if scale >= 2
        a{1,1} = Lo_Lo;
        for k=2:scale
            [a{1,k},b{1,k},c{1,k},d{1,k}] = FWT_2D(a{1,k-1},filter);
            Dwt{1,k} = cat(1,[a{1,k} b{1,k}],[c{1,k} d{1,k}]);
            Dwt{1,k} = mat2gray(Dwt{1,k});
            DWT(1:size(DWT,1)*(0.5)^(k-1),1:size(DWT,2)*(0.5)^(k-1)) = Dwt{1,k};
        end
    end
end