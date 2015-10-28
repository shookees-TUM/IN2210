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
daspect([1 1]); % Keeps aspect ratio 1:1
% Convoluted image
subplot(1, 2, 2);
image(J);
title('Convoluted');
daspect([1 1]); % Keeps aspect ratio 1:1
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
daspect([1 1]);
subplot(2, 2, 2);
image(I_G2D_sigma3);
title('Sigma = 3 Gaussian 2D');
daspect([1 1]);
subplot(2, 2, 3);
image(I_G1D_sigma1);
title('Sigma = 1 Gaussian 1D');
daspect([1 1]);
subplot(2, 2, 4);
image(I_G1D_sigma3);
title('Sigma = 3 Gaussian 1D');
daspect([1 1]);
%pause;

% Squared differences
diff_sigma1 = I_G2D_sigma1 - I_G1D_sigma1;
diff_sigma1 = diff_sigma1.^2;
diff_sigma3 = I_G2D_sigma3 - I_G1D_sigma3;
diff_sigma3 = diff_sigma3.^2;
figure('Name', 'Exercise 2.b');
colormap(gray(256)); 
subplot(1, 2, 1);
image(diff_sigma1);
title('Sigma = 1 difference');
daspect([1 1]);
subplot(1, 2, 2);
image(diff_sigma3);
title('Sigma = 3 difference');
daspect([1 1]);

% Time differences
printf('Exercise 2.c\n');
printf('2D sigma took:\n %d s for sigma = 1\n %d s for sigma = 3\n', I_G2D_sigma1_time, I_G2D_sigma3_time);
printf('2 times 1D sigma took:\n %d s for sigma = 1\n %d s for sigma = 3\n', I_G1D_sigma1_time, I_G1D_sigma3_time);
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
daspect([1 1]);
subplot(1, 2, 2);
image(GradY);
title('y-direction gradient image');
daspect([1 1]);

% gradient magnitude
grad_I = GradX.^2 + GradY.^2;
grad_I = grad_I.^0.5;
% gradient orientation
Psi_grad_I = atan2(Grady, Gradx);
figure('Name', 'Exercise 3.b');
colormap(gray(256));
subplot(1, 2, 1);
image(grad_I);
title('Gradient magnitude');
daspect([1 1]);
subplot(1, 2, 2);
image(Psi_grad_I);
title('Gradient orientation');
daspect([1 1]);

% Use associativity law for I_x = D_x * (G * I)
% To get I_x = (D_x * G) * I
cIx_kernel = convolution(G2D_sigma1, Dx, 'multiply');
cIx = convoluteImage(cIx_kernel, I, 'multiply');
cIy_kernel = convolution(G2D_sigma1, Dy, 'multiply');
cIy = convoluteImage(cIy_kernel, I, 'multiply');

figure('Name', 'Exercise 3.c');
colormap(gray(256));
subplot(1, 2, 1);
image(cIx);
title('Noise reduction x-direction');
daspect([1 1]);
subplot(1, 2, 2);
image(cIy);
title('Noise reduction y-direction');
daspect([1 1]);
