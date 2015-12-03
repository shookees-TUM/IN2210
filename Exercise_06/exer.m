%%% Exercise 1 - Normalized Direct Linear Transformation (DLT)
% number of points in each image
nop = 4; % max value of i
% points in image x_i = (x_i, y_i, w_i) x and y are coordinates,
% w is the scale (homogeneous coordinates)
x = zeros(3, nop);
% points in wrapped image x_i prime
xp = zeros(3, nop);
% Normalize the points of the (wrapped/) image with the
% transformation (T/) U such that their centroid is at the
% origin and that the average distance from the origin is sqrt(2)
% [the normalized points have a tilde, add t to name]
xt = x; % define transformation
xpt = xp;
% For each normalized point correspondence xipt <-> xit compute
% the matrix Ai given by the homography equation xipt propto H*xit.
At = zeros(2 * nop, 9);
for i = 1 : nop
    xi = x(:,i); % this is the whole image point i
    xipt = xpt(1,i); % x coordinate of wrapped image point i
    yipt = xpt(2,i); % y -"-
    wipt = xpt(3,i); % scale -"-
    % The matrix Ait is part of At and has the explicit form:
    At(2*i-1:2*i, :) = [zeros(1,3), -wipt*xit.', yipt*xit.'; ...
        wipt*xt.', zeros(1,3), -xipt*xit.'];
end
% A solution At*ht = 0 is found via SVD
%
% Reshaping ht yields Ht
%
% Denormalization of Ht leads to H
%



%%% Exercise 2 - RANSAC
%
