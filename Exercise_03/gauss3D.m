% Creates a 3 dimensional Gaussian filter
% H is the size of the filter
function J = gauss3uniD(sigma)
    % Divide mask size by 2, so that 0 is the center
    s = floor(3*sigma /2);
    for u = -s: s
        for v = -s: s
            for j = -s: s
                J(u + s + 1, v + s +1, j + s + 1) = exp(-1 / 2 * (u^2 + v^2 + j^2) / (sigma^2));
            end
        end
    end
end