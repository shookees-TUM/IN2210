% Exercise 1
I = imread('checkerboard_tunnel.png');
sizeI = size(I);
% part a)
% see harrisR.m
% part b)
% part c)
% define Harris parameters
sigma_dif = 3;
sigma_int = 3;
alpha = 0.05; % 0.04<alpha<0.06
t = 0.01; % threshold for non-maximum suppression
n = 3; % number of layers / octaves (including downsampling)
k = 3; % number of iterations in one octave
%
Rsingle = harrisR(I, sigma_dif, sigma_int, alpha, t);
%
R = multiscale_harris(I, sigma_dif, sigma_int, n, k, 0.05, 0.01);
I = double(I);
% define RI
RI = zeros(sizeI(1), sizeI(2), n);
for i = 1 : n
    RI(:,:,i) = R(:,:,i) + I(:,:);
end
%
figure('Name', 'Exercise 1.c');
colormap(gray(256)); 
% Original image
subplot(2, 2, 1);
image(Rsingle+I);
title('Harris R 1D + I');
daspect([1 1 1]);
subplot(2, 2, 2);
image(RI(:,:,1));
title('RI n=1');
daspect([1 1 1]);
subplot(2, 2, 3);
image(RI(:,:,2));
title('RI n=2');
daspect([1 1 1]);
subplot(2, 2, 4);
image(RI(:,:,3));
title('RI n=3');
daspect([1 1 1]);
%pause;