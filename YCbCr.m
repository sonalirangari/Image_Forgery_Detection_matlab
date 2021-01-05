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
 
 
groundTruth = imread('B3.jpg'); 

sensitivityValues = zeros(256,1); % array to hold sensitivity values for different thresholds
specifityValues = zeros(256,1); % array to hold specifity values for different thresholds

for thresh = 0:1:255  % loop for every threshold value           
    I = imread('BM3.jpg');
    %thresholding image
    for x=1:size(I,1)
        for y=1:size(I,2)
            if(I(x,y) <= thresh)
                I(x,y) = 0;
            else
                I(x,y) = 255;
            end
        end
    end
    
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    
    %counting negatives and positives
    for x=1:size(I,1)
        for y=1:size(I,2)
            if(I(x,y) == 0) %negative                
                if(groundTruth(x,y) == 0)% check if it is true negative using ground truth
                    TN = TN + 1;
                else
                    FN = FN + 1;
                end
            else % positive                
                if(groundTruth(x,y) == 255)% check if it is true positive using ground truth
                    TP = TP + 1;
                else
                    FP = FP + 1;
                end                
            end       
        end
    end
   
    sensitivity = 1.0 * TP / (TP+FN); % calculate sensitivity
    specifity = 1.0 * FP / (FP+TN); % calculate specificty

    sensitivityValues(thresh+1) = sensitivity; %add to array
    specifityValues(thresh+1) = specifity; %add to array
end

%calculate nearest point to the left corner which is the best threshold value
%according to ROC
min = 1;
for a= 1:256
    dist = sqrt((1-sensitivityValues(a))^2 + (0-specifityValues(a))^2);
    if(dist < min)
        min = dist;
        mina = a;
    end
end
disp(mina-1); % print best threshold value

%plot ROC
figure('Name','ROC','NumberTitle','off'),plot(specifityValues,sensitivityValues,'x');
xlabel('FP Fraction');
ylabel('TP Fraction');
 
 
 
 
 
%  Im1 = imread('B3.jpg');
% Im2 = imread('BM3.jpg');
% %plotting of th1em
% subplot(1,2,1);
% imshow(Im1);
% subplot(1,2,2);
% imshow(Im2);
% Im1=rgb2gray(Im1);
% Im2=rgb2gray(Im2);
% %the code for conversion of image to its normalized
% % histogram
% x = imhist(Im1)./numel(Im1);
% y = imhist(Im2)./numel(Im2);
% % Calculate the Euclidean distance
% E_distance = sqrt(sum((x-y).^2));
% 
% 
% %Histogram modelling
% I=imread('C:\Sonali Matlab\Matlab\MorphP\FM1.png');
% J=rgb2gray(I);
% subplot(2,2,1);
% imshow(J);
% title('Original Image');
% A=histeq(J);
% subplot(2,2,2);
% imshow(A);
% title('Histogram equalized image');
% 
% 
% M=imread('C:\Sonali Matlab\Matlab\MorphP\FM1.png');
% N=rgb2gray(M);
% subplot(2,2,3);
% imhist(N,256);
% title('Histogram of original image')
% 
% B=histeq(N);
% subplot(2,2,4);
% imhist(B,256);
% title('Histogram of histogram equalized image')