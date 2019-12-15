function reco_img = iFWT_2D(Hi_Hi,Hi_Lo,Lo_Hi,Lo_Lo, filter)

    reco_img = zeros(size(Hi_Hi)*2);
    temp1 = zeros(size(Hi_Hi,1)*2,size(Hi_Hi,1));
    for row = 1:size(temp1,2)
        temp1(:,row) = synthesis_f(Hi_Hi(:,row),Hi_Lo(:,row),filter);
    end
    temp2 = zeros(size(Hi_Hi,1)*2,size(Hi_Hi,1));
    for row = 1:size(temp2,2)
        temp2(:,row) = synthesis_f(Lo_Hi(:,row),Lo_Lo(:,row),filter);
    end

    for col = 1:length(reco_img)
        reco_img(col,:) = synthesis_f(temp1(col,:),temp2(col,:),filter);
    end
    
    %normalize image
    reco_img = mat2gray(reco_img);
end