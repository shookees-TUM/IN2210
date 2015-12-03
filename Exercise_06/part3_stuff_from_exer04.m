%%% Exercise 3 - Image Stitching
%
% read image of item to detect
I = imread('box.pgm');
% read image of scene containing item
S = imread('scene.pgm');
sizeI = size(I);
sizeS = size(S);
% vl_sift needs input to be greyscale
%I = single(rgb2gray(I));
%S = single(rgb2gray(S));
% compute the SIFT frames (keypoints) and descriptors of item I
[f_I,d_I] = vl_sift(I);
% matrix f has a column for each frame
% frame = [disk of center f(1:2), scale f(3) and orientation f(4)]
%
% compute the SIFT frames (keypoints) and descriptors of scene J
[f_S,d_S] = vl_sift(S);
% match descriptors of two images I (item) and J (scene)
threshold = 1.5; % default threshold is 1.5 (higher means more pruning)
[matches, scores] = vl_ubcmatch(d_I, d_S, threshold);
% For each descriptor in d_I, vl_ubcmatch finds the closest descriptor
% in d_S (as measured by the L2 norm of the difference between them).
% The index of the original match and the closest descriptor is stored
% in each column of matches and the distance between the pair is stored
% in scores.
% draw lines between matching features (matches)
size_matches = size(matches);
nr_of_matches = size_matches(2)
% K = I + J
K = zeros(sizeMAX(1), sizeI(2)+sizeS(2));
sizeK = size(K);
K(1:sizeI(1),1:sizeI(2)) = I;
K(1:sizeS(1), sizeI(2)+1:sizeI(2)+sizeS(2)) = S;
imagesc(K);
hold on
for i = 1 : nr_of_matches
    % extract coordinates of frame / feature
    % item feature coordinates (start of the line to plot)
    % f = f(x-coordinate, y-coordinate, scale, orientation)
    l_start = f_I(1:2, matches(1,i));
    % scene feature coordinates (end of the line to plot)
    l_end = f_S(1:2, matches(2,i));
    l_end(1) = l_end(1) + sizeI(2);
    plot([l_start(1),l_end(1)],[l_start(2),l_end(2)],'Color','r','LineWidth',1)
end
hold off
% remove outliers (function is part of Computer Vision)
matchesI = transpose( f_I(1:2, matches(1,:)));
matchesS = transpose( f_S(1:2, matches(2,:)));
% [tform,inlierpoints1,inlierpoints2] =
% estimateGeometricTransform(matchedPoints1,matchedPoints2,transformType)
% transformType defines the min nr. of matched pairs of points:
% 'similarity' = 2; 'affine' = 3; 'projective' = 4
[tform, inlierI, inlierS] = estimateGeometricTransform(matchesI, matchesS, 'similarity');
%inlierpoints_in_I = inlierI
%inlierpoints_in_S = inlierS
size_inlier = size(inlierI);
nr_of_inliers = size_inlier(1)
pause;
imagesc(K);
hold on
for j = 1 : nr_of_inliers
    % extract coordinates of frame / feature
    % item feature coordinates (start of the line to plot)
    % f = f(x-coordinate, y-coordinate, scale, orientation)
    l_start = inlierI(j,:);
    % scene feature coordinates (end of the line to plot)
    l_end = inlierS(j,:);
    l_end(1) = l_end(1) + sizeI(2);
    % plot([startX,endX],[startY,endY],'Color','r','LineWidth',1)
    plot([l_start(1),l_end(1)],[l_start(2),l_end(2)],'Color','r','LineWidth',1)
end
% draw box around detected object (item I) in scene (J)
maxSx = sizeI(2) + max(inlierS(:,1));
maxSy = max(inlierS(:,2));
minSx = sizeI(2) + min(inlierS(:,1));
minSy = min(inlierS(:,2));
% plot([startX,endX],[startY,endY],'Color','r','LineWidth',1)
% top line
plot([minSx,minSx],[minSy,maxSy],'Color','w','LineWidth',1)
% bottom line
plot([maxSx,maxSx],[minSy,maxSy],'Color','w','LineWidth',1)
% left line
plot([minSx,maxSx],[minSy,minSy],'Color','w','LineWidth',1)
% right line
plot([minSx,maxSx],[maxSy,maxSy],'Color','w','LineWidth',1)
hold off