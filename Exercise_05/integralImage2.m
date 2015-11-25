% Retrieves the integral image of a multi-layer image (color channels)
% img - image array (matrix, with z-axis for color channels)
function int_img = integralImage2(img)
    for i = 1: size(img, 3)
        int_img(:, :, i) = integralLayer(img(:, :, i));
    end
end