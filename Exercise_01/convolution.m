% Convolutes a matrix I with a convolution mask H
% returning a matrix J
% border can be treated: "mirror" or "multiply"
function J = convolution(H, I, border)
    % Add pads to existing image for filter usage
    image_size = size(I);
    % Expanding by even number (evenly on sides)
    pad = floor(size(H) / 2);
    % Strictly defining that convolution is executed on 2 dimension layer
    image_size = image_size(1:2);
    % Adding respectively to vector
    image_size = image_size + pad * 2;
    padded_image = zeros(image_size);
    % Copy image, with appropriate padding
    padded_image(1 + pad(1): end - pad(1), 1 + pad(2): end - pad(2)) = I;
    % Handle border problem
    if border == 'mirror'
        %left border
        padded_image(1 + pad(1): end - pad(1), 1 : pad(2)) = fliplr(padded_image(1 + pad(1): end - pad(1), 1 + pad(2): 2 * pad(2)));
        %top left diagonal space
        padded_image(1: pad(1), 1: pad(2)) = fliplr(flipud(padded_image(1 + pad(1): 2 * pad(1), 1 + pad(2): 2 * pad(2))));
        %top border
        padded_image(1: pad(1), 1 + pad(2): end - pad(2)) = flipud(padded_image(1 + pad(1): 2 * pad(1), 1 + pad(2): end - pad(2)));
        %top right diagonal space
        padded_image(1: pad(1), end - pad(2) + 1: end) = fliplr(flipud(padded_image(1 + pad(1): 2 * pad(1), end - 2 * pad(2) + 1: end - pad(2))));
        %right border
        padded_image(1 + pad(1): end - pad(1), end - pad(2) + 1: end) = fliplr(padded_image(1 + pad(1): end - pad(1), end - 2 * pad(2) + 1: end - pad(2)));
        %bottom right diagonal space
        padded_image(end - pad(1) + 1: end , end - pad(2) + 1: end) = fliplr(flipud(padded_image(end - 2 * pad(1) + 1: end - pad(1), end - 2 * pad(2) + 1: end - pad(2))));
        %bottom border
        padded_image(end - pad(1) + 1: end, 1 + pad(2): end - pad(2)) = flipud(padded_image(end - 2 * pad(1) + 1: end - pad(1), 1 + pad(2): end - pad(2)));
        %bottom left diagonal space
        padded_image(end - pad(1) + 1: end, 1: pad(2)) = fliplr(flipud(padded_image(end - 2 * pad(1) + 1: end - pad(1), pad(2) + 1: 2 * pad(2))));
    elseif border == 'multiply'
        %left border
        %top left diagonal space
        %top border
        %top right diagonal space
        %right border
        %bottom right diagonal space
        %bottom border
        %bottom left diagonal space
    end %if none is chosen, simply leave as it is
    % Initiate resulting image, leaving pads (comfy for indexing)
    J = zeros(size(image_size));
    for i = 1 + pad(1): image_size(1) - pad(1)
        for j = 1 + pad(2): image_size(2) - pad(2)
            % Assign result the elementwise multiplication's sum
            applied_mask = H.*padded_image(i - pad(1): i + pad(1), j - pad(2): j + pad(2));
            % sum adds up columns, : makes it sum to 
            J(i, j) = sum(applied_mask(:));
        end
    end
    % Remove padding
    J = J(1 + pad(1): end - pad(1), 1 + pad(2): end - pad(2));
end