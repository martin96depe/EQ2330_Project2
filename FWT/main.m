%% FWT
%the whole point 3, project 2

No_images = 3;
% the smaller step the better it is
stepq = [2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9];
load matlab/coeffs.mat

im{1} = 255*im2double(imread('images/peppers512x512.tif'));
im{2} = 255*im2double(imread("images/harbour512x512.tif"));
im{3} = 255*im2double(imread("images/boats512x512.tif"));
 
%figure;
DWT = FWT2(im{2},db4,4);
% Show scale 4 DWT coefficients
imshow(DWT);
 
%Uniform quantizertization of wavelet transform
Lo_R = db4./norm(db4);   %reconstruction LPF
Lo_D = wrev(Lo_R);  %decomposition LPF
Hi_R = qmf(Lo_R);   %reconstruction HPF
Hi_D = wrev(Hi_R);  %decomposition HPF
 
%compute for each image
for image_n = 1:No_images
    [Lo_Lo{image_n}, Lo_Hi{image_n},Hi_Lo{image_n}, Hi_Hi{image_n}] = dwt2(im{image_n},Lo_R,Hi_R); %FWT_2D(im, db4); %
end

step_count = 1:length(stepq);

Lo_Loq = zeros(size(Lo_Lo{1},1),size(Lo_Lo{1},2),length(step_count),No_images);
Lo_Hiq = zeros(size(Lo_Lo{1},1),size(Lo_Lo{1},2),length(step_count),No_images);
Hi_Loq = zeros(size(Lo_Lo{1},1),size(Lo_Lo{1},2),length(step_count),No_images);
Hi_Hiq = zeros(size(Lo_Lo{1},1),size(Lo_Lo{1},2),length(step_count),No_images);
recq = zeros(size(im{1},1),size(im{1},2),length(step_count),3);
mse_wav = zeros(length(step_count),No_images);
mse_org = zeros(length(step_count),No_images);
entropy = zeros(length(step_count),No_images);
rates = zeros(length(step_count),No_images);
Psnr_wav = zeros(length(step_count),No_images);
Psnrs_org = zeros(length(step_count),No_images);
% Uniformely quantizertize values
for k = step_count
    %compute for each image
    for image_n = 1:No_images        
        Lo_Loq(:,:,k,image_n) = quantizer(Lo_Lo{image_n},stepq(k));
        Lo_Hiq(:,:,k,image_n) = quantizer(Lo_Hi{image_n},stepq(k));
        Hi_Loq(:,:,k,image_n) = quantizer(Hi_Lo{image_n},stepq(k));
        Hi_Hiq(:,:,k,image_n) = quantizer(Hi_Hi{image_n},stepq(k));

        % Reconstruct images
        recq(:,:,k,image_n) = idwt2(Lo_Loq(:,:,k,image_n),Lo_Hiq(:,:,k,image_n),Hi_Loq(:,:,k,image_n),Hi_Hiq(:,:,k,image_n),Lo_D,Hi_D);
        % compute distortion
        mse_wav(k,image_n) = distortion(im{image_n},recq(:,:,k,image_n));
        % compute entropy
        entropy(k,image_n) = bitRate(Lo_Loq(:,:,k,image_n),Lo_Hiq(:,:,k,image_n),Hi_Loq(:,:,k,image_n),Hi_Hiq(:,:,k,image_n),stepq(k));
        Psnr_wav(k,image_n) = PSNR(mse_wav(k,image_n));
        
        org_quan = quantizer(im{image_n},stepq(k));
        mse_org(k,image_n) = distortion(im{image_n},org_quan);
        rates(k,image_n) = bitrate_orgimg(org_quan,stepq(k));
        Psnrs_org(k,image_n) = PSNR(mse_org(k,image_n));
    end
end
 
%avearge
%use entropy as ideal bit rates per coefficient
%for wavelet quantization
rates_wav = mean(entropy,2);
psnrs_wav = mean(Psnr_wav,2);

%for original image quantization
rates_org = mean(rates,2);
psnrs_org = mean(Psnrs_org,2);

figure;
imshow(recq(:,:,8,2),[]);
title('DWT reconstruction for q=128');

figure;
plot(rates_wav, psnrs_wav, '+-', 'linewidth', 2);
title('Performance vs bitrate (DWT)');
grid on;
xlabel('[Bits per pixel] rate');
ylabel('[dB] PSNR');


%plot psnr for each 
figure;
plot(entropy(:,1), Psnr_wav(:,1), 'linewidth', 2);
hold on;
plot(entropy(:,2), Psnr_wav(:,2), 'linewidth', 2);
plot(entropy(:,3), Psnr_wav(:,3), 'linewidth', 2);
hold off;
title('Performance vs bitrate (DWT)');
grid on;
xlabel('[Bits per pixel] rate');
ylabel('[dB] PSNR');
legend('peppers','harbour','boats');
hold off;

%plot em together
%{
figure;
plot(rates_org, psnrs_org, '+-', 'linewidth', 2);
title('Performance vs bitrate (DWT vs quantization of original image)');
grid on;
xlabel('[Bits per pixel] rate');
ylabel('[dB] PSNR');
hold;
plot(rates_wav, psnrs_wav, '+-', 'linewidth', 2);
legend('Orginal img quan','DWT - Daubechies 8 wavelet');
%}