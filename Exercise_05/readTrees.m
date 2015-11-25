%
%
%
function trees = readTreesFromFiles(filepaths)
    for i = 1: size(filepaths, 2)
        trees{i} = readTree(filepaths{i});
    end
end