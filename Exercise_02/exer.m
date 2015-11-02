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