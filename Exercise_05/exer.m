%%% Exercise 1 - loading the forest
data_folder = 'data/';
data_file_template = 'Tree{0}.txt';
data_file_numbers = linspace(0, 9, 10);
data_files = getDataFiles(data_folder, data_file_template, data_file_numbers);

trees = readTrees(data_files);

%%% Exercise 2 - integral images
img.filename = '2007_000032.jpg';
img.filepath = fullfile(data_folder, img.filename);
img.original = imread(img.filepath);

% Function name due to resemblance to matlab's inbuilt one. Also, the output differs by 0s top and left margin
img.integral = integralImage2(img.original);
