% Filters an image with a median filter
% I - 2 dimensional image array
% filter_size - size of the filter, i.e. (1, 3); (3, 3)
function J = medianFilter(I, filter_size, border)
    % Prepare padded image
    image_size = size(I);
    pad = floor(filter_size / 2);
    padded_image = addpadding(I, filter_size, border);
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