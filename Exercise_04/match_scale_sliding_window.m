% match_scale_sliding_window - returns the box coordinates for matched object HOG in test HOG
% The method used for matching - sliding window with scaling object HOG
%
% Parameters:
% test_hog - test HOG which will be searched in for matches
% object_hog - object HOG which will be the match searched in test HOG
% scales - an array of scalings for object HOG for searching
%
% Returns: a box with its top left and bottom right coordinates respective to test_hog
% x_tl, y_tl - x and y coordinates for top left of the box
% x_br, y_br - x and y coordinates for bottom left of the box
function x = match_scale_sliding_window(test_hog, object_image, scales)
    scales_number = size(scales, 2);
    test_size = size(test_hog);
    max_scale = [0, 0, 0, 0, 0];
    for i = 1: scales_number
        object_hog = vl_hog(single(imresize(object_image, scales(i))), 8, 'verbose');
        tmp = match_sliding_window(test_hog, object_hog);
        if (tmp(1) > max_scale(1))
            max_scale = tmp;
    end
    x = max_scale
end