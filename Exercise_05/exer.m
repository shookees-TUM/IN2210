%%% Exercise 1 - loading the forest
data_folder = 'data/';
data_file_template = 'Tree{0}.txt';
data_file_numbers = linspace(0, 9, 10);
data_files = getDataFiles(data_folder, data_file_template, data_file_numbers)