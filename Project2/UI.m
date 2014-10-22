% EECS 448
% Homework 3, group project
% 29 October 2014
% Christine Perinchery, Lynne Lammers, Roxanne Calderon

scriptOpen = 0;
while (scriptOpen ~= 5) 

fprintf('\n1. Space (.FITS)');
fprintf('\n2. Medical (.DCM)'); 
fprintf('\n3. Natural Scene (.HDR)');
fprintf('\n4. RADAR Backscatter Data (.MAT)'); 
fprintf('\n5. Exit'); 
scriptOpen = input('\n\nWhich image do you want to convert? ');

    %Runs the program that the user specifies. 
    if (scriptOpen == 1) 
        run('AstronomicalImages.m'); 

    elseif (scriptOpen == 2)
        run('MedicalImages.m'); 

    elseif (scriptOpen == 3) 
        run('NaturalScenes.m'); 

    elseif (scriptOpen == 4) 
        run('RadarBackscatterData.m'); 

    elseif (scriptOpen == 5)
        fprintf('Goodbye! \n\n'); 
        break
    else 
        fprintf('Invalid Input. Please Try Again\n'); 
        
    end
    if (scriptOpen > 0) && (scriptOpen < 5)
        %give user option to save the picture they just created
        saveSelect = false;  
        while(~saveSelect) 
            saveOption = input('\nAre you satisfied with this image? Y/N: ')
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
    end     
end

