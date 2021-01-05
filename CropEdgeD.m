clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
% fontSize = 20;

% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
	% User does not have the toolbox installed.
	message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
	reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
	if strcmpi(reply, 'No')
		% User said No, so exit.
		return;
	end
end

%===============================================================================
% Read in a gray scale demo image.
folder = 'C:\Sonali Matlab\Matlab\MorphP';
baseFileName = 'AM16.jpg';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
	% File doesn't exist -- didn't find it there.  Check the search path for it.
	fullFileNameOnSearchPath = baseFileName; % No path this time.
	if ~exist(fullFileNameOnSearchPath, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	grayImage = grayImage(:, :, 2); % Take green channel.
end
% Crop off wide white border
% grayImage = grayImage(31:630, 83:432);
% Update dimensions.
[rows, columns, numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(3, 3, 1);
imshow(grayImage, []);
axis on;
title('Original Grayscale Image');
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off') 

% Let's compute and display the histogram.
[pixelCount, grayLevels] = imhist(grayImage);
subplot(3, 3, 2); 
bar(grayLevels, pixelCount);
grid on;
title('Histogram of original image');
xlim([0 grayLevels(end)]); % Scale x axis manually.

% Let's get the vertical profile
sides = [grayImage(:, 1:70), grayImage(:, 300:end)];
verticalProfile = mean(sides, 2);
% Let's smooth it with a Saviztky-Golay filter (optional)
verticalProfile = sgolayfilt(verticalProfile, 2, 45);
subplot(3, 3, 3); 
plot(verticalProfile, 'b-', 'LineWidth', 2);
grid on;
title('Vertical Profile of Background');

% Make a background image that we can divide by.
backgroundImage = repmat(verticalProfile, [1, columns]);
subplot(3, 3, 4);
imshow(backgroundImage, []);
axis on;
title('Background Image');

% divide the image by the profile
flattenedImage = uint8(255 * double(grayImage) ./ backgroundImage);
subplot(3, 3, 5);
imshow(flattenedImage, []);
axis on;
title('Background Corrected Image');

% Let's compute and display the histogram of the background corrected image.
[pixelCountBG, grayLevelsBG] = imhist(flattenedImage);
% Suppress last bin which is a huge spike at 255, just so we can see the shape.
pixelCountBG(end) = 0;
subplot(3, 3, 6); 
bar(grayLevelsBG, pixelCountBG);
grid on;
title('Histogram of Background Corrected Image');
xlim([0 grayLevelsBG(end)]); % Scale x axis manually.

% Now let's threshold the image at 175.
binaryImage = flattenedImage < 125;
subplot(3, 3, 7);
imshow(binaryImage, []);
axis on;
title('Binary Image');

% For fun, mask the image
backgroundImage = grayImage;
backgroundImage(binaryImage) = 0;
subplot(3, 3, 8);
imshow(backgroundImage, []);
axis on;
title('Background Image');
mouseImage = grayImage;
mouseImage(~binaryImage) = 0;
subplot(3, 3, 9);
imshow(mouseImage, []);
axis on;
title(' Image');


