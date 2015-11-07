% Creates a 2 dimensional Gaussian filter
% H is the size of the filter
function J = gaussian2D(sigma)
    % Divide mask size by 2, so that 0 is the center
    s = floor(3*sigma /2);
    for u = -s: s
        for v = -s: s
            %J(u + s + 1, v + s +1) = 1 / (2 * pi * sigma^2) * exp(-1 / 2 * (u^2 + v^2) / (sigma^2));
            % prefactor can be omitted because of normalization
            J(u + s + 1, v + s +1) = exp(-1 / 2 * (u^2 + v^2) / (sigma^2));
        end
    end
% normalization
J = J ./ sum(J(:));
end