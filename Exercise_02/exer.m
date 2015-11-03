% Exercise 1
I = imread('lena.gif');
filter_size = [5, 5];
J = medianFilter(I, filter_size, 'multiply');
figure('Name', 'Exercise 1');
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




% Exercise 2
% a) Implement a bilateral filter with a filter mask of size 3*sigma times 3*sigma pixels
% see bilateral.m

% b) Apply this filter on the Lena image with sigma = 1, 5 and 10
% filter mask size: 3*sigma times 3*sigma pixels
% central pixel = x ; neighboring pixel =  xi
% desired amount of spatial smoothing:
sigma_d = 10
% desired amount of combining of pixel values:
sigma_r = 30

J_B1  = bilateral(I, 1, sigma_d, sigma_r)
J_B5  = bilateral(I, 5, sigma_d, sigma_r)
J_B10 = bilateral(I, 10, sigma_d, sigma_r)

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

% c) Compare bilateral range filter to normal Gaussian smoothing with sigma = 1, 5, 10

J_BR1  =
J_BR5  =
J_BR10 =
J_G1  =
J_G5  =
J_G10 =

figure('Name', 'Exercise 2c)');
colormap(gray(256)); 
% Bilateral Range filter with sigma = 1 applied
subplot(2, 3, 1);
image(J_BR1);
title('Bilateral Range sigma = 1');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Bilateral Range filter with sigma = 5 applied
subplot(2, 3, 2);
image(J_BR5);
title('Bilateral Range sigma = 5');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Bilateral Range filter with sigma = 10 applied
subplot(2, 3, 3);
image(J_BR10);
title('Bilateral Range sigma = 10');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Gaussian smoothing filter with sigma = 1 applied
subplot(2, 3, 4);
image(J_G1);
title('Gaussian smoothing sigma = 1');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Gaussian smoothing filter with sigma = 5 applied
subplot(2, 3, 5);
image(J_G5);
title('Gaussian smoothing sigma = 5');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% Gaussian smoothing filter with sigma = 10 applied
subplot(2, 3, 6);
image(J_G10);
title('Gaussian smoothing sigma = 10');
daspect([1 1 1]); % Keeps aspect ratio 1:1
%pause; 

% d) Can you implement the bilateral filter with simple convolution masks? Why or why not?
% No. Convolution is linear. Bilateral filter is non-linear.

% e) State the difference between domain filter and range filter
% 



