% Calculates the integral image for a specific layer
% layer - a 2 dimensional array, specifically one color channel for an image.
function int_layer = integrealLayer(layer)
    % Cumulative sum in X direction
    %int_layer = cumsum(double(layer), 1);
    % Cumulative sum in Y direction
    %int_layer = cumsum(int_layer, 2);
    %
    % using matlab function
    int_layer_temp = integralImage(layer);
    % matlab adds a line and a column of zeros
    int_layer = int_layer_temp(2:end,2:end);
end