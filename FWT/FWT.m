f = [1 1 4 -3 0 1 2 5 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 1 1 1 1 1 1 1 2 8 4 1 5];
%f = [1 4 -3 0];
step_size = 2^3;

% 1-D FWT and iWFT
[approximation_coef, detail_coef] = analysis_f(f,db4);
out = synthesis_f(approximation_coef,detail_coef,db4);

% 2-D FWT compresion
X = imread("images/harbour512x512.tif");
reco_img = FWT_compress(mat2gray(X),step_size, db10);

org_img = mat2gray(double(X));
peaksnr1 = psnr(org_img,reco_img)
X2 = org_img;
levels2 = linspace(0, 1,step_size);
X2 = quan(X2 , levels2);
peaksnr2 = psnr(org_img,mat2gray(X2))

d1 = distortion(org_img,reco_img)
d2 = distortion(org_img,mat2gray(X2))

imshow(mat2gray(reco_img));
