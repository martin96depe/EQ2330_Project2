function d = distortion(img1,img2)

    d = 0;
    for x = 1 : size(img1,1)
        for y = 1 : size(img1,2)
            d = d + (img1(x,y) - img2(x,y))^2;
        end
    end
    
    d = d/(size(img1,1)*size(img1,2));
end

