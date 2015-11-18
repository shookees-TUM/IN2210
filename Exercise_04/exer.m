% Exercise 1
%
% read images [item (image I) need to be found in image J]
%I = imread('pot.jpg');
I = imread('shell.jpg');
%J = imread('test_pot1.jpg');
%J = imread('test_pot2.jpg');
J = imread('test_shell1.jpg');
%J = imread('test_shell2.jpg');
%
% vl_sift needs input to be greyscale
sizeI = size(I);
I = single(rgb2gray(I));
sizeJ = size(J);
J = single(rgb2gray(J));
% compute the SIFT frames (keypoints) and descriptors of item I
[f_I,d_I] = vl_sift(I);
% matrix f has a column for each frame
% frame = [disk of center f(1:2), scale f(3) and orientation f(4)]
% visualize a random selection of 50 features
perm = randperm(size(f_I,2));
sel = perm(1:50);
h_I_1 = vl_plotframe(f_I(:,sel));
h_I_2 = vl_plotframe(f_I(:,sel));
set(h_I_1,'color','r','linewidth',3);
set(h_I_2,'color','y','linewidth',2);
close all;
% overlay the descriptors d 
h3 = vl_plotsiftdescriptor(d_I(:,sel),f_I(:,sel));
set(h3,'color','g');
pause;
%
% compute the SIFT frames (keypoints) and descriptors of scene J
[f_J,d_J] = vl_sift(J);
% visualize a random selection of 50 features
perm = randperm(size(f_J,2));
sel = perm(1:50);
h_J_1 = vl_plotframe(f_J(:,sel));
h_J_2 = vl_plotframe(f_J(:,sel));
set(h_J_1,'color','r','linewidth',3);
set(h_J_2,'color','y','linewidth',2);
close all;
% overlay the descriptors d 
h3 = vl_plotsiftdescriptor(d_J(:,sel),f_J(:,sel));
set(h3,'color','g');
pause;
% match descriptors of two images I (item) and J (scene)
[matches, scores] = vl_ubcmatch(d_I, d_J);
% For each descriptor in d_I, vl_ubcmatch finds the closest descriptor
% in d_J (as measured by the L2 norm of the difference between them).
% The index of the original match and the closest descriptor is stored
% in each column of matches and the distance between the pair is stored
% in scores.
%
figure('Name', 'Exercise 1: SIFT');
colormap(gray(256)); 
% Original image item
subplot(1, 2, 1);
image(I);
title('Item to be found');
daspect([1 1 1]);
% Original image scene
subplot(1, 2, 2);
image(J);
title('Scene with item');
daspect([1 1 1]);
%

%pause;