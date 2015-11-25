% SIFT
% read images [item (image I) needs to be found in image J]
I = imread('shell.jpg');
J = imread('test_shell2.jpg');
% show descriptors found in I / J? 
show_descriptors = 1;
% number of shown descriptors is nr_f
nr_f = 100;
% show image with lines drawn between matches in I and J
% (before and after pruning)?
show_matches = 1;
%
sizeI = size(I);
sizeJ = size(J);
sizeMAX = max(sizeI, sizeJ);
%
% vl_sift needs input to be greyscale
I = single(rgb2gray(I));
J = single(rgb2gray(J));
% compute the SIFT frames (keypoints) and descriptors of item I
[f_I,d_I] = vl_sift(I);
% matrix f has a column for each frame
% frame = [disk of center f(1:2), scale f(3) and orientation f(4)]
%
% compute the SIFT frames (keypoints) and descriptors of scene J
[f_J,d_J] = vl_sift(J);
%
if show_descriptors == 1
    % visualize a random selection of 'nr_f' features (see line 8)
    % overlay with image I
    imagesc(I);
    perm = randperm(size(f_I,2));
    sel = perm(1 : nr_f);
    h_I_1 = vl_plotframe(f_I(:, sel));
    h_I_2 = vl_plotframe(f_I(:, sel));
    set(h_I_1,'color','r','linewidth',1);
    set(h_I_2,'color','y','linewidth',1);
    % overlay the descriptors d 
    h3 = vl_plotsiftdescriptor(d_I(:, sel),f_I(:, sel));
    set(h3,'color','g');
    pause;
    % visualize a random selection of nr_f features
    imagesc(J);
    perm = randperm(size(f_J,2));
    sel = perm(1 : nr_f);
    h_J_1 = vl_plotframe(f_J(:, sel));
    h_J_2 = vl_plotframe(f_J(:, sel));
    set(h_J_1,'color','r','linewidth',2);
    set(h_J_2,'color','y','linewidth',2);
    % overlay the descriptors d 
    h3 = vl_plotsiftdescriptor(d_J(:, sel),f_J(:, sel));
    set(h3,'color','g');
    pause;
elseif show_descriptors == 0
end
% match descriptors of two images I (item) and J (scene)
threshold = 1.5; % default threshold is 1.5 (higher means more pruning)
[matches, scores] = vl_ubcmatch(d_I, d_J, threshold);
% For each descriptor in d_I, vl_ubcmatch finds the closest descriptor
% in d_J (as measured by the L2 norm of the difference between them).
% The index of the original match and the closest descriptor is stored
% in each column of matches and the distance between the pair is stored
% in scores.
size_matches = size(matches);
nr_of_matches = size_matches(2)%;
% remove outliers (function is part of Computer Vision)
matchesI = transpose( f_I(1:2, matches(1,:)));
matchesJ = transpose( f_J(1:2, matches(2,:)));
% [tform,inlierpoints1,inlierpoints2] =
% estimateGeometricTransform(matchedPoints1,matchedPoints2,transformType)
% transformType defines the min nr. of matched pairs of points:
% 'similarity' = 2; 'affine' = 3; 'projective' = 4
[tform, inlierI, inlierJ] = estimateGeometricTransform(matchesI, matchesJ, 'similarity');
%inlierpoints_in_I = inlierI
%inlierpoints_in_J = inlierJ
size_inlier = size(inlierI);
nr_of_inliers = size_inlier(1)%;
% get min and max coordinates of detected features in I
maxIx = max(inlierI(:,1));
maxIy = max(inlierI(:,2));
minIx = min(inlierI(:,1));
minIy = min(inlierI(:,2));
% get min and max coordinates of detected features in J
maxJx = sizeI(2) + max(inlierJ(:,1));
maxJy = max(inlierJ(:,2));
minJx = sizeI(2) + min(inlierJ(:,1));
minJy = min(inlierJ(:,2));
% calculate scaling factor "scale"
scaleX = (maxJx - minJx) / (maxIx - minIx);
scaleY = (maxJy - minJy) / (maxIy - minIy);
scale = (scaleX + scaleY) /2 %;
if show_matches == 1
    % draw lines between matching features (matches)
    % Display I and J next to each other: K = I + J
    K = zeros(sizeMAX(1), sizeI(2)+sizeJ(2));
    sizeK = size(K);
    K(1:sizeI(1),1:sizeI(2)) = I;
    K(1:sizeJ(1), sizeI(2)+1:sizeI(2)+sizeJ(2)) = J;
    imagesc(K);
    hold on
    for i = 1 : nr_of_matches
        % extract coordinates of frame / feature
        % item feature coordinates (start of the line to plot)
        % f = f(x-coordinate, y-coordinate, scale, orientation)
        l_start = f_I(1:2, matches(1,i));
        % scene feature coordinates (end of the line to plot)
        l_end = f_J(1:2, matches(2,i));
        l_end(1) = l_end(1) + sizeI(2);
        plot([l_start(1),l_end(1)],[l_start(2),l_end(2)],'Color','r','LineWidth',1)
    end
    pause;
    hold off
    imagesc(K);
    hold on
    for j = 1 : nr_of_inliers
        % extract coordinates of frame / feature
        % item feature coordinates (start of the line to plot)
        % f = f(x-coordinate, y-coordinate, scale, orientation)
        l_start = inlierI(j,:);
        % scene feature coordinates (end of the line to plot)
        l_end = inlierJ(j,:);
        l_end(1) = l_end(1) + sizeI(2);
        % plot([startX,endX],[startY,endY],'Color','r','LineWidth',1)
        plot([l_start(1),l_end(1)],[l_start(2),l_end(2)],'Color','r','LineWidth',1)
    end
    % draw box around object in image I
    % plot([startX,endX],[startY,endY],'Color','r','LineWidth',1)
    % top line
    plot([minIx,minIx],[minIy,maxIy],'Color','w','LineWidth',1)
    % bottom line
    plot([maxIx,maxIx],[minIy,maxIy],'Color','w','LineWidth',1)
    % left line
    plot([minIx,maxIx],[minIy,minIy],'Color','w','LineWidth',1)
    % right line
    plot([minIx,maxIx],[maxIy,maxIy],'Color','w','LineWidth',1)
    % draw box around detected object (item I) in scene (J)
    % plot([startX,endX],[startY,endY],'Color','r','LineWidth',1)
    % top line
    plot([minJx,minJx],[minJy,maxJy],'Color','w','LineWidth',1)
    % bottom line
    plot([maxJx,maxJx],[minJy,maxJy],'Color','w','LineWidth',1)
    % left line
    plot([minJx,maxJx],[minJy,minJy],'Color','w','LineWidth',1)
    % right line
    plot([minJx,maxJx],[maxJy,maxJy],'Color','w','LineWidth',1)
    hold off
elseif show_matches == 0
end
