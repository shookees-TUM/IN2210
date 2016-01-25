function R_max = harrisR(I, sigma_dif, sigma_int, alpha, t)
% input: I is the image, sigma determines kernel size and Gaussian smooting
% input parameters: scale level n, initial scale value s0, scale step k,
% constant factor alpha(0.04<alpha<0.06), threshold value for R: t
%
% define derivative in x and y direction
img.orig = double(I)
d_dx = double([-1, 0, 1; -1, 0, 1; -1, 0, 1]);
d_dy = d_dx';
% Gaussian smoothing filter (differentiating):
G_dif = gauss2D(sigma_dif);
% Gaussian smoothing filter (integrating):
G_int = gauss2D(sigma_int);
% use associativity law of convolution
% generate kernel in x and y direction
% (consisting of Gaussian smoothing and derivative)
k_x = conv2(d_dx, G_dif);
k_y = conv2(d_dy, G_dif);

% filter image with kernel above
img.x = conv2(k_x, img.orig);
img.y = conv2(k_y, img.orig);
% define matrix M which represents a first order approximation
% (2D Taylor expansion) of [I(x, y) - I(x + delta_x, y + delta_y)]^2
% see lecture03 p.20ff
% M = 2DGaussian *convolve* [L_x.^2, L_x .* L_y; L_x .* L_y, L_y.^2];

Ix2g = conv2(G_int, img.x.^2);
Ixyg = conv2(G_int, img.x .* img.y);
Iy2g = conv2(G_int, img.y.^2);
% determine R for every pixel of the input image I
for i = 1: size(img.orig, 1)
    for j = 1: size(img.orig, 2)
        M = [Ix2g(i, j), Ixyg(i, j); Ixyg(i, j), Iy2g(i, j)];
        R_temp = det(M) - alpha*trace(M)^2;
        % R = lambda1 * lambda2 + alpha*(lambda1 + lambda2)^2
        % with lambda1, lambda2 being the eigenvalues of M
        % set threshold for R (lecture03 p.35):
        if R_temp > t
            R(i, j) = R_temp;
        else 
            R(i, j) = 0;
        end
    end
end

% implement non-maximum suppresion
% search for maximum in 3x3 or 5x5 window
window_size = 3;
margin = floor(window_size / 2);
R0 = zeros(size(img.orig) + 2 * margin);

R0(1 + margin: size(img.orig, 1) + margin, 1 + margin: size(img.orig, 2) + margin) = R;
for i = 1: size(img.orig, 1)
    for j = 1: size(img.orig, 2)
        R_temp = R0(i:i + 2 * margin - 1, j: j + 2 * margin - 1);
        if R(i, j) == max(max(R_temp))
            R_max(i, j) = R(i,j);
        else 
            R_max(i, j) = 0;
        end
    end
end
end