%% Project 2 EQ2330
%% DCT-Based Image compression 
%this problem investigates the rate-distortion performance of a transform
%image code using a DCT for 8x8 blocks of an image
%% Blockwise 8x8 DCT
M = 8;
dct_mask = zeros(M);

for x=0:M-1
    for y=0:M-1
        if x==0
            dct_mask(x+1,y+1) = sqrt(1/M);
        else
            dct_mask(x+1,y+1) = sqrt(2/M)*cos(((2*y +1)*x*pi)/(2*M));
        end
    end
end


