im = imread('proj1/data/fish.bmp');

imhsv = rgb2hsv(im);
imhsv(:,:,2) = imhsv(:,:,2) * 2;

imhsv = hsv2rgb(imhsv);
im2 = imhsv;
figure,imshow(im), title('RGB');
figure,imshow(im2), title('SATURATED RGB');


filt = fspecial('motion',20,5);

m = size(im,1); n= size(im,2);
imhsv(1:m/4,:,:) = imfilter(imhsv(1:m/4,:,:),filt,'replicate');
imhsv(m/2+m/4:m,:,:) = imfilter(imhsv(m/2+m/4:m,:,:),filt,'replicate');
figure,imshow(imhsv);

filt2 = fspecial('gaussian', 10,5);
im3 = imfilter(im2, filt2, 'replicate');
im4 =2*im2 - im3;
%==== trying to get real value back from low freq image=======
for i = 1 : m
    for j = 1 : n
        im3(i,j) =  im4(i,j);
    end
end
% ========== but didnt work ==========================

imshow([im4 imfilter(im4, filt2,'replicate')]);




