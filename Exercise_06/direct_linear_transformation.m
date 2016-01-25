function h = direct_linear_transformation(p)
%%%
% p - M times 2xN (or 3xN in homogeneous) corresponding corners
% 	M should be >= 4
% h - projective transformation estimation
%	h * x_i = x'_i
%	x_i - reference image point
%	x'_i - warped image corresponding point
%%%
	% Check for homogeneouty
	if (size(p, 2) ~= 3)
		p(:, 3, :) = 1; % Add 3rd item for 2nd dimension of 1s
	end
	% Normalize by transforming:
	% x^_i = T x_i; x'^_i = T' x'_i
	% T and T' - normalizing transformation by translation and scaling
	t = normalise_2D_homogeneous_points(p)