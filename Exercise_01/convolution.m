% Convolutes a matrix I with a convolution mask H
% returning a matrix J
% border can be treated: "mirror" or "multiply"
function J = convolution(H, I, border)
    % Add pads to existing image for filter usage
    image_size = size(I);
    % Expanding by even number (evenly on sides)
    pad = floor(size(H) / 2)
    % Strictly defining that convolution is executed on 2 dimension layer
    image_size = image_size(1:2);
    % Adding respectively to vector
    image_size = image_size + pad * 2
    padded_image = zeros(image_size);
    % Copy image, with appropriate padding
    padded_image(1 + pad(1): end - pad(1), 1 + pad(2): end - pad(2)) = I;
    % Handle border problem
    if border == 'mirror'
         disp('mirror');
     elseif border == 'multiply'
         disp('multiply');
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
    J = J(pad(1): end - pad(1), pad(2): end - pad(2));
end