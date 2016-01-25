% match_sliding_window - returns the match score for matching object HOG and test HOG
% 
% Parameters:
% object_hog - object's histogram of gradients
% test_hog - test's histogram of gradients
%
% Returns:
% Best match score for specific object HOG.
% structure: [certainty, x_tl, y_tl, width, height]
function best_match = match_sliding_window(test_hog, object_hog)
    window_size = size(object_hog);
    test_size = size(test_hog) - window_size;
    best_match = [0, 0, 0, 0, 0]
    for i = 1: test_size(1)
        for j = 1: test_size(2)
            tmp = sum((object_hog - test_hog(i: window_size(1) + i - 1, j: window_size(2) + j -1, :)) == 0) / (window_size(1) * window_size(2))
            if (tmp > best_match(1))
                best_match = [tmp, i, j, window_size(1), window_size(2)]
            end
        end
    end
    best_match
    pause
end