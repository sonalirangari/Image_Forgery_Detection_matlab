% 
% clc;
% clear all;
% close all;
% 
% f=imread('NM2.jpg');
% f=rgb2gray(f);
% sub=zeros(size(f));
% [ROW COLUMN]=size(sub);
% f=im2double(f);
% 
% % Global Thresholding
% T=0.5*(min(f(:))+max(f(:)));
% done=false;
% while ~done
%     g=f>=T;
%     Tn=0.5*(mean(f(g))+mean(f(~g)));
%     done=abs(T-Tn)<0.1;
%     T=Tn;
% end
% r=im2bw(f,T);
% R=double(r);
% %Image Subtraction
% for i=1:ROW
%         for j=1:COLUMN
%             sub(i,j)=R(i,j)-f(i,j);
%         end
% end
% % Sliding Neighborhood Normalization
% fun = @(x) mode(x(:));
% B = nlfilter(sub,[3 3],fun);
% 
% figure;
% subplot(2,2,1),imshow(f),title('Original Image');
% subplot(2,2,2),imshow(r),title('Global Thresholding - Iterative Method');
% subplot(2,2,3),imshow(sub),title('Subtracted Image');
% subplot(2,2,4),imshow(B),title('Final Result');


%Code start
clc; 
[filename, folder] = uigetfile ({'*.jpg';'*.bmp';'*.png'}, 'File Selector'); 
fullFileName = fullfile(folder, filename); 
img = imread(fullFileName); 
figure(1);
imshow(img); 
FaceDetect = vision.CascadeObjectDetector; 
FaceDetect.MergeThreshold = 7 ;
BB = step(FaceDetect, img); 
figure(2);
imshow(img); 
for i = 1 : size(BB,1)     
  rectangle('Position', BB(i,:), 'LineWidth', 3, 'LineStyle', '-', 'EdgeColor', 'r'); 
end 
for i = 1 : size(BB, 1) 
  J = imcrop(img, BB(i, :)); 
  figure(3);
  subplot(6, 6, i);
  imshow(J); 
end
%Code End