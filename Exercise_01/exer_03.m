% exercise 3
% a)
% define basic grandient filters
Dx = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
Dy = transpose(Dx);
% Load image
I = imread('lena.gif');
% compute x gradient image
Gradx = convoluteImage(Dx, I, 'mirror');
% compute y gradient image
Grady = convoluteImage(Dy, I, 'mirror');
% b)
% gradient magnitude
grad_I = sqrt((Gradx)^2 + (Grady)^2);
% gradient orientation
Psi_grad_I = atan2(Gradx / Grady);
% display gradient magnitude
imagesc(grad_I);
% diplay gradient orientation
imagesc(Psi_grad_I);
