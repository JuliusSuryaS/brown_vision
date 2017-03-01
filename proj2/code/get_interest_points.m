% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of interest points for the input image

% 'image' can be grayscale or color, your choice.
% 'feature_width', in pixels, is the local feature width. It might be
%   useful in this function in order to (a) suppress boundary interest
%   points (where a feature wouldn't fit entirely in the image, anyway)
%   or (b) scale the image filters being used. Or you can ignore it.

% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
% 'confidence' is an nx1 vector indicating the strength of the interest
%   point. You might use this later or not.
% 'scale' and 'orientation' are nx1 vectors indicating the scale and
%   orientation of each interest point. These are OPTIONAL. By default you
%   do not need to make scale and orientation invariant local features.
function [x, y, confidence, scale, orientation] = get_interest_points(image, feature_width)

% Implement the Harris corner detector (See Szeliski 4.1.1) to start with.
% You can create additional interest point detector functions (e.g. MSER)
% for extra credit.

% If you're finding spurious interest point detections near the boundaries,
% it is safe to simply suppress the gradients / corners near the edges of
% the image.

% The lecture slides and textbook are a bit vague on how to do the
% non-maximum suppression once you've thresholded the cornerness score.
% You are free to experiment. Here are some helpful functions:
%  BWLABEL and the newer BWCONNCOMP will find connected components in 
% thresholded binary image. You could, for instance, take the maximum value
% within each component.
%  COLFILT can be used to run a max() operator on each sliding window. You
% could use this to ensure that every interest point is at a local maximum
% of cornerness.

% Take gradient as derivatives
[gx gy] = imgradientxy(image,'prewitt');

% filter for gaussian
sigma = 2 
h = fspecial('gaussian',max(1,fix(6*sigma)), sigma);

% Square of derivatives
gx2 = gx.*gx;
gy2 = gy.*gy;

% Gaussian filter 
gradx = imfilter(gx2, h, 'same');
grady = imfilter(gy2, h, 'same');

% Find corner
alpha = 0.04; % as suggested
R = (gradx.*grady) - alpha*((gradx+grady).^2);


% Treshold and Non-maxima supression
Rmx = colfilt(R, [ feature_width feature_width ], 'sliding', @max);
Rnew = (R==Rmx) & (R>0.05); % surpression and treshold >0.05
[y x] = find(Rnew); % find row and col



% still got no idea about the tresholding value .. R > 0 didn't work
% 0.05 seems to work

end

