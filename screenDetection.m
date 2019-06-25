% Screen Detection in a Dark Room
% Developed By Ashadullah Shawon
% Software Engineer, FSMB
% Email: shawona@frontiersemi.com

im=imread('I:\Shawon\matlab\FPD\screen.JPG');
im1=rgb2gray(im);
im1=medfilt2(im1,[3 3]); %Median filtering the image to remove noise%
BWm = edge(im1,'sobel'); %finding edges MASK
%figure(2),imshow(BWm);
%BWm=bwareaopen(BWm, 900);
% Dilate mask with disk
radius = 3;
decomposition = 0;
se = strel('disk', radius, decomposition);
BW = imdilate(BWm, se);

%removing unnecessary regions
%img=BW;
%lb = logical(img);
%st = regionprops(lb, 'Area', 'PixelIdxList' );
%toRemove = [st.Area]<85000; % fix your threshold here
%BW = img;
%BW(vertcat(st(toRemove).PixelIdxList)) = 0; % remove

[imx,imy]=size(BWm);
msk=[0 0 0 0 0;
     0 1 1 1 0;
     0 1 1 1 0;
     0 1 1 1 0;
     0 0 0 0 0;];
B=conv2(double(BW),double(msk)); %Smoothing  image to reduce the number of connected components

%corners = detectHarrisFeatures(B,'MinQuality', 0.01,'FilterSize',3);
%imshow(B); hold on;
%plot(corners.selectStrongest(100));
% Create masked image.
%maskedImage = im;
%maskedRgbImage = bsxfun(@times, im, cast(BW, 'like', im));

mask3 = cat(3, BW, BW, BW);
RGBm  = im;
RGBm(mask3) = 0;
st = regionprops(BW, 'BoundingBox' );
figure(2),imagesc(im);
hold on
thisBB = st(k).BoundingBox;
rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
'EdgeColor','r','LineWidth',2 )

