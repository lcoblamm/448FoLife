
%is there a way to remove need for single quotes? 

%i was just testing a while loop. we can find a cuter way to do this soon. 
scriptOpen = 'F';


while (scriptOpen ~= 'E') 

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

    else 
       fprintf('Invalid Input. Please Try Again\n'); 

    end

end

%what else to add? 
