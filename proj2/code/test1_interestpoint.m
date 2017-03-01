im = checkerboard(50,2,2);


sigma = 2 
h = fspecial('gaussian',max(1,fix(6*sigma)), sigma);
im_ = im;

dx = [-1 0 1; -1 0 1; -1 0 1];
dy = [-1 -1 -1; 0 0 0; 1 1 1];

[gx gy] = imgradientxy(im_,'prewitt');


gx = imfilter(gx.*gx,h,'same');
gy = imfilter(gy.*gy,h,'same');
gxy = imfilter(gx.*gy,h,'same');



im_x = imfilter(im_,dx,'same');
im_y = imfilter(im_,dy,'same');


imx = im_x.*im_x;
imy = im_y.*im_y;
imxy = (im_x.*im_y).*(im_x.*im_y);

imx =  imfilter(imx, h,'same');
imy = imfilter(imy,h,'same');
imxy = imfilter(imxy,h,'same');

R = (imx .* imy) - 0.04 * ((imx+imy).^2);
R2 = (gx .* gy) - 0.04 * ((gx+gy).^2);



Rmx = colfilt(R, [ 6 6 ], 'sliding', @max);
Rn = (R==Rmx) & (R>0.5);
[ m n ]= find(Rn);
figure, imshow(im), axis image, hold on;
plot(n,m,'*');
hold off;
R2mx = colfilt(R2, [6 6], 'sliding', @max); 
R2n = (R2 == R2mx) & (R2>0.5);
[a b] = find(R2n);

figure, imshow(im),axis image, hold on;
plot(b, a, '*');

