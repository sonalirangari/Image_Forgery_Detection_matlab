%How to extract features of image using DCT
clc
clear all
close all
I = imread('BM3.jpg');
K = imresize(I,[256 256]);
ycbcr = rgb2ycbcr(K);
figure(1),
imshow(ycbcr);
title('Image in RGB Color Space');
%a = 128+zeros(256,256);
    %Isolate Y. 
Y = ycbcr(:,:,1);
    %Isolate Cb. 
Cb = ycbcr(:,:,2);
    %Isolate Cr. 
Cr= ycbcr(:,:,3);
    
figure(2), imshow(Y), title('Y ( Luminance component) Component')
    %Display the Cb Component.
figure(3), imshow(Cb), title('Cb (Chrominance component) Component')
     %Display the Cr Component.
 figure(4), imshow(Cr), title('Cr (Chrominance component ) Component')


%%
%Extract histogram of oriented gradients (HOG) features
%(1)Extract HOG Features Around Corner Points
% Read in the image of interest.
I2 = imread('BM3.jpg');

% Detect and select the strongest corners in the image.
corners   = detectFASTFeatures(rgb2gray(I2));
strongest = selectStrongest(corners,3);

% Extract HOG features.
[hog2, validPoints,ptVis] = extractHOGFeatures(I2,strongest);
% Display the original image with an overlay of HOG features around the strongest corners.
figure(5);
imshow(I2);
hold on;
plot(ptVis,'Color','green');



% (2)Extract HOG Features using CellSize
% Read the image of interest.
I1 = imread('BM3.jpg');

% Extract HOG features.
[hog1,visualization] = extractHOGFeatures(I1,'CellSize',[32 32]);
%Display the original image and the HOG features.
figure(6),
subplot(1,2,1);
imshow(I1);
subplot(1,2,2);
plot(visualization);


% (3)Extract and Plot HOG Features
% Read the image of interest.
img = imread('BM3.jpg');

% Extract HOG features.
[featureVector,hogVisualization] = extractHOGFeatures(img);

% Plot HOG features over the original image.
figure(7);
imshow(img); 
hold on;
plot(hogVisualization);

%%
% The histograms of multi-resolution WLD using Cr chrominance
% component for (a) Original and (b) copy-moved forged images without
% doing anything on the copied region.
Im1 = imread('B3.jpg');
J=rgb2gray(Im1);
figure(8),
subplot(2,2,1);
imshow(J);
title('Original Image');

subplot(2,2,2);
imhist(J,256);
title('Histogram of original image')

Im2 = imread('BM3.jpg');
A=rgb2gray(Im2);
subplot(2,2,3);
imshow(A);
title('Forged Image');

subplot(2,2,4);
imhist(A,256);
title('Histogram of Forged image')

%%
% The  Euclidean distance for the calculation is given below 
Im1 = imread('B3.jpg');
Im2 = imread('BM3.jpg');
figure(9),
%plotting of them
subplot(1,2,1);
imshow(Im1);
subplot(1,2,2);
imshow(Im2);
Im1=rgb2gray(Im1);
Im2=rgb2gray(Im2);

%the code for conversion of image to its normalized histogram

hn1 = imhist(Im1)./numel(Im1);
hn2 = imhist(Im2)./numel(Im2);

% Calculate the Euclidean distance
E_distance = sum(sqrt(hn1 - hn2).^2)
%f=norm(hn1,hn2);


%%
% The  Manhattan distance for the calculation is given below

Im1 = imread('B3.jpg');
Im2 = imread('BM3.jpg');
figure(10),
%plotting of th1em
subplot(1,2,1);
imshow(Im1);
subplot(1,2,2);
imshow(Im2);
Im1=rgb2gray(Im1);
Im2=rgb2gray(Im2);
%the code for conversion of image to its normalized histogram

hn1 = imhist(Im1)./numel(Im1);
hn2 = imhist(Im2)./numel(Im2);

% Calculate the Manhattan distance
M_distance = sum(abs(hn1 - hn2))
