%% DCT-Based Image compression 
%this problem investigates the rate-distortion performance of a transform
%image code using a DCT for 8x8 blocks of an image
%% 2.1 Blockwise 8x8 DCT
M = 8;
dct_mask = mydct_mask(M);



%% 2.2 Uniform Quantizer 
step = [2^0 2^1 2^2 2^3 2^4 2^5 2^6 2^7 2^8 2^9];

stepq = 0.1;
x=-1:0.01:1;

figure; 
scatter(x, quan(x, stepq), 5, 'filled'); 
title(['quantization curve with step ', num2str(stepq)]); 
saveas(gcf, ['quantization_curve_with_step', num2str(stepq), '.jpg']);

%% 2.4 Distortion and Bit-Rate Estimation (test on one image)
% loop over the images and over steps

boats = im2double(imread('boats512x512.tif'));
harbour = im2double(imread('harbour512x512.tif'));
peppers = im2double(imread('peppers512x512.tif'));

img_list = zeros(512,512,3);
img_list(:,:,1) = boats;
img_list(:,:,2) = harbour;
img_list(:,:,3) = peppers;

dist_list = zeros(length(step),1,size(img_list,3));
mse_list = zeros(length(step),1,size(img_list,3));
psnr_list = zeros(length(step),1,size(img_list,3));
bits_list = zeros(length(step),1,size(img_list,3));

% dct_b_list = zeros(M,M,3);
% dct_b_q_list = zeros(M,M,3);

for i=1:size(img_list,3)
    for s=1:length(step)
        
        [img_rec, coefficient_bins_q, coefficient_bins] = blockDCT(img_list(:,:,i),M,step(s));
        
        mse_list(s,1,i) = mse(coefficient_bins_q(1,1,:,:), coefficient_bins(1,1,:,:));
        dist_list(s,1,i) = mse(img_rec,img_list(:,:,i));
        psnr_list(s,1,i) = 10 * log10( 255^2 / dist_list(s,1,i) );
        
        bits_list(s,1,i) = bitRate(coefficient_bins_q,M);
        
    end
end

%% plot Bitrate vs PSNR

figure;
plot(bits_list(:,1,1),psnr_list(:,1,1),'r',bits_list(:,1,2),psnr_list(:,1,2),'g',bits_list(:,1,3),psnr_list(:,1,3),'b');
xlabel('BITS'); ylabel('PSNR [dB]');
legend('boats','harbour','peppers');
title('BitRate vs PSNR');
saveas(gcf,'bitRateVsPsnrDCT.jpg');

%% plot Distortion 
x=0:length(step)-1;
figure;
plot(x,dist_list(:,:,1),'r',x,dist_list(:,:,2),'g',x,dist_list(:,:,3),'b'); 
xlabel('Quntization steps'); ylabel('distorsion');
legend('boats','harbour','peppers');
title('Distorsion Images vs quantization steps');
saveas(gcf,'distortion.jpg');

figure;
plot(x,dist_list(:,:,1),'r',x,mse_list(:,:,1),'g'); 
xlabel('Quntization steps'); ylabel('Mean Square Error');
legend('distortion in img','MSE DCT');
title('MSE of image and DCT coeff over quantization steps');
saveas(gcf,'distVsMSE_DCT.jpg');


