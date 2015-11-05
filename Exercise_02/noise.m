% Wrapper function for applying noises on an image
% I - 2 dimensional image array
% type - type of noise to apply
function J = noise(I, type, noise_scale)
    if strcmp(type, 'gaussian') == 1
        J = gaussianNoise(I, noise_scale);
    elseif strcmp(type, 'saltandpepper') == 1
        J = saltAndPepperNoise(I, noise_scale);
    end
end

% Creates Gaussian noise on image I
% I - 2 dimensional image array
function J = gaussianNoise(I, noise_scale)
    image_size = size(I);
    % Create layer of random values normally distributed
    noise = randn(image_size);
    % Scale by standard deviations of image and noise layer
    J = I + noise * noise_scale * std(I(:)) / std(noise(:));
end

% Creates Saltn and Pepper noise on image I
% I - 2 dimensional image array
function J = saltAndPepperNoise(I, noise_scale)
    image_size = size(I);
    % Create random permutation spots to be put on image
    noise = randperm(length(I(:)));
    J = I;
    % Pepper
    J(noise(1: end * noise_scale)) = 0;  
    % Salt
    J(noise(1: end * noise_scale / 2)) = 255;
end