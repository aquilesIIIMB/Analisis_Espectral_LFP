%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Delete_CH.m
fprintf('\nEliminacionCH\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eliminar los canales no validos y volver a calcular
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.stage.view_spectrum 
    error('Falta el bloque de visualizacion de LFP');

end

% Sonido de alerta que se necesita al usuario
sonido_alarma;    

% Ingresar los canales que se eliminaran, se sale del loop apretando "Enter"
Ch_del = [];

% Confirma que ya se seleccionaron los canales
while 1
    try
        confirmacion_Param = input('Ya seleccionaste los canales a eliminar?[Type si]:  ','s');
    catch
        continue;
    end

    if strcmp(confirmacion_Param,'si')  
        fprintf('\nEliminemos Canales \n\n');
        break
    end
end

while 1
    try
        Ch_del_actual = input('Ingrese numero del canal que desea eliminar: ');
        if isempty(Ch_del_actual)
            break;        
        end
        Ch_del = [Ch_del, Ch_del_actual];
    catch
        break;
    end
end

if ~isempty(Ch_del)
    % Se notifica como removido
    [registroLFP.channel(Ch_del).removed] = deal(1);
    
end

% Canales que seran evaluados despues de eliminar los que no son adecuados
canales_eval_selected = find(~[registroLFP.channel.removed]);

fprintf('\nTodos los canales seleccionados que se usaran:\n\n');
fprintf('\tCanal\t\tArea\n');
for k = 1:length(canales_eval_selected)
    fprintf('\t %s\t\t %s\n',registroLFP.channel(canales_eval_selected(k)).name , registroLFP.channel(canales_eval_selected(k)).area);
end
fprintf('\n');

registroLFP.stage.delete_channel = 1;

% Eliminacion de variables no utilizadas
clear Ch_del confirmacion_Param canales_eval_selected k Ch_del_actual

    