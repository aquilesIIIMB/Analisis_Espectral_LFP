%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% View_LFP_Raw_Ref.m
fprintf('\nVisualizacion LFP\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graficar los LFP e Histogramas para evluar cual eliminar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.stage.extract_lfp 
    error('Falta el bloque de extraccion de LFP');
    
end

if ~registroLFP.stage.referencing
    fprintf('Visualizacion SIN referenciacion\n');

canales_eval = find(~[registroLFP.channel.removed]);
slash_system = foldername(length(foldername));

% indices de las mismas areas
[C,ia,ic] = unique({registroLFP.channel(canales_eval).area},'stable');

for m = 1:length(ia)  
    i = ia(m);

    areas_actuales = find(ic == ic(i));
    largo_areasActuales = length(areas_actuales);
    
    % Crear legend
    str_CH = char(ones(largo_areasActuales,1)*'Ch');
    str_num = int2str(canales_eval(areas_actuales)');
    str_numCH = strcat(str_CH,str_num);
    
    fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
    for q = 1:largo_areasActuales        
        % Se grafica cada LFP de un area en un mismo grafico
        plot(registroLFP.times.steps_m, -(1000*q)+registroLFP.channel(canales_eval(areas_actuales(q))).data_raw);
        hold on;       
                
    end
    
    % Lineas divisorias de cada fase 
    line([registroLFP.times.start_s/60 registroLFP.times.start_s/60], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.pre_m registroLFP.times.pre_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.start_on_m registroLFP.times.start_on_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.end_on_m registroLFP.times.end_on_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.post_m registroLFP.times.post_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.end_m registroLFP.times.end_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');

    xlim([0 registroLFP.times.end_m]);ylim([-(1000*largo_areasActuales)+min(registroLFP.channel(canales_eval(areas_actuales(largo_areasActuales))).data_raw)  -1000+max(registroLFP.channel(canales_eval(areas_actuales(1))).data_raw)])
    xlabel('Tiempo (minutos)'); ylabel('Amplitud')
    title([C(ic(i)),'LFP en bruto en el tiempo '])
    legend(str_numCH)
        
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'LFPs',slash_system,C{ic(i)},' LFP en bruto en el tiempo'];
    saveas(fig_2,name_figure_save,'png');
    saveas(fig_2,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_2)
    
    
    fig_3 = figure('units','normalized','outerposition',[0 0 1 1]);
    for q = 1:length(areas_actuales)
        
        subplot(2,4,q);
        histo_diff = histogram(diff(registroLFP.channel(canales_eval(areas_actuales(q))).data_raw),1000); %200 1000
        grid on
        xlim([histo_diff.BinLimits]); ylim([0 3*10^4]);
        xlabel('Amplitud de la derivada'); ylabel('Cantidad de muestras');
        title([C(ic(i)),' Derivada LFP Estandarizado CH',int2str(canales_eval(areas_actuales(q)))])
    end
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'LFPs',slash_system,C{ic(i)},' Histograma de la derivada del LFP estandarizado en el tiempo'];
    saveas(fig_3,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_3)
    
end 
   
else
    fprintf('Visualizacion CON referenciacion\n');
   
canales_eval = find(~[registroLFP.channel.removed]);
slash_system = foldername(length(foldername));

% indices de las mismas areas
[C,ia,ic] = unique({registroLFP.channel(canales_eval).area},'stable');

for m = 1:length(ia)  
    i = ia(m);

    areas_actuales = find(ic == ic(i));
    largo_areasActuales = length(areas_actuales);
    
    % Crear legend
    str_CH = char(ones(largo_areasActuales,1)*'Ch');
    str_num = int2str(canales_eval(areas_actuales)');
    str_numCH = strcat(str_CH,str_num);
    
    
    fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
    for q = 1:largo_areasActuales        
        % Se grafica cada LFP de un area en un mismo grafico
        plot(registroLFP.times.steps_m, -(1200*q)+registroLFP.channel(canales_eval(areas_actuales(q))).data_ref);
        hold on;        
                
    end
    
    for q = 1:largo_areasActuales
        linea_ref = refline([0 -(1200*q)+registroLFP.channel(canales_eval(areas_actuales(q))).threshold]); linea_ref.Color = 'r'; linea_ref.LineStyle = '--';
        hold on;
        linea_ref = refline([0 -(1200*q)-registroLFP.channel(canales_eval(areas_actuales(q))).threshold]); linea_ref.Color = 'r'; linea_ref.LineStyle = '--';
        hold on;
    end
    
    % Lineas divisorias de cada fase
    line([registroLFP.times.start_s/60 registroLFP.times.start_s/60], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.pre_m registroLFP.times.pre_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.start_on_m registroLFP.times.start_on_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.end_on_m registroLFP.times.end_on_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.post_m registroLFP.times.post_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.end_m registroLFP.times.end_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');

    xlim([0 registroLFP.times.end_m]);ylim([-(1200*largo_areasActuales)+min(registroLFP.channel(canales_eval(areas_actuales(largo_areasActuales))).data_ref)  -1200+max(registroLFP.channel(canales_eval(areas_actuales(1))).data_ref)]) %revisar
    xlabel('Tiempo (minutos)'); ylabel('Amplitud')
    title([C(ic(i)),'LFP referenciado con artefactos en el tiempo '])
    legend(str_numCH)
        
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'LFPs',slash_system,'Referenciado ',C{ic(i)},' LFP con artefactos en el tiempo'];
    saveas(fig_2,name_figure_save,'png');
    saveas(fig_2,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_2)
    

    fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
    for q = 1:largo_areasActuales
        
        % Se grafica cada LFP de un area en un mismo grafico
        plot(registroLFP.times.steps_m, -(20*q)+registroLFP.channel(canales_eval(areas_actuales(q))).data);
        hold on;
                
    end
    
    % Lineas divisorias de cada fase
    line([registroLFP.times.start_s/60 registroLFP.times.start_s/60], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.pre_m registroLFP.times.pre_m], get(gca, 'ylim'),'Color','black','LineWidth',1.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.start_on_m registroLFP.times.start_on_m], get(gca, 'ylim'),'Color','black','LineWidth',1.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.end_on_m registroLFP.times.end_on_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.post_m registroLFP.times.post_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');
    line([registroLFP.times.end_m registroLFP.times.end_m], get(gca, 'ylim'),'Color','black','LineWidth',1.25,'Marker','.','LineStyle',':');

    xlim([0 registroLFP.times.end_m]);ylim([-(20*largo_areasActuales)+min(registroLFP.channel(canales_eval(areas_actuales(largo_areasActuales))).data)  -20+max(registroLFP.channel(canales_eval(areas_actuales(1))).data)])
    xlabel('Tiempo (minutos)'); ylabel('Amplitud')
    title([C(ic(i)),'LFP referenciado, norm y sin artefactos en el tiempo '])
    legend(str_numCH)
        
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'LFPs',slash_system,'Referenciado ',C{ic(i)},' LFP norm y sin artefactos en el tiempo'];
    saveas(fig_1,name_figure_save,'png');
    saveas(fig_1,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_1)   
    
    
end
    
end

registroLFP.stage.view_lfp = 1;

% Eliminacion de variables no utilizadas
clear fig_1 fig_2 fig_3 C ia ic largo_areasActuales areas_actuales m q;
clear str_CH str_num str_numCH slash_system linea_ref histo_diff canales_eval;
clear i name_figure_save;

