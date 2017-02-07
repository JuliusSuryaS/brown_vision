image1 = im2single(imread('../data/dog.bmp'));
%% Filtering and Hybrid Image construction
cutoff_frequency = 7; %This is the standard deviation, in pixels, of the 
% Gaussian blur that will remove the high frequencies from one image and 
% remove the low frequencies from another image (by subtracting a blurred
% version from the original version). You will want to tune this for every
% image pair to get the best results.
filter = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);

% img = imfilter(image1, filter);
% imshow(img)

%split color to R-G-B
red = image1(:,:,1);
green = image1(:,:,2);
blue = image1(:,:,3);
% imshow([red green blue]);






%indexing for loop
m = size(image1,1);
n = size(image1,2);
impad = padarray(image1,[14 14]);

for c = 1 : 3 %RGB COLOR 3 LAYER 
    for i = 1 : m
        for j =  1 : n
            image1(i,j,c) = sum(sum(impad(i:i+28,j:j+28).*filter));
        end
    end
end

imshow(image1);



% =========================alogrithm========================
% 1. set 1 padded image from real image (padarray) "img_pad"
% 2. real image "img"
% 3. make padded image where img_pad(i,j) is equal the center img(i,j)
% 4. img_pad(1,1) is equal the center of img(1,1), based on kernel size
% 5. for 10x10 img with kernel size 3x3 then pad img with [1 1]
%    see example below.
% 6. loop from row and col, do the convolution
% 7. kernel .* size of kernel in image
%    impad(i:i+28,j:j+28).*filter) for filter with size 29x29
%    sum all of the value.
% =====================example============================
% real image img 10x10
%  1     1     1     1     1     1     1     1     1     1
%  1     1     1     1     1     1     1     1     1     1
%  1     1     1     1     1     1     1     1     1     1
%  1     1     1     1     1     1     1     1     1     1
%  1     1     1     1     1     1     1     1     1     1
%  1     1     1     1     1     1     1     1     1     1
%  1     1     1     1     1     1     1     1     1     1
%  1     1     1     1     1     1     1     1     1     1
%  1     1     1     1     1     1     1     1     1     1
%  1     1     1     1     1     1     1     1     1     1
%
% kernel/filter  f 3x3
% 0   0   0
% 0   2   0
% 0   0   0
%
% moving box filter should have the same size with filer 3x3
% padd the original image to match the size of kernel 
% 3x3 kernel = pad[1 1] -> add 1 pad to image
%
% padded image im_pad 12x12
%  0     0     0     0     0     0     0     0     0     0     0     0
%  0     1     1     1     1     1     1     1     1     1     1     0
%  0     1     1     1     1     1     1     1     1     1     1     0
%  0     1     1     1     1     1     1     1     1     1     1     0
%  0     1     1     1     1     1     1     1     1     1     1     0
%  0     1     1     1     1     1     1     1     1     1     1     0
%  0     1     1     1     1     1     1     1     1     1     1     0
%  0     1     1     1     1     1     1     1     1     1     1     0
%  0     1     1     1     1     1     1     1     1     1     1     0
%  0     1     1     1     1     1     1     1     1     1     1     0
%  0     1     1     1     1     1     1     1     1     1     1     0
%  0     0     0     0     0     0     0     0     0     0     0     0
%
% now if we run the loop
% loop from row(m) and col(n)
% img(1,1) is the center of moving box filter from im_pad(1,1)
% Moving box filter on im_pad during im_pad(1,1)
% |---|---|---|
% | 0 | 0 | 0 | 
% |---|---|---|
% | 0 | 1 | 1 | 
% |---|---|---|
% | 0 | 1 | 1 | 
% |---|---|---|
%
% conv with | 0  0  0 |
%           | 0  2  0 |
%           | 0  0  0 |
%
% we take the middle value 
% the value correspond to img(1,1) to the real image
%=======================================================
% try
% k = padarray(2,[1,1]);
% im = ones(10,10);
% im2 = zeros(10)
% res1 = conv2(im,k);
% 
% im = padarray(im,[1 1]);
% for i =  1 : 10
%     for j = 1 : 10
%         im2(i,j) = sum(sum(im(i:i+2,j:j+2).*k));
%     end
% end