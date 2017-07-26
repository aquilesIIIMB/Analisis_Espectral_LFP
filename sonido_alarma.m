function sonido_alarma()
% Sonido de alarma para pedir que el usuario modifique algo
% Se abre una ventana figure y en ella hay q presionar "Enter"
WarnWave = [sin(1:.6:400), sin(1:.7:400), sin(1:.4:400)];
Audio = audioplayer(WarnWave, 22050);
play(Audio);
currkey=0;
% do not move on until enter key is pressed
while currkey~=1
    %pause; % wait for a keypress
    pause(1);
    resume(Audio);
    currkey=get(gcf,'CurrentKey'); 
    if strcmp(currkey, 'return') % You also want to use strcmp here.
        currkey=1; % Error was here; the "==" should be "="
    else
        currkey=0; % Error was here; the "==" should be "="
        %close all
    end
end

close(gcf) 
input('')

end