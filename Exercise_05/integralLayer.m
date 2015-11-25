% Calculates the integral image for a specific layer
% layer - a 2 dimensional array, specifically one color channel for an image.
function int_layer = integrealLayer(layer)
    % Cumulative sum in X direction
    int_layer = cumsum(double(layer), 1);
    % Cumulative sum in Y direction
    int_layer = cumsum(int_layer, 2);
end