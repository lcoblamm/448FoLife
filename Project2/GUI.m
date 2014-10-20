
%is there a way to remove need for single quotes? 

%i was just testing a while loop. we can find a cuter way to do this soon. 
scriptOpen = 'F';


while (scriptOpen ~= 'E') 

%simple menu? needs to be exact and surrounded in single quotes. any ideas
%on improving? 
fprintf('\nA. Space (.FITS)');
fprintf('\nB. Medical (.DCM)'); 
fprintf('\nC. Natural Scene (.HDR)');
fprintf('\nD. RADAR Backscatter Data (.MAT'); 
fprintf('\nE. Exit'); 
scriptOpen = input('\n\nWhich image do you want to convert? ');

%remove cheers, update file names. 
if (scriptOpen == 'A') 
    fprintf('Whoohoo! \n\n');
    run('space.m'); 
    
elseif (scriptOpen == 'B')
    fprintf ('Yippee! \n\n');
    %run('medical.m'); 
     
elseif (scriptOpen == 'C')
    fprintf('Hooray! \n\n'); 
    %run('radar.m'); 
        
elseif (scriptOpen == 'D')
    fprintf('Hurrah! \n\n'); 
    %run('naturalscenes.m'); 
        
elseif (scriptOpen == 'E')
    fprintf('Goodbye! \n\n'); 
        
else 
   fprintf('Invalid Input. Please Try Again\n'); 

end

end

%what else to add? 
