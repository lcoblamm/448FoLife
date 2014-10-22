% EECS 448
% Homework 3, group project
% 19 October 2014
% Christine Perinchery, Lynne Lammers, Roxanne Calderon

% prompt user to enter image file path
DCMImage = input('Please enter the file path for a medical image, surrounded by single quotes with a file extension: ');
%tests to make sure the image is found and loads correctly
try    
    I = dicomread(DCMImage);
catch % if filename/path was invalid, brings user back to main menu
    fprintf('The image specified was invalid.\n');
    scriptOpen = 6;
    return
end

% calculate and print minimum and maximum intensity values 
DCMv = I(:);
minDCM = min(DCMv);
maxDCM = max(DCMv);
fprintf('\nMinimum for DCM image: %f', minDCM);
fprintf('\nMaximum for DCM image: %f', maxDCM);

% prompt user to enter lightness values
fprintf('\n\nLightness levels require an upper and lower value.');
fprintf('\nRecommended: Lower: 0.01 - 0.1  Upper: 0.9 - 0.99'); 
fprintf('\nRequired: 0.01 - 0.99'); 
% ensure user input is valid
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

% create m x n x 3 matrix by layering the dcm image 3 times
dcm3(:,:,1) = I;
dcm3(:,:,2) = I;
dcm3(:,:,3) = I;

% tone map image and display
tonemappedImage = tonemap(double(dcm3),'AdjustLightness', [lowerLight upperLight], 'AdjustSaturation', saturation ,'NumberOfTiles', [lowerTiles upperTiles]);
figure;
imshow(tonemappedImage) 

% calculate the mean, standard deviation, and signal to noise ratio
tonemappedV = tonemappedImage(:);
imageMean = mean(tonemappedV);
imageStdDev = std(double(tonemappedV));
r = imageMean / imageStdDev;
imageSNR = 20 * log10(r);
fprintf('\n\nMean of the tonemapped image: %f', imageMean);
fprintf('\nStandard Deviation of the tonemapped image: %f', imageStdDev);
fprintf('\nSignal-To-Noise Ratio of the tonemapped image: %f', imageSNR);

