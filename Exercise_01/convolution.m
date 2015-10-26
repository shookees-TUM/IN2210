% Convolutes a matrix I with a convolution mask H
% returning a matrix J
% border can be treated: "mirror" or "multiply"
function J = convolution(H, I, border)
    % Add pads to existing image for filter usage
    image_size = size(I);
    % Expanding by even number (evenly on sides)
    pad = floor(size(H,1) / 2);
    % image_size(3) if existant should stay untouched
    image_size(1) = image_size(1) + pad * 2;
    image_size(2) = image_size(2) + pad * 2;
    padded_image = zeros(image_size(1,2));
    % Copy image, leaving the padded sides zeros
    padded_image(1 + pad: end - pad, 1 + pad: end - pad) = I;
    grid on;
    image(padded_image);
    % pause;
    % handle border problem
    if border == 'mirror'
         %mirror left side
         disp('mirror');
     elseif border == 'multiply'
         disp('multiply');
     end %if none is chosen, simply leave as it is
    % Initiate resulting image, leaving pads (comfy for indexing)
    J = zeros(size(image_size));
    for i = 1 + pad: image_size(1) - pad
        for j = 1 + pad: image_size(2) - pad
            % Assign result the elementwise multiplication's sum
            applied_mask = H.*padded_image(i - pad: i + pad, j - pad: j + pad);
            % sum adds up columns, : makes it sum to 
            J(i, j) = sum(applied_mask(:));
        end
    end
    % Remove padding
    J = J(pad: end - pad, pad: end - pad);
end