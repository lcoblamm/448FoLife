% EECS 448
% Homework 3, group project
% 10 October 2014
% Christine Perinchery, Lynne Lammers, Roxanne Calderon

load may09_03.022-may09_03.027.mat;

imagesc((log10(A)));
radarImage = colormap(gray);
% radarImage = imagesc(radarI.Data);

% calculate and print average minimum and average maximum intensity values 
% redHDR = radarImage(:,:,1);
% greenHDR = radarImage(:,:,2);
% blueHDR = radarImage(:,:,3);
% aveHDR = (redHDR/3) + (greenHDR/3) + (blueHDR/3);
aveRadarImage = radarImage(:);
minRadarImage = min(aveRadarImage);
maxRadarImage = max(aveRadarImage);
fprintf('\nMinimum for Radar Backscatter data: %f', minRadarImage);
fprintf('\nMaximum for Radar Backscatter data: %f\n', maxRadarImage);

% prompt user to enter lightness values
fprintf('\n\nLightness levels require an upper and lower value.');
fprintf('\nRecommended: Lower: 0.01 - 0.1  Upper: 0.9 - 0.99'); 
fprintf('\nRequired: 0.01 - 0.99'); 
lowerLight = input('\nPlease enter the lower light value: ');
upperLight = input('Please enter the upper light value: ');

% prompt user to enter saturation value
fprintf('\nSaturation');
fprintf('\nRecommended: 1-3'); 
fprintf('\nRequired: > 0'); 
saturation = input('\nPlease enter the saturation: ');

% prompt user to enter number of tiles
fprintf('\nNumber of Tiles require two values: number of rows and number of columns');
fprintf('\nRecommended: 2-4'); 
fprintf('\nRequired: > 1'); 
lowerTiles = input('\nPlease enter the number of tile rows: ');
upperTiles = input('Please enter the number of tile columns: ');

% radarImageTM(:,:,1) = radarImage;
% radarImageTM(:,:,2) = radarImage;
% radarImageTM(:,:,3) = radarImage;
radarImageTM = radarImage;
radarImageTM(:,:,2) = radarImage;
radarImageTM(:,:,3) = radarImage;

% tone map image and display
tonemappedImage = tonemap(radarImageTM,'AdjustLightness', [lowerLight upperLight], 'AdjustSaturation', saturation ,'NumberOfTiles', [lowerTiles upperTiles]);
figure;
imshow(tonemappedImage) 
% 
% % calculate the mean, standard deviation, and signal to noise ratio
% redToned = tonemappedImage(:, :, 1);
% greenToned = tonemappedImage(:, :, 2);
% blueToned = tonemappedImage(:, :, 3);
% aveToned = (redToned/3) + (greenToned/3) + (blueToned/3);
% imageMean = mean(aveToned(:));
% imageStdDev = std(double(aveToned(:)));
% r = imageMean / imageStdDev;
% imageSNR = 20 * log10(r);
% fprintf('\n\nMean of the tonemapped image: %f', imageMean);
% fprintf('\nStandard Deviation of the tonemapped image: %f', imageStdDev);
% fprintf('\nSignal-To-Noise Ratio of the tonemapped image: %f', imageSNR);
% fprintf('\nHave a nice day!\n');
