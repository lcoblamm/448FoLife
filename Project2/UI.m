
%is there a way to remove need for single quotes? 

%i was just testing a while loop. we can find a cuter way to do this soon. 
scriptOpen = 'F';


while (scriptOpen ~= 1) 

%simple menu? needs to be exact and surrounded in single quotes. any ideas
%on improving? 
fprintf('\n1. Space (.FITS)');
fprintf('\n2. Medical (.DCM)'); 
fprintf('\n3. Natural Scene (.HDR)');
fprintf('\n4. RADAR Backscatter Data (.MAT)'); 
fprintf('\n5. Exit'); 
scriptOpen = input('\n\nWhich image do you want to convert? ');

    %remove cheers, update file names. 
    if (scriptOpen == 1) 
        run('space.m'); 

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
        %give user option to save. 
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

%what else to add? 
