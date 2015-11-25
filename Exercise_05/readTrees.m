% Reads text files into trees
% For full documentation refer to readTree.m function
% Returns an array of trees
function trees = readTreesFromFiles(filepaths)
    for i = 1: size(filepaths, 2)
        trees(i) = readTree(filepaths{i});
    end
end