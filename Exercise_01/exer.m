H = ones(3);
H(2, 2) = -8;
I = imread('lena.gif');
J = convoluteImage(H, I, 'mirror');
colormap(gray(256)); 
image(J);
%pause; 