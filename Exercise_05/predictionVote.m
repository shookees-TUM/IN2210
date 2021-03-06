% Uses a trained tree to predict the center of recognized object in an integral image
% trees - an array of tree data structure. See readTree.m for the data structure documntation
% img - integral image
% returns - a vote, which is x and y coordinate
function predictions = predictionVote(tree, img)
    img_size = size(img);
    for y = 1: img_size(1)
        for x = 1: img_size(2)
            predictions(y, x) = treePrediction(x, y, tree, img);
        end
    end
end