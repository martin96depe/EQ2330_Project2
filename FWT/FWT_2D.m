function [Lo_Lo, Lo_Hi,Hi_Lo, Hi_Hi] = FWT_2D(X, filter)
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
        [Lo_Lo(:,row),Lo_Hi(:,row)] = analysis_f(temp1(:,row),filter);
        [Hi_Lo(:,row),Hi_Hi(:,row)] = analysis_f(temp2(:,row),filter);
    end  
end