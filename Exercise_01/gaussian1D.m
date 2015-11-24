% Creates a 1 dimensional Gaussian filter
% H is the size of the filter
function J = gaussian1D(mask_size, sigma)
    % Divide mask size by 2, so that 0 is the center
    s = floor(mask_size / 2);
    for u = -s: s
        J(u + s + 1) = exp(-1 / 2 * (u^2) / (sigma^2));
        % prefactor 1 / sqrt(2 * pi * sigma^2) *
        % not necessary because of normalization
    end
    J = 1 / sum(J) * J;
end