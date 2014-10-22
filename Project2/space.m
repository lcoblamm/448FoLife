% EECS 448
% Homework 3, group project
% 29 October 2014
% Roxanne Calderon, Lynne Lammers, Christine Perinchery

%check why negative numbers (is there a way to fix this? where are they?
%why are they here? how can I escape them?

% is there is a cuter way to do your error checking?

%prompt user to enter file path
fitsImage = input('Please enter the file path for an HDR image, surrounded by single quotes with a file extension: ');
I = fitsread(fitsImage);

%calculate maximum and minimum intensity values
%IT IS RETURNING NEGATIVE THIS DOES NOT BODE WELL
FITSv = I(:);
minFITS = min(FITSv);
maxFITS = max(FITSv);
fprintf('\nMinimum for FITS image: %f', minFITS);
fprintf('\nMaximum for FITS image: %f', maxFITS);

%ask for lower and upper lightness value. 
fprintf('\n\nLightness levels require an upper and lower value.');
fprintf('\nRecommended: Lower: 0.01 - 0.1  Upper: 0.9 - 0.99'); 
fprintf('\nRequired: 0.01 - 0.99'); 
lowerLight = -1;
upperLight = -1;
%ensure user input is valid
while(lowerLight <= 0 || lowerLight >= 1 || upperLight <= 0 || upperLight >= 1)

    lowerLight = input('\nPlease enter the lower light value: ');
    upperLight = input('Please enter the upper light value: ');
    
    if(lowerLight <= 0 || lowerLight >= 1 || upperLight <= 0 || upperLight >= 1)
        fprintf('You have entered an incorrect value. Please follow the required paramenters\n'); 
    end 
end 

%ask for saturation
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

%ask for upper and lower tiles
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

%scale image to become positive
T = (I-min(I(:))) ./ (max(I(:)-min(I(:))));
fits3(:,:,1) = T;
fits3(:,:,2) = T;
fits3(:,:,3) = T;

%tone mapped image
tonemappedImage = tonemap(fits3, 'AdjustLightness', [lowerLight upperLight], 'AdjustSaturation', saturation ,'NumberOfTiles', [lowerTiles upperTiles]); 

%calculate mean, standard deviation and signal-to-noise ratio
tonemappedV = tonemappedImage(:);
imageMean = mean(tonemappedV);
imageStdDev = std(double(tonemappedV));
r = imageMean / imageStdDev;
imageSNR = 20 * log10(r);
fprintf('\n\nMean of the tonemapped image: %f', imageMean);
fprintf('\nStandard Deviation of the tonemapped image: %f', imageStdDev);
fprintf('\nSignal-To-Noise Ratio of the tonemapped image: %f', imageSNR);

%display image
imshow(tonemappedImage); 

%give user option to save. 
saveSelect = false;  
while(~saveSelect) 
    saveOption = input('\nAre you satisfied with this image? Y/N: ');
    if(saveOption == 'Y' || saveOption == 'y')
        newFileName = input('Please enter the name of your new file, surrounded by single quotes, with no file extension: '); 
        saveName = strcat(newFileName, '.jpg'); 
        imwrite(tonemappedImage, saveName);
        fprintf('\n You will be returned to the main menu. Thank you!'); 
        saveSelect = true; 
    elseif(saveOption == 'N' || saveOption == 'n')
        fprintf('\n You will be returned to the main menu. Thank you!'); 
        saveSelect = true; 
    else
        fprintf('\n You have entered an incorrect response, please try again!'); 
    end
end
