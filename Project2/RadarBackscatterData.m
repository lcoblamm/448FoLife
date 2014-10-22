% EECS 448
% Homework 3, group project
% 29 October 2014
% Christine Perinchery, Lynne Lammers, Roxanne Calderon

MatImage = input('Please enter the file path for an MAT image, surrounded by single quotes with a file extension: ');
k = strfind(MatImage, '.mat');
if k == []
    fprintf('The file name specified did not have a .mat file extension.\nStart over.\n');
    exit;
end    
load(MatImage);
imagesc((log10(A)));
colormap(gray);

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
%ensure user input is valid
lowerLight = -1;
upperLight = -1;
while(lowerLight <= 0 || lowerLight >= 1 || upperLight <= 0 || upperLight >= 1)

    lowerLight = input('\nPlease enter the lower light value: ');
    upperLight = input('Please enter the upper light value: ');
    
    if(lowerLight <= 0 || lowerLight >= 1 || upperLight <= 0 || upperLight >= 1)
        fprintf('You have entered an incorrect value. Please follow the required paramenters\n'); 
    end 
end 

% prompt user to enter saturation value
fprintf('\nSaturation');
fprintf('\nRecommended: 1-3'); 
fprintf('\nRequired: > 0'); 
saturation = -1;
%ensure input is valid
while(saturation <= 0)
    saturation = input('\nPlease enter the saturation: ');
    
    if(saturation <= 0)
        fprintf('You have entered an incorrect value. Please follow the required parameters. \n'); 
    end
end 

% prompt user to enter number of tiles
fprintf('\nNumber of Tiles require two values: number of rows and number of columns');
fprintf('\nRecommended: 2-4'); 
fprintf('\nRequired: > 1'); 
lowerTiles = -1;
upperTiles = -1;
%ensure input is valid
while(lowerTiles <= 1 || upperTiles <= 1)
    
    lowerTiles = input('\nPlease enter the number of tile rows: ');
    upperTiles = input('Please enter the number of tile columns: ');

    if(lowerTiles <= 1 || upperTiles <= 1)
        fprintf('\nYou have entered an incorrect value. Please follow the required parameters. \n'); 
    end
end

% Duplicate the array so that it is three dimensions
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
