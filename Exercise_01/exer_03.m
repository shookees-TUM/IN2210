% exercise 3
% part a)
% define basic grandient filters
Dx = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
Dy = transpose(Dx);
% Load image
I = imread('lena.gif');
colormap(gray(256)); 
% Original image
subplot(2, 3, 1);
image(I);
title('Original');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% compute x gradient image
Gradx = convoluteImage(Dx, I, 'mirror');
% x gradient image
subplot(2, 3, 2);
image(Gradx);
title('x Gradient');
daspect([1 1 1]); % Keeps aspect ratio 1:1
%pause; 
% compute y gradient image
Grady = convoluteImage(Dy, I, 'mirror');
% x gradient image
subplot(2, 3, 3);
image(Grady);
title('y Gradient');
daspect([1 1 1]); % Keeps aspect ratio 1:1
%pause; 
%
% part b)
% gradient magnitude
grad_I = sqrt( Gradx .* Gradx + Grady .* Grady );
% gradient orientation
Psi_grad_I = atan2( Gradx, Grady );
% display gradient magnitude
subplot(2, 3, 4);
image(grad_I);
%imagesc(grad_I);
title('Gradient Magnitude');
daspect([1 1 1]); % Keeps aspect ratio 1:1
% diplay gradient orientation
subplot(2, 3, 5);
image(grad_I);
%imagesc(Psi_grad_I);
title('Gradient Orientation');
daspect([1 1 1]); % Keeps aspect ratio 1:1