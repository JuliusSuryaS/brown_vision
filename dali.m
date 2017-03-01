im_normal = imread('proj1/data/dali.png');
im_gray = rgb2gray(im_normal);
temp = im_gray(200:700,200:500);
imshowpair(im_gray, temp,'montage');

figure;
c = normxcorr2(temp, im_gray);
surf(c);
[ypeak xpeak] = find(c==max(c(:)));

yval = ypeak - size(temp,1);
xval = xpeak - size(temp,2);

figure;
hx=axes;
imshow(im_normal,'Parent', hx);
imrect(hx,[xval,yval,size(temp,2),size(temp,1)])

filter = fspecial('gaussian', 50,10);
 
im_low = imfilter(im_normal, filter, 'replicate');
im_high = im_normal - im_low;

% imshow([im_low im_high]);