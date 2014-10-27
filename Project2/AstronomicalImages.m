% EECS 448
% Homework 3, group project
% 29 October 2014
% Roxanne Calderon, Lynne Lammers, Christine Perinchery

% prompt user to enter file path
fitsImage = input('Please enter the file path for a FITS image, surrounded by single quotes with a file extension: ');

% check for correct file type
isFITSFile = false;
while (~isFITSFile)
    fitsImageExt = fitsImage(end-4:end);
    if (~strcmp(fitsImageExt,'.fits'))
        fprintf('The file extension was incorrect. File extension must be .fits.\n');
        fitsImage = input('Please enter the file path for a FITS image, surrounded by single quotes with a file extension: ');
    else
        isFITSFile = true;
    end
end

%tests to make sure the image is found and loads correctly
try    
    I = fitsread(fitsImage);
catch % if filename/path was invalid, brings user back to main menu
    fprintf('The image specified was invalid.\n');
    scriptOpen = 6;
    return
end
% potentially get rid of this
figure;
imagesc(I);
colormap(gray);

%calculate maximum and minimum intensity values
%IT IS RETURNING NEGATIVE THIS DOES NOT BODE WELL
SPACEv = I(:);
minSPACE = min(SPACEv);
maxSPACE = max(SPACEv);
fprintf('\nMinimum for astronomical image: %f', minSPACE);
fprintf('\nMaximum for astronomical image: %f', maxSPACE);

%ask for lower and upper lightness value. 
fprintf('\n\nLightness levels require an upper and lower value.');
fprintf('\nRecommended: Lower: 0.01 - 0.1  Upper: 0.9 - 0.99'); 
fprintf('\nRequired: 0.01 - 0.99'); 
lowerLight = -1;
upperLight = -1; 
llNum = isnumeric(lowerLight); 
ulNum = isnumeric(upperLight);
%ensure user input is valid
while(lowerLight <= 0 || lowerLight >= 1 || upperLight <= 0 || upperLight >= 1 || ~llNum || ~ulNum)
  try
     lowerLight = input('\nPlease enter the lower light value: ');
     upperLight = input('Please enter the upper light value: ');
     llNum = isnumeric(lowerLight); 
     ulNum = isnumeric(upperLight);     
      if(lowerLight <= 0 || lowerLight >= 1 || upperLight <= 0 || upperLight >= 1 || ~llNum || ~ulNum)
        fprintf('You have entered an incorrect value. Please follow the required parameters.\n'); 
      end
  catch
    fprintf('You have entered an incorrect value. Please follow the required parameters. \n');
    lowerLight = -1;
    upperLight = -1;
  end
end

%ask for saturation
fprintf('\nSaturation');
fprintf('\nRecommended: 1-3'); 
fprintf('\nRequired: > 0'); 
saturation = -1;
satNum = isnumeric(saturation);
%ensure input is valid
while(saturation <= 0 || ~satNum) 
  try
    saturation = input('\nPlease enter the saturation: '); 
    satNum = isnumeric(saturation); 
    if(saturation <= 0 || ~satNum) 
        fprintf('You have entered an incorrect value. Please follow the required parameters. \n'); 
    end
  catch
     fprintf('You have entered an incorrect value. Please follow the required parameters. \n');
    saturation = -1; 
  end 
end


%ask for upper and lower tiles
fprintf('\nNumber of Tiles require two values: number of rows and number of columns');
fprintf('\nRecommended: 2-4'); 
fprintf('\nRequired: > 1'); 
lowerTiles = -1;
upperTiles = -1;
ltNum = isnumeric(lowerTiles); 
utNum = isnumeric(upperTiles);
%ensure input is valid
while(lowerTiles <= 1 || upperTiles <= 1 || ~ltNum || ~utNum)
   try
     lowerTiles = input('\nPlease enter the number of tile rows: ');
     upperTiles = input('Please enter the number of tile columns: ');
     ltNum = isnumeric(lowerTiles); 
     utNum = isnumeric(upperTiles);
     if(lowerTiles <= 1 || upperTiles <= 1 || ~ltNum || ~utNum) 
          fprintf('You have entered an incorrect value. Please follow the required parameters. \n'); 
       end
    catch
      fprintf('You have entered an incorrect value. Please follow the required parameters. \n'); 
      lowerTiles = -1; 
      upperTiles = -1; 
    end 
end


%scale image so all values are positive
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

fprintf('\n'); 

%display image
imshow(tonemappedImage); 
