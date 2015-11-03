% Exercise 1
I = imread('lena.gif');
filter_size = [5, 5];
J = medianFilter(I, filter_size, 'multiply');
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
I_gaussian_noise = noise(I, 'gaussian', 0.1);
I_saltpepr_noise = noise(I, 'saltandpepper', 0.1);
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

