%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% EliminacionCH.m
fprintf('\nEliminacionCH\n')
fprintf('%s\n',etapa)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eliminar los canales no validos y volver a calcular
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ingresar los canales que se eliminaran, se sale del loop apretando "Enter"
% Obs: ch_del tiene que ser eliminada, si no se podrian fusionar con la anterios
Ch_del = [];
ind_ch_del = [];

if strcmp(etapa,'seleccion')
    fprintf('\n***Etapa de Seleccion***\n\n')
    %load(name_registro);
    
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

    for j=1:largo_dataAll
        try
            Ch_del(j) = input('Ingrese numero del canal que desea eliminar: ');
            ind_ch_del(j) = find(canales_eval==Ch_del(j));
        catch
            break;
        end
    end
end    


% Se inicializan las nuevas matrices que tendran los canales seleccionados
data_allSelect = data_all;
Channel_select = Channel(canales_eval);
Area_select = Area(canales_eval);

if ~isempty(Ch_del)
    % Se eliminan los canales no deseados    
    data_allSelect(:,ind_ch_del) = [];   

    % Se eliminan los nombres de los canales no deseados
    Channel_select(ind_ch_del) = [];

    % Se eliminan las areas de los canales no deseados
    Area_select(ind_ch_del) = [];
end

% Se vuelve a calcular el tama�o de los canales
largo_dataAll_select = size(data_allSelect,2);

% Promedio de los LFP de todos los canales
promedio_LFPSelect = mean(data_allSelect,2);

% Inicializacion de la matriz
%data_allSelect_prom = zeros(size(data_allSelect));

fprintf('\nTodos los canales seleccionados que se usaran:\n\n');
fprintf('\tCanal\t\tArea\n');
for k = 1:largo_dataAll_select
    fprintf('\t %s\t\t %s\n',Channel_select{k},Area_select{k});

    eval(['data_select',Channel_select{k},'= data_allSelect(:,k);']);

    % Los LFP referenciados con el promedio de todos los canales
    %data_allSelect_prom(:,k) = data_allSelect(:,k)-promedio_LFPSelect;
end
fprintf('\n');

% Para que es este ploteo????
[C,ia,ic] = unique(Area_select,'stable');

for m = 1:length(ia)%1:largo_dataAll  
    i = ia(m);
    % pasar con un boton
    areas_actuales = find(ic == ic(i));
    
    % Sirve para eliminar artefactos
    fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
    plot(time_step_m(time_step_m<tiempo_total), data_allSelect(:,areas_actuales))
    legend('Show')
    line([pre_m pre_m], get(gca, 'ylim'),'Color','black','LineWidth',1.0,'Marker','.','LineStyle',':');
    line([on_inicio_m on_inicio_m], get(gca, 'ylim'),'Color','black','LineWidth',1.0,'Marker','.','LineStyle',':');
    line([on_final_m on_final_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([post_m post_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    xlim([0 tiempo_total])
    xlabel('Tiempo (minutos)'); ylabel('Amplitud')
    title(['Todos los LFP en el tiempo del Area ',C(ic(i))])
    
    % Guardar la figura
    %saveas(fig_1,['Imagenes',path(35:end),'Todos los LFP en el tiempo del Area ',C(ic(i)),'.png'])
    
    waitforbuttonpress;
end
