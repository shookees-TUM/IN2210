tic;
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

%%% Exercise 3 - Testing
% Should it get the prediction where the center of the image is?
img.heatmap = predictionVotes(trees, img.integral);
img.heatmapcombo = img.original;
% apply heatmap for every color channel
img.heatmapcombo(:, :, 1) = double(img.heatmapcombo(:, :, 1)) + img.heatmap;
img.heatmapcombo(:, :, 2) = double(img.heatmapcombo(:, :, 2)) + img.heatmap;
img.heatmapcombo(:, :, 3) = double(img.heatmapcombo(:, :, 3)) + img.heatmap;

% Plotting Data
figure('Name', 'Exercise 5');
colormap(gray(256)); 
% Original image
subplot(2, 2, 1);
image(img.original);
title('Original Image');
daspect([1 1 1]);
% Heatmap
subplot(2, 2, 2);
image(img.heatmap);
title('Heatmap');
daspect([1 1 1]);
% Integral Image
subplot(2, 2, 3);
image(img.integral);
title('Integral Image');
daspect([1 1 1]);
% Heatmap plus Image
colormap default
subplot(2, 2, 4);
imagesc(img.heatmapcombo);
title('Image plus Heatmap');
daspect([1 1 1]);
hold off
toc