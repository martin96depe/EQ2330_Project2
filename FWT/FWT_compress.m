function reco_img = FWT_compress(X,step_size, filter)
    % 2-D FWT
    [Hi_Hi,Hi_Lo,Lo_Hi,Lo_Lo] = FWT_2D(X,filter);
    %quantize
    one1 = [Hi_Hi Hi_Lo Lo_Hi Lo_Lo];
    max1 = max(max(max(one1)));
    min1 = min(min(min(one1)));
    levels = linspace(min1, max1,step_size);
    Hi_Hi = quan(Hi_Hi , levels);
    Hi_Lo = quan(Hi_Lo , levels);
    Lo_Hi = quan(Lo_Hi , levels);
    Lo_Lo = quan(Lo_Lo , levels);

    subplot(2,2,1), imshow(mat2gray(Hi_Hi));
    subplot(2,2,2), imshow(mat2gray(Hi_Lo));
    subplot(2,2,3), imshow(mat2gray(Lo_Hi));
    subplot(2,2,4), imshow(mat2gray(Lo_Lo));

    % 2-D iFWT
    reco_img = iFWT_2D(Hi_Hi,Hi_Lo,Lo_Hi,Lo_Lo,filter);
end

