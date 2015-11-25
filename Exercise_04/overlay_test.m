I = vl_impattern('roofs1');
%image(I);
% vl_sift needs input to be greyscale
sizeI = size(I);
I = single(rgb2gray(I));
% compute the SIFT frames (keypoints) and descriptors of item I
[f_I,d_I] = vl_sift(I);
% matrix f has a column for each frame
% frame = [disk of center f(1:2), scale f(3) and orientation f(4)]
% visualize a random selection of 50 features
perm = randperm(size(f_I,2));
sel = perm(1:50);
h1 = vl_plotframe(f_I(:,sel));
h2 = vl_plotframe(f_I(:,sel));
set(h1,'color','r','linewidth',3);
%pause;
set(h2,'color','y','linewidth',2);
%pause;
% overlay the descriptors d 
h3 = vl_plotsiftdescriptor(d_I(:,sel),f_I(:,sel));
set(h3,'color','g');
%pause;
%close all;
%
% overlayed Image J
plot (h3,I);
%
figure('Name', 'Exercise 1: SIFT Test');
%colormap(gray(256)); 
% Original image
subplot(1, 2, 1);
image(I);
title('Original Image');
daspect([1 1 1]);
% Original image overlayed with features
subplot(1, 2, 2);
image(J);
title('I overlayed with features');
daspect([1 1 1]);
%pause;