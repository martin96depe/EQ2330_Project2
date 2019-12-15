%% DCT-Based Image compression 
%this problem investigates the rate-distortion performance of a transform
%image code using a DCT for 8x8 blocks of an image
%% 2.2 Blockwise 8x8 DCT
M = 8;
dct_mask = mydct_mask(M);

%% 2.3 DCT coefficients quantization
up = max(dct_mask(:));
low = min(dct_mask(:));

step = [2^0 2^1 2^2 2^3 2^4 2^5 2^6 2^7 2^8 2^9];

%% quantizer curve
x = -10:0.01:10;
y = x;

lv = linspace(min(x(:)),max(x(:)),step(5));

figure;
plot(x,y,'b',x,quan(y,lv),'r');
title(['quantization curve with step ', num2str(step(5))]);

%% 2.4 Distortion and Bit-Rate Estimation

PSNR = zeros(1,length(step));
d = zeros(1,length(step));
q_mask_list = zeros(M,M,length(step));

for i=1:length(step)
    levels = linspace(low, up, step(i));
    q_dct = quan(dct_mask,levels);
    q_mask_list(:,:,i)=q_dct;
    PSNR(1,i)=psnr(dct_mask,q_dct);
    d(1,i) = mse(dct_mask,q_dct);
end

num_lv = 0:length(step)-1;

figure;
plot(num_lv,PSNR,'b',num_lv,10*log10(d),'r'); title('PSNR vs distortion (dct mask vs quantized dct mask)  [dB]');
legend('PSNR','distortion');

%% 

boats = im2double(imread('boats512x512.tif'));
harbour = im2double(imread('harbour512x512.tif'));
peppers = im2double(imread('peppers512x512.tif'));

Boats = dct2(boats);
Harbour = dct2(harbour);
Peppers = dct2(peppers);



PSNRim = zeros(3,length(step));
dist = zeros(3,length(step));


for i=1:length(step)
    %boats
    levels1 = linspace(min(min(Boats)),max(max(Boats)),step(i));
    qBoats = quan(Boats,levels1);
    boats_hat = idct2(qBoats);
    
    PSNRim(1,i) = psnr(boats,mat2gray(boats_hat));
    dist(1,i) = mse(boats,mat2gray(boats_hat));
    
    %harbour
    levels2 = linspace(min(min(Harbour)),max(max(Harbour)),step(i));
    qHarbour = quan(Harbour,levels2);
    harbour_hat = idct2(qHarbour);
    
    PSNRim(2,i) = psnr(harbour,mat2gray(harbour_hat));
    dist(2,i) = mse(harbour,mat2gray(harbour_hat));
    
    %peppers
    levels3 = linspace(min(min(Peppers)),max(max(Peppers)),step(i));
    qPeppers = quan(Peppers,levels3);
    peppers_hat = idct2(qPeppers);
    
    PSNRim(3,i) = psnr(peppers,mat2gray(peppers_hat));
    dist(3,i) = mse(peppers,mat2gray(peppers_hat));
end

%%
figure; 
plot(num_lv,PSNRim(1,:),'b',num_lv,10*log10(dist(1,:)),'r'); 
title('PSNR vs distortion (boats) [dB]');
legend('PSNR','distortion');
figure; 
plot(num_lv,PSNRim(2,:),'b',num_lv,10*log10(dist(2,:)),'r');
title('PSNR vs distortion (harbour) [dB]');
legend('PSNR','distortion');
figure; 
plot(num_lv,PSNRim(3,:),'b',num_lv,10*log10(dist(3,:)),'r');
title('PSNR vs distortion (peppers) [dB]');
legend('PSNR','distortion');

%% Average block bit-rate per quantization step
R = zeros(1, length(step));
for i=1:length(step)
    R(i) = mean2(entropy(q_mask_list(:,:,i)));
end




