% Uses trained trees on an integral image to predict object centres
% Each tree most likely predicts a different centre
% trees - an array of tree data structure. See readTree.m for the data structure documntation
% img - integral image
function heatmap = predictionVotes(trees, img)
    % Get the votes for the object's centre coordinates
    img_size = size(img);
    heatmap = zeros(img_size(1:2)); % take only the 2 dimensions

    for i = 1: size(trees, 2)
        trees(i).prediction = predictionVote(trees(i), img);
        disp(sprintf('Predictions for tree %d - finished', i));
        for y = 1: img_size(1)
            for x = 1: img_size(2)
                prediction = trees(i).prediction(y, x);
                x_cord = round(x + prediction.x);
                y_cord = round(y + prediction.y);
                if (x_cord >= 1 && x_cord <= img_size(2) && y_cord >= 1 && y_cord <= img_size(1))
                    heatmap(y_cord, x_cord) = heatmap(y_cord, x_cord) + 1;
                end
            end
        end
    end
    % We have the heatmap
    max_heatmap_val = max(max(heatmap));
    % cut off, to reduce less accurate results
    cutoff = max_heatmap_val * 0.8; % Hand-picked constant
    for y = 1: img_size(1)
        for x = 1: img_size(2)
            if (heatmap(y, x) < cutoff)
                heatmap(y, x) = 0;
        end
    end
    % Scale it to grayscale max value (255)
    heatmap = heatmap / max_heatmap_val * 255;
end
