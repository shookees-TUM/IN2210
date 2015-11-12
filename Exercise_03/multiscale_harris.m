function R = multiscale_harris(I, sigma_0, sigma_int, n, k, alpha, t)
J = I;
sizeJ = size(J);
% initialize output: R contains conrers of all scales
R = zeros(sizeJ(1), sizeJ(2), n);
% generate Harris response for all layers
for i = 1:n
    imsize = size(J);
    % initialize response matrix: +2 as "padding" for corner search
    % and +1 because of j = k+1 steps / layers
    R_n = zeros(imsize(1), imsize(2), k+2+1);
    for j = 2 : k+2
        sigma_0_temp = 2^((j-2)/k) * sigma_0;
        %sigma_0_temp = sigma_0 + sigma_0 * j / k; 
        % harrisR(I, sigma_dif, sigma_int, alpha, t)
        %sizeR_n = size(R_n);
        R_n(:,:,j+1) = harrisR(J, sigma_0_temp, sigma_int, alpha, t);
    end
    % corner search across scales
    for l = 2 : k
        R_3stack = R_n(:, :, l-1 : l+1);
        % find max index in vertical direction (stack direction)
        % image lies horizontally
        [M, N] = max(R_3stack, [], 3);
        sizeM = size(M);
        %sizeN = size(N);
        for layer = 1 : k
            for x = 1 : sizeM(1)
                for y = 1 : sizeM(2)
                    % is the maximal value in the middle layer of the stack
                    % and is the value larger than the threshold?
                    if N(x,y) == 2 && M(x,y) > t
                        % multiply coordinates of corner with 2^n and insert
                        % them into the overall corner picture
                        R(x*2^(i-1), y*2^(i-1), layer) = 255;
                    end
                end
            end
        end
    end
    % prepare for next cycle (n = n+1)
    sigma_0 = 2*sigma_0;
    J = imresize(J, 0.5);
end
%pause;
end