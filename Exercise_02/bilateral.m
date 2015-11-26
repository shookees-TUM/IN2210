% Applies a bilateral filter to an Image (matrix) I
% returning a filtered matrix J
% border can be treated: "mirror" or "multiply"
% filter mask of size 3*sigma times 3*sigma pixels
% central pixel = x ; neighboring pixel =  xi
% desired amount of spatial smoothing: sigma_d
% desired amount of combining of pixel values: sigma_r
% range is 0: use range and domain filter, 1: range filter only
function J = bilateral(I, sigma, sigma_d, sigma_r, border, use_range)
    image_size = size(I);
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
    if use_range == 0    
        for x = -pad(1): pad(1)
            for y = -pad(2): pad(2)
                d(x + pad(1) + 1, y + pad(2) + 1) = sqrt(x^2 + y^2);
            end
        end
        C = exp( -0.5 * (d / sigma_d ).^2 );
    elseif use_range == 1
        C = ones(size_kernel);
    end

    % actual filtering process:
    % i and j refer to a position in the (padded) image
    for i = 1 + pad(1): image_size(1) + pad(1)
        for j = 1 + pad(2): image_size(2) + pad(2)
            % get matrix subsection [of size of kernel] around (i,j)
            subsection = padded_I(i - pad(1): i + pad(1), j - pad(2): j + pad(2));
            abs_I_xi_I_x = abs(subsection - padded_I(i,j));
            S = exp( -0.5 * ( abs_I_xi_I_x / sigma_r ).^2 );
            % (see lecture 2 page 75 (of 77))
            % normalization missing!
            J(i,j) = 1 / sum( sum( C .* S ) ) * sum( sum(subsection .* C .* S) );
        end
    end
end