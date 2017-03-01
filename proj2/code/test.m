
%% 1) Load stuff
% There are numerous other image sets in the supplementary data on the
% project web page. You can simply download images off the Internet, as
% well. However, the evaluation function at the bottom of this script will
% only work for three particular image pairs (unless you add ground truth
% annotations for other image pairs). It is suggested that you only work
% with the two Notre Dame images until you are satisfied with your
% implementation and ready to test on additional images. A single scale
% pipeline works fine for these two images (and will give you full credit
% for this project), but you will need local features at multiple scales to
% handle harder cases.
image1 = imread('../data/Notre Dame/921919841_a30df938f2_o.jpg');
image2 = imread('../data/Notre Dame/4191453057_c86028ce1f_o.jpg');
eval_file = '../data/Notre Dame/921919841_a30df938f2_o_to_4191453057_c86028ce1f_o.mat';

% %This pair is relatively easy (still harder than Notre Dame, though)
% image1 = imread('../data/Mount Rushmore/9021235130_7c2acd9554_o.jpg');
% image2 = imread('../data/Mount Rushmore/9318872612_a255c874fb_o.jpg');
% eval_file = '../data/Mount Rushmore/9021235130_7c2acd9554_o_to_9318872612_a255c874fb_o.mat';

% %This pair is relatively difficult
% image1 = imread('../data/Episcopal Gaudi/4386465943_8cf9776378_o.jpg');
% image2 = imread('../data/Episcopal Gaudi/3743214471_1b5bbfda98_o.jpg');
% eval_file = '../data/Episcopal Gaudi/4386465943_8cf9776378_o_to_3743214471_1b5bbfda98_o.mat';

image1 = single(image1)/255;
image2 = single(image2)/255;

%make images smaller to speed up the algorithm. This parameter gets passed
%into the evaluation code so don't resize the images except by changing
%this parameter.
scale_factor = 0.5; 
image1 = imresize(image1, scale_factor, 'bilinear');
image2 = imresize(image2, scale_factor, 'bilinear');

% You don't have to work with grayscale images. Matching with color
% information might be helpful.
image1_bw = rgb2gray(image1);
image2_bw = rgb2gray(image2);

feature_width = 16; %width and height of each local feature, in pixels. 

%% 2) Find distinctive points in each image. Szeliski 4.1.1
% !!! You will need to implement get_interest_points. !!!
[x1, y1] = get_interest_points(image1_bw, feature_width);

% figure, imshow(image1), axis image, hold on, plot(x1,y1,'r*')

% hold on
% plot(xpeak,ypeak,'rx','markersize',20)
% hold on
% plot(xoffset,yoffset,'bx','markersize',20)

% imtest = image1(x1(34):x1(34)+15,y1(34):y1(34)+15);
% imshow(imtest);
% imhist(imtest);
