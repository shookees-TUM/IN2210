% Convolutes an image layer by layer
% Expected that the image has 3 dimensions: X, Y and color
function J = convoluteImage(H, I, border)
    image_size = size(I);
    %if it has 3 dimensions, give color
    if size(image_size, 2) == 3
        J = I;
        for i = 1: size(I, 3)
            J(:, :, i) = convolution(H, I(:, :, i), border);
        end
    else
        %grayscale have 2 dimensions
        J = convolution(H, I, border);
    end
end