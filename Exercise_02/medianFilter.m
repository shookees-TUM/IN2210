% Filters an image with a median filter
% I - 2 dimensional image array
% filter_size - size of the filter, i.e. (1, 3); (3, 3)
function J = medianFilter(I, filter_size, border)
    % Prepare padded image
    image_size = size(I);
    pad = floor(filter_size / 2);
    if strcmp(border, 'mirror') == 1
        padded_image = zeros(image_size * 3);
        % Vertical
        flipped_ud_image = flipud(I);
        padded_image(1: image_size, 1 + image_size: end - image_size) = flipped_ud_image;
        padded_image(end - image_size + 1: end, 1 + image_size: end - image_size) = flipped_ud_image;
        % Corner copies
        flipped_lr_ud_image = fliplr(flipped_ud_image);
        padded_image(1: image_size, 1: image_size) = flipped_lr_ud_image;
        padded_image(end - image_size + 1: end, 1: image_size) = flipped_lr_ud_image;
        padded_image(1: image_size, end - image_size + 1: end) = flipped_lr_ud_image;
        padded_image(end - image_size + 1: end, end - image_size + 1: end) = flipped_lr_ud_image;
        % Horizontal
        flipped_lr_image = fliplr(I);
        padded_image(1 + image_size: end - image_size, 1: image_size) = flipped_lr_image;
        padded_image(1 + image_size: end - image_size, end - image_size + 1: end) = flipped_lr_image;
        % Center
        padded_image(1 + image_size: end - image_size, 1 + image_size: end - image_size) = I;
        % Crop it to image with padding size
        padded_image = padded_image(1 + image_size - pad: end - image_size + pad, 1 + image_size - pad: end - image_size + pad);
    elseif strcmp(border, 'multiply') == 1
        padded_image = zeros(image_size + pad * 2);
        padded_image(1 + pad(1): end - pad(1), 1 + pad(2): end - pad(2)) = I;
        %left border
        padded_image(1 + pad(1): end - pad(1), 1 : pad(2)) = padded_image(1 + pad(1): end - pad(1), 1 + pad(2): 1 + pad(2)) * ones(1, pad(2));
        %top left diagonal space
        padded_image(1: pad(1), 1: pad(2)) = padded_image(1 + pad(1), 1 + pad(2)) * ones(pad);
        %top border
        padded_image(1: pad(1), 1 + pad(2): end - pad(2)) = ones(pad(1), 1) * padded_image(1 + pad(1): 1 + pad(1), 1 + pad(2): end - pad(2));
        %top right diagonal space
        padded_image(1: pad(1), end - pad(2) + 1: end) = padded_image(1 + pad(1), 1 + pad(2)) * ones(pad);
        %right border
        padded_image(1 + pad(1): end - pad(1), end - pad(2) + 1: end) = padded_image(1 + pad(1): end - pad(1), end - pad(2): end - pad(2)) * ones(1, pad(2));
        %bottom right diagonal space
        padded_image(end - pad(1) + 1: end , end - pad(2) + 1: end) = padded_image(end - pad(1), end - pad(2)) * ones(pad);
        %bottom border
        padded_image(end - pad(1) + 1: end, 1 + pad(2): end - pad(2)) = ones(pad(1), 1) * padded_image(end - pad(1): end - pad(1), 1 + pad(2): end - pad(2));
        %bottom left diagonal space
        padded_image(end - pad(1) + 1: end, 1: pad(2)) = padded_image(end - pad(1), 1 + pad(2)) * ones(pad);
    end
    J = zeros(size(image_size));
    for i = 1: image_size(1)
        for j = 1: image_size(2)
            kernel = padded_image(i: i + 2 * pad(1), j: j + 2 * pad(2));
            % Flatten kernel into 1xN array
            kernel = reshape(kernel, 1, []);
            % Alternatively we can sort it and take middle value
            J(i, j) = median(kernel);
        end
    end
end