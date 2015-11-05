% Exercise 1
H = ones(3);
% Seems that H./9 was meant, as it is the case in the theory slides
H = H./9;
I = imread('lena.gif');
J = convoluteImage(H, I, 'multiply');
figure('Name', 'Exercise 1');
colormap(gray(256)); 
% Original image
subplot(1, 2, 1);
image(I);
title('Original');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Convoluted image
subplot(1, 2, 2);
image(J);
title('Convoluted');
daspect([1 1 1]); % Keeps aspect ratio 1:1
%pause; 
% End of Exercise 1

% Exercise 2
% Get 2D Gaussian filter for sigma = 1
sigma = 1;
mask_size = 3 * sigma;
G2D_sigma1 = gaussian2D(mask_size, sigma);
tic;
I_G2D_sigma1 = convoluteImage(G2D_sigma1, I, 'multiply');
I_G2D_sigma1_time = toc;

% Get 2D Gaussian filter for sigma = 3
sigma = 3;
mask_size = 3 * sigma;
G2D_sigma3 = gaussian2D(mask_size, sigma);
tic;
I_G2D_sigma3 = convoluteImage(G2D_sigma3, I, 'multiply');
I_G2D_sigma3_time = toc;

% Get 1D Gaussian filter for sigma = 1
sigma = 1;
mask_size = 3 * sigma;
G1D_sigma1 = gaussian1D(mask_size, sigma);
tic;
I_G1D_sigma1 = convoluteImage(G1D_sigma1,  I, 'multiply');
I_G1D_sigma1 = convoluteImage(G1D_sigma1', I_G1D_sigma1, 'multiply');
I_G1D_sigma1_time = toc;

% Get 1D Gaussian filter for sigma = 3
sigma = 3;
mask_size = 3 * sigma;
G1D_sigma3 = gaussian1D(mask_size, sigma);
tic;
I_G1D_sigma3 = convoluteImage(G1D_sigma3,  I, 'multiply');
I_G1D_sigma3 = convoluteImage(G1D_sigma3', I_G1D_sigma3, 'multiply');
I_G1D_sigma3_time = toc;

figure('Name', 'Exercise 2.a');
colormap(gray(256)); 
subplot(2, 2, 1);
image(I_G2D_sigma1);
title('Sigma = 1 Gaussian 2D');
daspect([1 1 1]);
subplot(2, 2, 2);
image(I_G2D_sigma3);
title('Sigma = 3 Gaussian 2D');
daspect([1 1 1]);
subplot(2, 2, 3);
image(I_G1D_sigma1);
title('Sigma = 1 Gaussian 1D');
daspect([1 1 1]);
subplot(2, 2, 4);
image(I_G1D_sigma3);
title('Sigma = 3 Gaussian 1D');
daspect([1 1 1]);
%pause;

% Squared differences
diff_sigma1 = I_G2D_sigma1 - I_G1D_sigma1;
diff_sigma1 = diff_sigma1.^2;
diff_sigma1_scale = max(max(max(diff_sigma1)));
diff_sigma1 = 255 / diff_sigma1_scale * diff_sigma1;
%diff_sigma1 = abs(diff_sigma1)
diff_sigma3 = I_G2D_sigma3 - I_G1D_sigma3;
diff_sigma3 = diff_sigma3.^2;
diff_sigma3_scale = max(max(max(diff_sigma3)));
diff_sigma3 = 255 / diff_sigma3_scale * diff_sigma3;
figure('Name', 'Exercise 2.b');
colormap(gray(256)); 
subplot(1, 2, 1);
image(diff_sigma1);
title('Sigma = 1 difference');
daspect([1 1 1]);
subplot(1, 2, 2);
image(diff_sigma3);
title('Sigma = 3 difference');
daspect([1 1 1]);

% Time differences
disp('Exercise 2.c');
disp('2D sigma took:'), disp(I_G2D_sigma1_time), disp('s for sigma = 1'),
disp(I_G2D_sigma3_time), disp('s for sigma = 3');
disp('2 times 1D sigma took:'), disp(I_G1D_sigma1_time), disp('s for sigma = 1'),
disp(I_G1D_sigma3_time), disp('s for sigma = 3');
% End of Exercise 2
% Exercise 3

% define basic grandient filters
Dx = [-1, 0, 1;
      -1, 0, 1;
      -1, 0, 1];
Dy = transpose(Dx);

% compute x gradient image
GradX = convoluteImage(Dx, I, 'multiply');
% compute y gradient image
GradY = convoluteImage(Dy, I, 'multiply');
figure('Name', 'Exercise 3.a');
colormap(gray(256)); 
subplot(1, 2, 1);
image(GradX);
title('x-direction gradient image');
daspect([1 1 1]);
subplot(1, 2, 2);
image(GradY);
title('y-direction gradient image');
daspect([1 1 1]);

% gradient magnitude
grad_I = GradX.^2 + GradY.^2;
grad_I = sqrt(grad_I);
%grad_I = grad_I.^0.5;
% gradient orientation
Psi_grad_I = 180 / pi * atan2(GradY, GradX);
figure('Name', 'Exercise 3.b');
subplot(1, 2, 2);
image(Psi_grad_I);
title('Gradient orientation');
daspect([1 1 1]);
colormap(gray(256));
subplot(1, 2, 1);
image(grad_I);
title('Gradient magnitude');
daspect([1 1 1]);


% Use associativity law for I_x = D_x * (G * I)
% First compute I_x = D_x * (G * I)
cIx_kernel = convoluteImage(G2D_sigma1, I, 'multiply');
cIx = convoluteImage(Dx, cIx_kernel, 'multiply');
cIy_kernel = convoluteImage(G2D_sigma1, I, 'multiply');
cIy = convoluteImage(Dy, cIy_kernel, 'multiply');

figure('Name', 'Exercise 3.c Noise Reduction');
colormap(gray(256));
subplot(1, 2, 1);
image(cIx);
title('Noise reduction x-direction Grad*(Gauss*Image)');
daspect([1 1 1]);
subplot(1, 2, 2);
image(cIy);
title('Noise reduction y-direction Grad*(Gauss*Image)');
daspect([1 1 1]);

% gradient magnitude
grad_GI = cIx.^2 + cIy.^2;
grad_GI = sqrt(grad_GI);
%grad_I = grad_I.^0.5;
% gradient orientation
Psi_grad_GI = 180 / pi * atan2(cIy, cIx);
figure('Name', 'Exercise 3.d Grad*(Gauss*Image)');
subplot(1, 2, 2);
image(Psi_grad_GI);
title('Gradient orientation');
daspect([1 1 1]);
colormap(gray(256));
subplot(1, 2, 1);
image(grad_GI);
title('Gradient magnitude');
daspect([1 1 1]);


% Use associativity law for I_x = D_x * (G * I)
% To get I_x = (D_x * G) * I
cIIx_kernel = convolution(G2D_sigma1, Dx, 'multiply');
cIIx = convoluteImage(cIIx_kernel, I, 'multiply');
cIIy_kernel = convolution(G2D_sigma1, Dy, 'multiply');
cIIy = convoluteImage(cIIy_kernel, I, 'multiply');

figure('Name', 'Exercise 3.c (Grad*Gauss)*Image');
colormap(gray(256));
subplot(1, 2, 1);
image(cIIx);
title('Noise reduction x-direction');
daspect([1 1 1]);
subplot(1, 2, 2);
image(cIIy);
title('Noise reduction y-direction');
daspect([1 1 1]);

% gradient magnitude
grad_GII = cIIx.^2 + cIIy.^2;
grad_GII = sqrt(grad_GII);
%grad_I = grad_I.^0.5;
% gradient orientation
Psi_grad_GII = 180 / pi * atan2(cIIy, cIIx);
figure('Name', 'Exercise 3.d (Grad*Gauss)*Image');
subplot(1, 2, 2);
image(Psi_grad_GII);
title('Gradient orientation');
daspect([1 1 1]);
colormap(gray(256));
subplot(1, 2, 1);
image(grad_GII);
title('Gradient magnitude');
daspect([1 1 1]);
