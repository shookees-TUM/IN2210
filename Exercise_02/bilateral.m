% Applies a bilateral filter to an Image (matrix) I
% returning a filtered matrix J
% border can be treated: "mirror" or "multiply"
% filter mask of size 3*sigma times 3*sigma pixels
% central pixel = x ; neighboring pixel =  xi
% desired amount of spatial smoothing: sigma_d
% desired amount of combining of pixel values: sigma_r
% range is 0: use range and domain filter, 1: range filter only
function J = bilateral(I, sigma, sigma_d, sigma_r, border, range)
% Determine size of image (for loop)
image_size = size(I);
% cast class of input image I
I = double(I);
% add padding to image
size_kernel = [3*sigma, 3*sigma];
padded_I = addpadding(I, size_kernel, border);
% get start and stop index for for loop
pad = floor(size_kernel / 2);
%
% generate domain smoothing matrix C(x, xi):
% domain (smoothing) filter c(x, xi)
% c = exp( -1/2 ( abs( xi - x ) / sigma_d )^2 )
if range == 0    
    for x = -pad(1):pad(1)
        for y = -pad(2):pad(2)
            distance(x+pad(1)+1, y+pad(2)+1) = sqrt(x^2 + y^2);
        end
    end
    C = exp( -1/2 * ( distance / sigma_d ).^2 );
elseif range == 1
    C = ones(size_kernel);
end
% preallocate J for speed reasons
J = zeros(image_size(1), image_size(2));
% actual filtering process:
% i and j refer to a position in the (padded) image
for i = (pad(1)+1):(image_size(1) + pad(1))
    for j = (pad(2)+1):(image_size(2) + pad(2))
        % get matrix subsection [of size of kernel] around (i,j)
        sub_I = padded_I(i-pad(1):i+pad(1), j-pad(2):j+pad(2));
        % generate range filter matrix S(x, xi)
        % range filter s(x, xi)
        % s = exp( -1/2 ( abs( I(xi) - I(x) ) / sigma_r )^2 )
        abs_I_xi_I_x = sqrt( sum( sum( (sub_I-padded_I(i,j)*ones(size_kernel, 'like', padded_I)).^2)));
        S = exp( -1/2 * ( abs_I_xi_I_x / sigma_r )^2 );
        % (see lecture 2 page 75 (of 77))
        % normalization missing!
        J(i,j) = 1 / sum( sum( C .* S ) ) * sum( sum(sub_I .* C .* S) );
    end
end
end