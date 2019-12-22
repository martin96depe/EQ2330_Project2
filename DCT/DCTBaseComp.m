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
scatter(x, quantizer(x, stepq), 5, 'filled'); 
title(['quantization curve with step ', num2str(stepq)]); 
saveas(gcf, ['quantization_curve_with_step', num2str(stepq), '.jpg']);

%% 2.4 Distortion and Bit-Rate Estimation (test on one image)
% loop over the images and over steps

d_list = zeros(1,length(step));
PSNR_list = zeros(1,length(step));
R_list = zeros(1,length(step));

for s=1:length(step)
    
    [d_list(s),PSNR_list(s),R_list(s)] = dist_bitrate(step(s));
    
end

%%
x=0:length(step)-1;
figure;
plot(x,PSNR_list,'b',x,R_list,'r');
figure;
plot(R_list,PSNR_list);



%% plot Bitrate vs PSNR

figure;
plot(R_list(:,1,1),PSNR_list(:,1,1),'r',R_list(:,1,2),PSNR_list(:,1,2),'g',R_list(:,1,3),PSNR_list(:,1,3),'b');
xlabel('BITS'); ylabel('PSNR [dB]');
legend('boats','harbour','peppers');
title('BitRate vs PSNR');
saveas(gcf,'bitRateVsPsnrDCT.jpg');

%% plot Distortion 
x=0:length(step)-1;
figure;
plot(x,d_list(:,:,1),'r',x,d_list(:,:,2),'g',x,d_list(:,:,3),'b'); 
xlabel('Quntization steps'); ylabel('distorsion');
legend('boats','harbour','peppers');
title('Distorsion Images vs quantization steps');
saveas(gcf,'distortion.jpg');

figure;
plot(x,d_list(:,:,1),'r',x,mse_list(:,:,1),'g'); 
xlabel('Quntization steps'); ylabel('Mean Square Error');
legend('distortion in img','MSE DCT');
title('MSE of image and DCT coeff over quantization steps');
saveas(gcf,'distVsMSE_DCT.jpg');


