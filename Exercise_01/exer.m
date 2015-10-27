H = ones(3, 3);
H = H./9;
%H(2, 2) = -8;
I = imread('test.gif');
J = convoluteImage(H, I, 'multiply');
colormap(gray(256)); 
image(J);
%pause; 