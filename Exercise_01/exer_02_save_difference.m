% Load image 2D Gaussian
H = imread('2DG.jpg');
% Load image 1D Gaussian
I = imread('1DG.jpg');
% Take squared difference
image_size = size(H)
for i = 1:1:image_size(1)
    for j = 1:1:image_size(2)
        J(i,j) = (H(i,j) - I(i,j))^2
    end
end
imagesc(J);
% Save squared difference image
%imwrite(J, 'C:\Users\Hans\Documents\GitHub\IN2210\Exercise_01\square_diff_sigma.jpg', 'jpg')