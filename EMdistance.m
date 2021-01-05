% I = imread('B3.jpg'); 
% I = rgb2gray(I);
% h = imhist(I); % this will have default bins 256
% % now second image 
% J = imread('BM3.jpg'); 
% J = rgb2gray(J);
% h1 = imhist(J); % this will have default bins 256 
% E_distance = sqrt(sum((h-h1).^2));


% groundTruth = imread('R7.png'); 
% 
% sensitivityValues = zeros(256,1); % array to hold sensitivity values for different thresholds
% specifityValues = zeros(256,1); % array to hold specifity values for different thresholds
% 
% for thresh = 0:1:255  % loop for every threshold value
%     I = imread('RM7.png');
%     %thresholding image
%     for x=1:size(I,1)
%         for y=1:size(I,2)
%             if(I(x,y) <= thresh)
%                 I(x,y) = 0;
%             else
%                 I(x,y) = 255;
%             end
%         end
%     end
%     
%     TP = 0;
%     FP = 0;
%     TN = 0;
%     FN = 0;
%     
%     %counting negatives and positives
%     for x=1:size(I,1)
%         for y=1:size(I,2)
%             if(I(x,y) == 0) %negative                
%                 if(groundTruth(x,y) == 0)% check if it is true negative using ground truth
%                     TN = TN + 1;
%                 else
%                     FN = FN + 1;
%                 end
%             else % positive                
%                 if(groundTruth(x,y) == 255)% check if it is true positive using ground truth
%                     TP = TP + 1;
%                 else
%                     FP = FP + 1;
%                 end                
%             end       
%         end
%     end
%    
%     sensitivity = 1.0 * TP / (TP+FN); % calculate sensitivity
%     specifity = 1.0 * FP / (FP+TN); % calculate specificty
% 
%     sensitivityValues(thresh+1) = sensitivity; %add to array
%     specifityValues(thresh+1) = specifity; %add to array
% end
% 
% %calculate nearest point to the left corner which is the best threshold value
% %according to ROC
% min = 1;
% for a= 1:256
%     dist = sqrt((1-sensitivityValues(a))^2 + (0-specifityValues(a))^2);
%     if(dist < min)
%         min = dist;
%         mina = a;
%     end
% end
% disp(mina-1); % print best threshold value
% 
% %plot ROC
% figure('Name','ROC (Receiver Operating Characteristics.)','NumberTitle','on'),plot(specifityValues,sensitivityValues,'x');
% xlabel('FP ( False Positive Ratio) Fraction');
% ylabel('TP(True Positive Ratio) Fraction');

%%
% The  Euclidean distance for the calculation is given below 
Im1 = imread('H10.jpg');
Im2 = imread('HM10.jpg');
figure(1),
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
% % The  Manhattan distance for the calculation is given below
% 
% Im1 = imread('B3.jpg');
% Im2 = imread('BM3.jpg');
% figure(2),
% %plotting of th1em
% subplot(1,2,1);
% imshow(Im1);
% subplot(1,2,2);
% imshow(Im2);
% Im1=rgb2gray(Im1);
% Im2=rgb2gray(Im2);
% %the code for conversion of image to its normalized histogram
% 
% hn1 = imhist(Im1)./numel(Im1);
% hn2 = imhist(Im2)./numel(Im2);
% 
% % Calculate the Manhattan distance
% M_distance = sum(abs(hn1 - hn2))
