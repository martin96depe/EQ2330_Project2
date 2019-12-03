function OUT = quan(IN, levels)
    OUT = zeros(size(IN));
    step = levels(2) - levels(1);
       
    for x = 1 : size(IN,1)
        for y = 1 : size(IN,2)
            indx = find(levels-step/2 <= IN(x,y),1,'last');
            OUT(x,y) = levels(indx);
        end
    end
end

%X_quantized = my_quantize(reco_img,10);
%imshow(mat2gray(X_quantized));

%{
v = linspace(0,1, 2048);
T = .1;
vI = floor(abs(v/T)).*sign(v);
plot(v, vI);
axis('tight');
title(strcat(['Quantized integer values, T=' num2str(T)]));
X_quantized = discretize(reco_img, vI);
imshow(mat2gray(X_quantized));
%}