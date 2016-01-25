function R_max = harrisR(I, sigma_dif, sigma_int, alpha, t)
%%%
% Why? Just because I can
% Harris feature detector for 3 dimensional image. This might not make sense, but
% It's an expansion for formula having additional z parameter and resultant 1st order series are:
% 
%%%
% input: I is the image, sigma determines kernel size and Gaussian smooting
% input parameters: scale level n, initial scale value s0, scale step k,
% constant factor alpha(0.04<alpha<0.06), threshold value for R: t
%
d = {} % 3Dderivates
d.x = [[-1, 0, 1;
       -1, 0, 1;
       -1, 0, 1;],
       [-1, 0, 1;
       -1, 0, 1;
       -1, 0, 1],
       [-1, 0, 1;
       -1, 0, 1;
       -1, 0, 1]];
d.y = [[-1, -1, -1;
        0, 0, 0;
        1, 1, 1],
        [-1, -1, -1;
        0, 0, 0;
        1, 1, 1]];
d.z = [[-1, -1, -1;
        -1, -1, -1;
        -1, -1, -1],
       [0, 0, 0;
        0, 0, 0;
        0, 0, 0],
       [1, 1, 1;
        1, 1, 1;
        1, 1, 1]];
% Gaussian smoothing filter (differentiating):
gauss.dif = gauss3D(sigma_dif);
% Gaussian smoothing filter (integrating):
gauss.int = gauss3D(sigma_int);
% use associativity law of convolution
% generate kernel in x and y direction
% (consisting of Gaussian smoothing and derivative)
k_x = convn(d.x, gauss.dif);
% convn - multidimensional convolution
k_y = convn(d.y, gauss.dif);
% add padding before filtering

sigma = max(sigma_dif, sigma_int);
kernel_size = [3*sigma, 3*sigma];
pad = floor(kernel_size /2);
size_I = size(I);
padded_I = addpadding(I, kernel_size, 'multiply');
% filter image with kernel above
L_x = conv2(k_x, padded_I);
L_y = conv2(k_y, padded_I);
% define matrix M which represents a first order approximation
% (2D Taylor expansion) of [I(x, y) - I(x + delta_x, y + delta_y)]^2
% see lecture03 p.20ff
% M = 2DGaussian *convlove* [L_x.^2, L_x .* L_y; L_x .* L_y, L_y.^2];
N11 = L_x.^2;
N12 = L_x .* L_y;
N22 = L_y.^2;
M11 = conv2(G_int, N11);
M12 = conv2(G_int, N12);
M22 = conv2(G_int, N22);
% determine R for every pixel of the input image I
% preallocate R
R = zeros(size_I);
for i = pad(1)+1 : pad(1)+size_I(1)
    for j = pad(2)+1 : pad(2)+size_I(2)
        M = [M11(i-pad(1), j-pad(2)), M12(i-pad(1), j-pad(2)); M12(i-pad(1), j-pad(2)), M22(i-pad(1), j-pad(2))];
        R_temp = det(M) - alpha*trace(M)^2;
        % R = lambda1 * lambda2 + alpha*(lambda1 + lambda2)^2
        % with lambda1, lambda2 being the eigenvalues of M
        % set threshold for R (lecture03 p.35):
        if R_temp > t
            R(i-pad(1), j-pad(2)) = R_temp;
        else R(i-pad(1), j-pad(2)) = 0;
        end
    end
end
% implement non-maximum suppresion
% search for maximum in 3x3 or 5x5 window
window_size = 3;
margin = floor(window_size /2 );
R0 = zeros(size_I(1) + 2*margin, size_I(2) + 2*margin);
size_R0 = size(R0);
%is_size_R = size(R0(1+margin: size_I(1)+margin, 1+margin:size_I(2)+margin));
%size_R = size(R);
R0(1+margin: size_I(1)+margin, 1+margin:size_I(2)+margin) = R;
R_max = zeros(size_I);
for i = 1 + margin : size_R0(1) - 2*margin
    for j = 1 + margin : size_R0(2) - 2*margin
        R_temp = R0(i-margin:i+margin, j-margin:j+margin);
        if R(i,j) == max(max(R_temp))
            R_max(i-margin, j-margin) = R0(i,j);
        else R_max(i-margin, j-margin) = 0;
        end
    end
end
%sizeR_max = size(R_max);
end