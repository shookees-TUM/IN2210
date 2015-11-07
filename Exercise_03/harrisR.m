function R = harrisR(I, sigma_dif, sigma_int, n, s0, k, alpha, t)
% input: I is the image, sigma determines kernel size and Gaussian smooting
% input parameters: scale level n, initial scale value s0, scale step k,
% constant factor alpha(0.04<alpha<0.06), threshold value for R: t
%
% define derivative in x and y direction
d_dx = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
d_dy = transpose(d_dx);
% Gaussian smoothing filter (differentiating):
G_dif = gaussian2D(sigma_dif);
% Gaussian smoothing filter (integrating):
G_int = gaussian2D(sigma_int);
% use associativity law of convolution
% generate kernel in x and y direction
% (consisting of Gaussian smoothing and derivative)
k_x = convolve(d_dx, G_dif);
k_y = convolve(d_dy, G_dif);
% add padding before filtering
sigma = max(sigma_dif, sigma_int);
kernel_size = [3*sigma, 3*sigma];
pad = floor(kernel_size /2);
size_I = size(I);
padded_I = addpadding(I, kernel_size, 'multiply');
% filter image with kernel above
L_x = convolve(k_x, padded_I);
L_y = convolve(k_y, padded_I);
% define matrix M which represents a first order approximation
% (2D Taylor expansion) of [I(x, y) - I(x + delta_x, y + delta_y)]^2
% see lecture03 p.20ff
% M = 2DGaussian *convolve* [L_x.^2, L_x .* L_y; L_x .* L_y, L_y.^2];
N11 = L_x.^2;
N12 = L_x .* L_y;
N22 = L_y.^2;
M11 = convolve(G_int, N11);
M12 = convolve(G_int, N12);
M22 = convolve(G_int, N22);
% determine R for every pixel of the input image I
% preallocate R
R = zeros(size_I);
for i = pad(1)+1 : pad(1)+size_I(1)
    for j = pad(2)+1 : pad(2)+size_I(2)
        % M in for loops? can 
        R_temp = det(M) - alpha*trace(M)^2;
        % R = lambda1 * lambda2 + alpha*(lambda1 + lambda2)^2
        % with lambda1/2 being the eigenvalues of M
        % set threshold for R (lecture03 p.35):
        if R_temp > t
            R(i-pad(1), j-pad(2)) = det(M) - alpha*trace(M)^2;
        else R(i-pad(1), j-pad(2)) = 0;
        end
    end
end
% implement non-maximum suppresion

end