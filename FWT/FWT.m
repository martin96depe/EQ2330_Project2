f = [1 1 4 -3 0 1 2 5 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 1 1 1 1 1 1 1 2 8 4 1 5];
%f = [1 4 -3 0];

% 1-D FWT and iWFT
[approximation_coef, detail_coef] = analysis_f(f,db4);
out = synthesis_f(approximation_coef,detail_coef,db4);

%reco_img = idwt2(Hi_Hi, Hi_Lo, Lo_Hi, Lo_Lo,'db4');

X = imread("images/harbour512x512.tif");
Y = imread("images/boats512x512.tif");
Z = imread("images/peppers512x512.tif");
PSNR_WFT = zeros(3,10);
PSNR_ORG = zeros(3,10);
x = zeros(1,10);
rate = zeros(1,10);
for i = 1:length(PSNR_WFT)
    % 2-D FWT compresion
    x(i) = 2^(i-1);
    rate(i) = ceil(log2(x(i)));
    
    for image = 1:3
        switch image
            case 1
                img = X;
            case 2
                img = Y;
            case 3
                img = Z;
        end
        org_img = mat2gray(double(img));
        reco_img = FWT_compress(img,x(i), db10);
        PSNR_WFT(image,i) = psnr(org_img,reco_img);
        
        max1 = max(max(img));
        min1 = min(min(img));
        levels = linspace(double(min1), double(max1),x(i));
        quantized_org_img = quan(img , levels);
        PSNR_ORG(image, i) = psnr(org_img,mat2gray(quantized_org_img));
    end
end

%%
hold on;
for i = 1:3
    plot(rate,PSNR_WFT(i,:),rate,PSNR_ORG(i,:));
end
legend('Wavelet Domain harbour','Spatial Domain harbour','Wavelet Domain boat','Spatial Domain boat','Wavelet Domain peppers','Spatial Domain peppers');
title('Plot of PSNR versus different bit rate');
xlabel('Bit rate');
ylabel('PSNR');
hold off


%d1 = distortion(org_img,reco_img)
%d2 = distortion(org_img,mat2gray(X2))

%imshow(mat2gray(reco_img));

%%
reco_img = FWT_compress(X,2^3, db10);

