% Adds padding to a matrix I
% returning a padded matrix J
% border can be treated: "mirror" or "multiply"
function J = addpadding(I, size_kernel, border)
    % Add pads to existing image for filter usage
    image_size = size(I);
    % Expanding by even number (evenly on sides)
    pad = floor(size_kernel / 2);
    % Strictly defining that convolution is executed on 2 dimension layer
    image_size = image_size(1:2);
    % Adding respectively to vector
    padded_image = zeros(image_size + pad * 2);
    % Copy image, with appropriate padding
    padded_image(1 + pad(1): end - pad(1), 1 + pad(2): end - pad(2)) = I;
    % Handle border problem
    if strcmp(border, 'mirror') == 1
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
    elseif strcmp(border, 'multiply') == 1
        % The general approach is to take whole line and multiply by ones vector to get a matrix
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
    end %if none is chosen, simply leave as it is
padded_image = cast(padded_image, class(I));
J = padded_image;
end