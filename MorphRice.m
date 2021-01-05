I = imread('NM14.jpg');
J = imresize(I, 0.5);
imshow(I)
title('Original Image')
figure
imshow(J)
title('Resized Image')
J = rgb2gray(J);
figure
imshow(J)


background = imopen(J,strel('disk',15));

figure
imshow(background)


I2 = imsubtract(J,background); 
figure
imshow(I2)


I3 = imadjust(I2);
figure
imshow(I3);


level = graythresh(I3);
bw = im2bw(I3,level); 
figure
 imshow(bw)
 
 
 [labeled,numObjects] = bwlabel(bw,4);

 
 imshow(labeled);

 
 cc = bwconncomp(bw,4)
 cc.NumObjects
 
 
 grain = false(size(bw));
grain(cc.PixelIdxList{50}) = true;
figure
imshow(grain)
 %%%
 if(bw2)
 bw2 = bwmorph(bw,'remove');
figure, imshow(bw2)
title('Original Image')
 else
bw3 = bwmorph(bw,'skel',Inf);
figure, imshow(bw3)
title('Morph Image')
 end
%%%%%
 
 labeled = labelmatrix(cc);
whos labeled

RGB_label = label2rgb(labeled,'spring','c','shuffle');
figure
imshow(RGB_label)

%Compute Area-Based Statistics
%Compute the area of each object in the image using regionprops. 
%Each rice grain is one connected component in the cc structure.
graindata = regionprops(cc,'basic')

%Create a new vector grain_areas, which holds the area measurement for each grain.
grain_areas = [graindata.Area];

%Find the area of the 50th component.
grain_areas(50)

%Find and display the grain with the smallest area.
[min_area, idx] = min(grain_areas)

grain = false(size(bw));
grain(cc.PixelIdxList{idx}) = true;
figure
imshow(grain)

%Use the histogram command to create a histogram of rice grain areas.
% histogram(grain_areas)
histogram(grain_areas)
title('Histogram of  Grain Area')


 


