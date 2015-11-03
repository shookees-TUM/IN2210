% Applies a bilateral filter to an Image (matrix) I
% returning a filtered matrix J
% border can be treated: "mirror" or "multiply"

% (border treatment not implemented) maybe extract "padding.m" from
% convolution.m ?

% filter mask of size 3*sigma times 3*sigma pixels
% central pixel = x ; neighboring pixel =  xi
% desired amount of spatial smoothing: sigma_d
% desired amount of combining of pixel values: sigma_r
function J = bilateral(I, sigma, sigma_d, sigma_r)

% domain (smoothing) filter c(x, xi)
c = exp( -1/2 ( abs( xi - x ) / sigma_d )^2 )
% range filter s(x, xi)
s = exp( -1/2 ( abs( I(xi) - I(x) ) / sigma_r )^2 )



% Initiate resulting image
% J = zeros(size(image_size));
end