function [Hi_Hi,Hi_Lo,Lo_Hi,Lo_Lo] = FWT_2D(X, filter)
    img_size = length(X);
    temp1 = zeros([img_size,img_size/2]);
    temp2 = zeros([img_size,img_size/2]);
    for col = 1:length(X)
        [temp1(col,:),temp2(col,:)] = analysis_f(X(col,:),filter);
    end

    Hi_Hi = zeros([img_size/2,img_size/2]);
    Hi_Lo = zeros([img_size/2,img_size/2]);
    Lo_Hi = zeros([img_size/2,img_size/2]);
    Lo_Lo = zeros([img_size/2,img_size/2]);
    for row = 1:img_size/2
        [Hi_Hi(:,row),Hi_Lo(:,row)] = analysis_f(temp1(:,row),filter);
        [Lo_Hi(:,row),Lo_Lo(:,row)] = analysis_f(temp2(:,row),filter);
    end
    
    %{
    Hi_Hi = mat2gray(Hi_Hi);
    Hi_Lo = mat2gray(Hi_Lo);
    Lo_Hi = mat2gray(Lo_Hi);
    Lo_Lo = mat2gray(Lo_Lo);
    %}
    
end