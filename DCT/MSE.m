function dist = MSE(img, img_q)

dist = sum((img(:)-img_q(:)).^2)/length(img(:));
end