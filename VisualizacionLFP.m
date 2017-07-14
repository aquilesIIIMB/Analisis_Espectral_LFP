%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% VisualizacionLFP.m
fprintf('\nVisualizacionLFP\n')
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graficar los LFP e Histogramas para evluar cual eliminar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Promedio de los LFP de todos los canales
promedio_LFP = mean(data_all,2); %% Ver si es necesario

% Cantidad de canales
largo_dataAll = size(data_all,2);

% Inicializacion de la matriz
data_all_prom = zeros(size(data_all));

% Se muestran los canales con sus areas y se aprovecha el for
fprintf('\nTodos los canales registrados:\n\n');
fprintf('\tCanal\t\tArea\n');
for k = 1:largo_dataAll
    fprintf('\t %s\t\t %s\n',Channel{canales_eval(k)},Area{canales_eval(k)});
    
    % Los LFP referenciados con el promedio de todos los canales
    data_all_prom(:,k) = data_all(:,k)-promedio_LFP;
end
fprintf('\n');
pause(5) % 5 seg. para observar los canales y sus areas

% Crear carpeta para guardar las imagnes 35:end
inicio_new_dir = slash_backslash(length(slash_backslash)-2);
foldername = path(inicio_new_dir:length(path));
if ~exist(foldername, 'dir')
  mkdir('Imagenes',foldername);
end

% indices de las mismas areas
[C,ia,ic] = unique(Area(canales_eval),'stable');

for m = 1:length(ia)%1:largo_dataAll  
    i = ia(m);
    % pasar con un boton
    areas_actuales = find(ic == ic(i));
    largo_areasActuales = length(areas_actuales);
    
    % limites maximos y minimos en amplitud para observar los LFP a la misma escala
    lim_max = max(max(data_all(:,areas_actuales)));
    lim_min = min(min(data_all(:,areas_actuales)));
    
    % Crear legend
    str_CH = char(ones(largo_areasActuales,1).*'Ch');
    str_num = int2str(canales_eval(areas_actuales)');
    str_numCH = strcat(str_CH,str_num);

    fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
    for q = 1:largo_areasActuales
        
        %subplot(2,4,q); %Modificar el 4 por si hay mas de 8 en cada area
        %dummy = data_all(:,canales_eval(areas_actuales(q)));
        %plot(time_step_m(time_step_m<tiempo_total), (500*q)+dummy)
        eval(['plot(time_step_m(time_step_m<tiempo_total), -(500*q)+data_',int2str(canales_eval(areas_actuales(q))),');']);
        hold on;
        
        %ylim([lim_min lim_max])
        
    end
    legend(str_numCH)
    
    % Lineas divisorias de cada fase
    line([pre_m pre_m], get(gca, 'ylim'),'Color','black','LineWidth',1.0,'Marker','.','LineStyle',':');
    line([on_inicio_m on_inicio_m], get(gca, 'ylim'),'Color','black','LineWidth',1.0,'Marker','.','LineStyle',':');
    line([on_final_m on_final_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([post_m post_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    
    xlim([0 tiempo_total])
    xlabel('Tiempo (minutos)'); ylabel('Amplitud')
    title([C(ic(i)),'LFP en el tiempo '])
        
    % Guardar imagen de la figura
    name_figure_save = ['Imagenes',path(inicio_new_dir:length(path)),C{ic(i)},' LFP en el tiempo'];
    saveas(fig_1,name_figure_save,'png');
    saveas(fig_1,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_1)   
    
    
    fig_3 = figure('units','normalized','outerposition',[0 0 1 1]);
    for q = 1:length(areas_actuales)
        
        subplot(2,4,q);
        eval(['histo_diff = histogram(diff(data_',int2str(canales_eval(areas_actuales(q))),'),200);']); %Se cambio a 200
        xlim([histo_diff.BinLimits]); ylim([0 25*10^4]);
        xlabel('Amplitud de la derivada'); ylabel('Cantidad de muestras');
        title([C(ic(i)),' Histograma de la derivada del LFP CH',int2str(canales_eval(areas_actuales(q)))])
    end
    name_figure_save = ['Imagenes',path(inicio_new_dir:length(path)),C{ic(i)},' Histograma de la derivada del LFP en el tiempo'];
    saveas(fig_3,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_3)
    
end

