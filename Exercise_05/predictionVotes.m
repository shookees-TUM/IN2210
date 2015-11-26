% Uses trained trees on an integral image to predict object centres
% Each tree most likely predicts a different centre
% trees - an array of tree data structure. See readTree.m for the data structure documntation
% img - integral image
function heatmap = predictionVotes(trees, img)
    % Get the votes for the object's centre coordinates
    img_size = size(img);
    heatmap = zeros(img_size(1), img_size(2)); % take only the 2 dimensions
    heatmap_size = size(heatmap);
    for i = 1: size(trees, 2)
        trees(i).prediction = predictionVote(trees(i), img);
        for j = 1: size(img, 1)
            for k = 1: size(img ,2)
                prediction = trees(i).prediction(k, j);
                xi = round(k + prediction.x);
                yi = round(j + prediction.y);
                if xi<=0 || xi>img_size(2) || yi<=0 || yi >img_size(1)
                else
                    heatmap(yi, xi) = heatmap(yi, xi) + 1;
                end
            end
        end
    end
end