% Exercise 1
I = imread('lena.gif');
median_filter_size = [5, 5];
J = medianFilter(I, median_filter_size, 'mirror');
figure('Name', 'Exercise 1.a');
colormap(gray(256)); 
% Original image
subplot(1, 2, 1);
image(I);
title('Original');
daspect([1 1]);
subplot(1, 2, 2);
image(J);
title('Median Filtered');
daspect([1 1]);
%pause;

% noise takes on 10% of image (or in range [0..1] it's 0.1)
noise_scale = 0.1;
I_gaussian_noise = noise(I, 'gaussian', 0.8); % Make it really noticeable
I_saltpepr_noise = noise(I, 'saltandpepper', 0.2);
figure('Name', 'Exercise 1.b');
colormap(gray(256));
subplot(1, 3, 1);
image(I);
title('Original');
daspect([1 1]);
subplot(1, 3, 2);
image(I_gaussian_noise);
title('Gaussian noise');
daspect([1 1]);
subplot(1, 3, 3);
image(I_saltpepr_noise);
title('Salt and pepper noise');
daspect([1 1]);
%1.c Apply gaussian filter
addpath ../Exercise_01
s = 1;
gauss_size = s * 3;
gaussian_filter = gaussian2D(gauss_size, s);
gaussian_filtered_gaussian_noise = convoluteImage(gaussian_filter, I_gaussian_noise, 'multiply');
gaussian_filtered_saltpepper_noise = convoluteImage(gaussian_filter, I_saltpepr_noise, 'multiply');
median_filtered_gaussian_noise = medianFilter(I_gaussian_noise, median_filter_size, 'multiply');
median_filtered_saltpepper_noise = medianFilter(I_saltpepr_noise, median_filter_size, 'multiply');
figure('Name', 'Exercise 1.c');
colormap(gray(256));
subplot(2, 3, 1);
image(I_gaussian_noise);
title('With gaussian noise');
daspect([1 1]);
subplot(2, 3, 2);
image(gaussian_filtered_gaussian_noise);
title('Gaussian noise filtered with gaussian');
daspect([1 1]);
subplot(2, 3, 3);
image(median_filtered_gaussian_noise);
title('Gaussian noise filtered with median');
daspect([1 1]);
subplot(2, 3, 4);
image(I_saltpepr_noise);
title('With salt and pepper noise');
daspect([1 1]);
subplot(2, 3, 5);
image(gaussian_filtered_saltpepper_noise);
title('Salt and pepper filtered with gaussian');
daspect([1 1]);
subplot(2, 3, 6);
image(median_filtered_saltpepper_noise);
title('Salt and pepper filtered with median');
daspect([1 1]);

% Exercise 2
% a) Implement a bilateral filter with a filter mask of size 3*sigma times 3*sigma pixels
% see bilateral.m

% b) Apply this filter on the Lena image with sigma = 1, 5 and 10
% filter mask size: 3*sigma times 3*sigma pixels
% central pixel = x ; neighboring pixel =  xi
% desired amount of spatial smoothing:
sigma_d = 10;
% desired amount of combining of pixel values:
sigma_r = 30;

J_B1  = bilateral(I, 1, sigma_d, sigma_r, 'mirror');
J_B5  = bilateral(I, 5, sigma_d, sigma_r, 'mirror');
% IMPLEMENT EVEN SIGMAS!
J_B10 = bilateral(I, 11, sigma_d, sigma_r, 'mirror');

figure('Name', 'Exercise 2b)');
colormap(gray(256)); 
% Original image
subplot(2, 2, 1);
image(I);
title('Original');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Bilateral filter with sigma = 1 applied
subplot(2, 2, 2);
image(J_B1);
title('Bilateral filtered Image (sigma = 1)');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Bilateral filter with sigma = 5 applied
subplot(2, 2, 3);
image(J_B5);
title('Bilateral filtered Image (sigma = 5)');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Bilateral filter with sigma = 1 applied
subplot(2, 2, 4);
image(J_B10);
title('Bilateral filtered Image (sigma = 10)');
daspect([1 1 1]); % Keeps aspect ratio 1:1
%pause; 