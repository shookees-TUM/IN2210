% Exercise 1
H = ones(3);
% Seems that H./9 was meant, as it is the case in the theory slides
H = H./9;
I = imread('lena.gif');
J = convoluteImage(H, I, 'multiply');
figure
colormap(gray(256)); 
% Original image
subplot(1, 2, 1);
image(I);
daspect ([1 1]); % Keeps aspect ratio 1:1
% Convoluted image
subplot(1, 2, 2);
image(J);
daspect ([1 1]); % Keeps aspect ratio 1:1
pause; 
% End of Exercise 1

% Exercise 2
sigma = 3;
dimGauss = 2;
mask_size = 3 * sigma;
G2D = gaussian2D(mask_size, sigma);

