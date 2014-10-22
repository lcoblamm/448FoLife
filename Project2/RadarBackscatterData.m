% EECS 448
% Homework 3, group project
% 10 October 2014
% Christine Perinchery, Lynne Lammers, Roxanne Calderon

% load may09_03.022-may09_03.027.mat;

MatImage = input('Please enter the file path for an MAT image, surrounded by single quotes with a file extension: ');
load(MatImage);

imagesc((log10(A)));
colormap(gray);
% radarImage = imagesc(radarI.Data);

% calculate and print average minimum and average maximum intensity values 
aveRadarImage = A(:);
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

%
radarImageTM = A;
radarImageTM(:,:,2) = A;
radarImageTM(:,:,3) = A;

% tone map image and display
tonemappedImage = tonemap(radarImageTM,'AdjustLightness', [lowerLight upperLight], 'AdjustSaturation', saturation ,'NumberOfTiles', [lowerTiles upperTiles]);
figure;
imshow(tonemappedImage) 

% calculate the mean, standard deviation, and signal to noise ratio
aveToned = (redToned/3) + (greenToned/3) + (blueToned/3);
imageMean = mean(aveToned(:));
imageStdDev = std(double(aveToned(:)));
r = imageMean / imageStdDev;
imageSNR = 20 * log10(r);
fprintf('\n\nMean of the tonemapped image: %f', imageMean);
fprintf('\nStandard Deviation of the tonemapped image: %f', imageStdDev);
fprintf('\nSignal-To-Noise Ratio of the tonemapped image: %f', imageSNR);
fprintf('\nHave a nice day!\n');
