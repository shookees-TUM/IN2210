%%% Exercise 1
img.original = imread('lena.gif');
median_filter.size = [5, 5];
img.median_filtered = medianFilter(img.original, median_filter.size, 'mirror');

figure('Name', 'Exercise 1.a');
colormap(gray(256)); 
% Original image
subplot(1, 2, 1);
title('Original');
image(img.original);
daspect([1 1 1]);
subplot(1, 2, 2);
title('Median Filtered');
image(img.median_filtered);
daspect([1 1 1]);

img.gaussian_noise(:, :) = noise(img.original, 'gaussian', 0.6); % Make it really noticeable
img.saltnpepper_noise(:, :) = noise(img.original, 'saltandpepper', 0.1);

figure('Name', 'Exercise 1.b');
colormap(gray(256));
subplot(1, 3, 1);
title('Original');
image(img.original);
daspect([1 1 1]);
subplot(1, 3, 2);
title('Gaussian noise');
image(img.gaussian_noise);
daspect([1 1 1]);
subplot(1, 3, 3);
title('Salt and pepper noise');
image(img.saltnpepper_noise);
daspect([1 1 1]);

% 1.c Apply gaussian filter
% Use Gaussian filter from 1st exercise
addpath ../Exercise_01
s = 1; % Sigma
gauss_size = s * 3;
filters.gaussian2D1 = gaussian2D(gauss_size, s);
img.gaussian_filtered_gaussian_noise = convoluteImage(filters.gaussian2D1, img.gaussian_noise, 'multiply');
img.gaussian_filtered_saltpepper_noise = convoluteImage(filters.gaussian2D1, img.saltnpepper_noise, 'multiply');
img.median_filtered_gaussian_noise = medianFilter(img.gaussian_noise, median_filter.size, 'multiply');
img.median_filtered_saltpepper_noise = medianFilter(img.saltnpepper_noise, median_filter.size, 'multiply');

figure('Name', 'Exercise 1.c');
colormap(gray(256));
subplot(2, 3, 1);
title('Gaussian noise');
image(img.gaussian_noise);
daspect([1 1 1]);
subplot(2, 3, 2);
title('Gaussian noise filtered with gaussian filter');
image(img.gaussian_filtered_gaussian_noise);
daspect([1 1 1]);
subplot(2, 3, 3);
title('Gaussian noise filtered with median filter');
image(img.median_filtered_gaussian_noise);
daspect([1 1 1]);
subplot(2, 3, 4);
title('Salt and pepper noise');
image(img.saltnpepper_noise);
daspect([1 1 1]);
subplot(2, 3, 5);
title('Salt and pepper filtered with gaussian filter');
image(img.gaussian_filtered_saltpepper_noise);
daspect([1 1 1]);
subplot(2, 3, 6);
title('Salt and pepper filtered with median filter');
image(img.median_filtered_saltpepper_noise);
daspect([1 1 1]);

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

img.bilateral1  = bilateral(img.original, 1, sigma_d, sigma_r, 'mirror', 0);
img.bilateral5  = bilateral(img.original, 5, sigma_d, sigma_r, 'mirror', 0);
% TODO:IMPLEMENT EVEN SIGMAS!
img.bilateral10 = bilateral(img.original, 11, sigma_d, sigma_r, 'mirror', 0);

figure('Name', 'Exercise 2b)');
colormap(gray(256)); 
% Original image
subplot(2, 2, 1);
title('Original');
image(img.original);
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Bilateral filter with sigma = 1 applied
subplot(2, 2, 2);
title('Bilateral filtered Image (sigma = 1)');
image(img.bilateral1);
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Bilateral filter with sigma = 5 applied
subplot(2, 2, 3);
title('Bilateral filtered Image (sigma = 5)');
image(img.bilateral5);
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Bilateral filter with sigma = 1 applied
subplot(2, 2, 4);
title('Bilateral filtered Image (sigma = 10)');
image(img.bilateral10);
daspect([1 1 1]); % Keeps aspect ratio 1:1

% c) Compare bilateral range filter to normal Gaussian smoothing with sigma = 1, 5, 10

%2D sigma = 1 filters is already there
img.gaussian2D1 = convoluteImage(filters.gaussian2D1, img.original, 'mirror');
filters.gaussian2D5 = gaussian2D(15, 5);
img.gaussian2D5 = convoluteImage(filters.gaussian2D5, img.original, 'mirror');
% TODO: IMPLEMENT EVEN SIGMAS!
filters.gaussian2D10 = gaussian2D(33, 11);
img.gaussian2D10 = convoluteImage(filters.gaussian2D10, img.original, 'mirror');

% Plot comparison of Gaussian and Bilateral Filtering
figure('Name', 'Exercise 2c)');
colormap(gray(256)); 
% Bilateral Range filter with sigma = 1 applied
subplot(2, 3, 1);
title('Bilateral Range sigma = 1');
image(img.bilateral1);
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Bilateral Range filter with sigma = 5 applied
subplot(2, 3, 2);
title('Bilateral Range sigma = 5');
image(img.bilateral5);
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Bilateral Range filter with sigma = 10 applied
subplot(2, 3, 3);
title('Bilateral Range sigma = 10');
image(img.bilateral10);
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Gaussian smoothing filter with sigma = 1 applied
subplot(2, 3, 4);
title('Gaussian smoothing sigma = 1');
image(img.gaussian2D1);
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Gaussian smoothing filter with sigma = 5 applied
subplot(2, 3, 5);
title('Gaussian smoothing sigma = 5');
image(img.gaussian2D5);
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Gaussian smoothing filter with sigma = 10 applied
subplot(2, 3, 6);
title('Gaussian smoothing sigma = 10');
image(img.gaussian2D10);
daspect([1 1 1]); % Keeps aspect ratio 1:1

% d) Can you implement the bilateral filter with simple convolution masks? Why or why not?
% No. Convolution is linear. Bilateral filter is non-linear.
% Implementation-wise:  convolution has a constant kernel
%                       range filter has a dynamic kernel (dependent on (i,j)[pixel position])

% e) State the difference between domain filter and range filter
% Both take a distance, but:    domain filter uses a spatial difference (constant)
%                               range filter uses intensity difference (dynamic)