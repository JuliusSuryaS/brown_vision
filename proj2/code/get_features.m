% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of feature descriptors for a given set of interest points. 

% 'image' can be grayscale or color, your choice.
% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
%   The local features should be centered at x and y.
% 'feature_width', in pixels, is the local feature width. You can assume
%   that feature_width will be a multiple of 4 (i.e. every cell of your
%   local SIFT-like feature will have an integer width and height).
% If you want to detect and describe features at multiple scales or
% particular orientations you can add input arguments.

% 'features' is the array of computed features. It should have the
%   following size: [length(x) x feature dimensionality] (e.g. 128 for
%   standard SIFT)

function [features] = get_features(image, x, y, feature_width)

% To start with, you might want to simply use normalized patches as your
% local feature. This is very simple to code and works OK. However, to get
% full credit you will need to implement the more effective SIFT descriptor
% (See Szeliski 4.1.2 or the original publications at
% http://www.cs.ubc.ca/~lowe/keypoints/)

% Your implementation does not need to exactly match the SIFT reference.
% Here are the key properties your (baseline) descriptor should have:
%  (1) a 4x4 grid of cells, each feature_width/4. 'cell' in this context
%    nothing to do with the Matlab data structue of cell(). It is simply
%    the terminology used in the feature literature to describe the spatial
%    bins where gradient distributions will be described.
%  (2) each cell should have a histogram of the local distribution of
%    gradients in 8 orientations. Appending these histograms together will
%    give you 4x4 x 8 = 128 dimensions.
%  (3) Each feature should be normalized to unit length
%
% You do not need to perform the interpolation in which each gradient
% measurement contributes to multiple orientation bins in multiple cells
% As described in Szeliski, a single gradient measurement creates a
% weighted contribution to the 4 nearest cells and the 2 nearest
% orientation bins within each cell, for 8 total contributions. This type
% of interpolation probably will help, though.

% You do not have to explicitly compute the gradient orientation at each
% pixel (although you are free to do so). You can instead filter with
% oriented filters (e.g. a filter that responds to edges with a specific
% orientation). All of your SIFT-like feature can be constructed entirely
% from filtering fairly quickly in this way.

% You do not need to do the normalize -> threshold -> normalize again
% operation as detailed in Szeliski and the SIFT paper. It can help, though.

% Another simple trick which can help is to raise each element of the final
% feature vector to some power that is less than one.

%Placeholder that you can delete. Empty features.
% features = zeros(size(x,1), 128);

vtempx = zeros(1,8);
vtemp = zeros(4,32);
v = zeros(1,128);

% Take image value of features add 16x16 size
% get the gradient direction
for i = 1 : size(x,1)
    
    % get the gradient first in 16 x 16 window
    imhold = image1(x(i):x(i)+15,y(i):y(i)+15); % for image holder
    [gx gy] = imgradientxy(imhold,'prewitt'); % find its gradient
    [gmag gdir] = imgradient(gx,gy);    % find the gradient direction
    
    % gdir is 16 x 16 -> but we need to groups into 4 x 4 consists of 8
    % direction so 4 x (4 x 32) = 128 dim
    
    % 16 x 16 so 4 loop m,n
    for m =  1 : 4 % 4 times loop starting point 1 5 9 13
        count1 = (m-1) * 4 + 1; % starting point m 1, 5, 9, 13
        for n = 1: 4
            count2 = (n-1) * 4 + 1; % starting point n 1, 5, 9, 13
            gnew = gdir(count1:count1+3,count2:count2+3); % 1-4, 5-8, 9-12, 13-16 
            gnew = gnew(:);
            gnew = gnew';
            vtempx = hist(gnew,[-180,-135,-90,-45,45,90,135,180]);
            
            % v gradient direction in histogram 4 x 4
            % 4 x (4x8) => histogram consists of 8 direction [-180 :45: 180]
            count3 = (n-1) * 8 + 1; % starting point 1, 9, 17, 25
            vtemp(m,count3:count3+7) = vtempx; % eq v(1,1:8), v(1,9:16) .. etc
            
            % v size = 4 x 32 for every interest point
            % note there are 128 interest point 
            
        end % n loop
        % resize vtemp into 128 vector array
        varr = (vtemp(:))';
        
    end % m loop
    
    % concate v  for every 128 interest point
    % later remove 1st matrix of v, for concation purpose
    v = [v; varr];
    
end % i loop

% remove first 1 x 128 matrix element of v(1,1:128) -> zeros matrix ( for
% concate) so
features = v(2:size(v,1),:); 


end % end function








