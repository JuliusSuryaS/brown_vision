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


k = padarray(2,[1,1]);
im = ones(10,10);
im2 = zeros(10);
res1 = conv2(im,k);

im = padarray(im,[1 1]);
for i =  1 : 10
    for j = 1 : 10
        im2(i,j) = sum(sum(im(i:i+2,j:j+2).*k));
    end
end



%indexing for loop
m = size(image1,1);
n = size(image1,2);
imres = zeros(361,410);

% for i =  1:m-28+1
%     for j =  1 :n-28+1
%         imres(i+19,j+19) = sum(sum(red(i:i+28,j+28)));
%     end
% end


res = conv2(sigma, ones(10));
