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
%imagesc(img.integral(:,:,1));
%pause;
%%% Exercise 3 - Testing
heatmap = predictionVotes(trees, img.integral);
% We have the heatmap
% cut off the lowest 90%
max_heatmap = max(max(heatmap));
heatmap = heatmap /max_heatmap *255;
cutoff = 255 * 0.0;
for i = 1: size(heatmap, 1)
    for j = 1: size(heatmap, 2)
        if (heatmap(i, j) < cutoff)
            heatmap(i, j) = 0;
        end
    end
end
% Display heat image in seperate figure?
disp_heatmap = 0;
if disp_heatmap == 1
    imagesc(heatmap);
elseif disp_heatmap == 0
    % don't display heatmap in seperate figure
end
%
% Plotting Data
%
figure('Name', 'Exercise 5');
colormap(gray(256)); 
% Original image
subplot(2, 2, 1);
image(img.original);
title('Original Image');
daspect([1 1 1]);
% Heatmap
subplot(2, 2, 2);
image(heatmap);
title('Heatmap');
daspect([1 1 1]);
% Integral Image
subplot(2, 2, 3);
max_int_img = max(max(img.integral));
int_img_layer = 1; %(Red = 1, Green = 2, Blue = 3)
norm_int_img = img.integral(:,:,int_img_layer) / max_int_img(1,1,int_img_layer) * 255;
image(norm_int_img);
title('Integral Image');
daspect([1 1 1]);
% Heatmap plus Image
colormap default
subplot(2, 2, 4);
original = img.original(:,:,1) + img.original(:,:,2) + img.original(:,:,3);
imagesc(double(original) + heatmap);
title('Image plus Heatmap');
daspect([1 1 1]);
hold off