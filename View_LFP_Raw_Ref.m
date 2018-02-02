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
        plot(registroLFP.times.steps_m, -(10*q)+registroLFP.channel(canales_eval(areas_actuales(q))).data_raw);
        hold on;       
                
    end
    
    % Lineas divisorias de cada fase 
    %line([registroLFP.times.start_s/60 registroLFP.times.start_s/60], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.pre_m registroLFP.times.pre_m], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.start_on_m registroLFP.times.start_on_m], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.end_on_m registroLFP.times.end_on_m], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.post_m registroLFP.times.post_m], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    %line([registroLFP.times.end_m registroLFP.times.end_m], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');

    set(gca,'fontsize',20)
    xlim([0 registroLFP.times.end_m]);ylim([-(10*largo_areasActuales)+min(registroLFP.channel(canales_eval(areas_actuales(largo_areasActuales))).data_raw)  -10+max(registroLFP.channel(canales_eval(areas_actuales(1))).data_raw)])
    xlabel('Time [min]', 'FontSize', 24); ylabel('Amplitude [u.a.]', 'FontSize', 24)
    title(['(', C{ic(i)},') Raw LFP'], 'FontSize', 24)
    yticks(flip(1:size(str_numCH,1))*-10)
    yticklabels(flip(str_numCH,1))
    %lgd = legend(str_numCH);
    %lgd.FontSize = 20;
    %lgd.Orientation = 'horizontal';
    %lgd.Location    = 'southOutside';
    %lgd.Box = 'off';
        
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
        xlabel('Derivative Amplitude [u.a.]'); ylabel('Number of elements');
        title(['(', C{ic(i)}, ') Derivative of the LFP CH',int2str(canales_eval(areas_actuales(q)))])
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
    %for q = 1:largo_areasActuales        
        % Se grafica cada LFP de un area en un mismo grafico
    %plot(registroLFP.times.steps_m, -(10*q)+registroLFP.channel(canales_eval(areas_actuales(q))).data_ref);
    plot(registroLFP.times.steps_m, registroLFP.area(m).data_raw);
    hold on;        
                
    %end
    
    %for q = 1:largo_areasActuales
    plot([0 registroLFP.times.phase_range_m(1)], [registroLFP.area(m).threshold(1) registroLFP.area(m).threshold(1)],'r--','LineWidth',2.0);
    hold on;
    plot([registroLFP.times.phase_range_m(1) registroLFP.times.phase_range_m(1)*2+1], [registroLFP.area(m).threshold(2) registroLFP.area(m).threshold(2)],'r--','LineWidth',2.0); 
    hold on;
    plot([registroLFP.times.phase_range_m(1)*2+1 registroLFP.times.phase_range_m(1)*3+1], [registroLFP.area(m).threshold(3) registroLFP.area(m).threshold(3)],'r--','LineWidth',2.0); 
    hold on;
    plot([0 registroLFP.times.phase_range_m(1)], [-registroLFP.area(m).threshold(1) -registroLFP.area(m).threshold(1)],'r--','LineWidth',2.0); 
    hold on;
    plot([registroLFP.times.phase_range_m(1) registroLFP.times.phase_range_m(1)*2+1], [-registroLFP.area(m).threshold(2) -registroLFP.area(m).threshold(2)],'r--','LineWidth',2.0); 
    hold on;
    plot([registroLFP.times.phase_range_m(1)*2+1 registroLFP.times.phase_range_m(1)*3+1], [-registroLFP.area(m).threshold(3) -registroLFP.area(m).threshold(3)],'r--','LineWidth',2.0); 
    hold on;
    %end
    
    % Lineas divisorias de cada fase
    %line([registroLFP.times.start_s/60 registroLFP.times.start_s/60], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.pre_m registroLFP.times.pre_m], [-registroLFP.area(m).threshold(1)*2 registroLFP.area(m).threshold(1)*2],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.start_on_m registroLFP.times.start_on_m], [-registroLFP.area(m).threshold(1)*2 registroLFP.area(m).threshold(1)*2],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.end_on_m registroLFP.times.end_on_m], [-registroLFP.area(m).threshold(1)*2 registroLFP.area(m).threshold(1)*2],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.post_m registroLFP.times.post_m], [-registroLFP.area(m).threshold(1)*2 registroLFP.area(m).threshold(1)*2],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    %line([registroLFP.times.end_m registroLFP.times.end_m], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');

    set(gca,'fontsize',20)
    xlim([0 registroLFP.times.end_m]);ylim([-registroLFP.area(m).threshold(1)*2 registroLFP.area(m).threshold(1)*2]);%ylim([-(10*largo_areasActuales)+min(registroLFP.channel(canales_eval(areas_actuales(largo_areasActuales))).data_ref)  -10+max(registroLFP.channel(canales_eval(areas_actuales(1))).data_ref)]) %revisar
    xlabel('Time [min]', 'FontSize', 24); ylabel('Amplitude [u.a.]', 'FontSize', 24)
    title(['(', C{ic(i)},') LFP referenced with artifacts '], 'FontSize', 24)
    %yticks(flip(1:size(str_numCH,1))*-10)
    %yticklabels(flip(str_numCH,1))
    %lgd = legend(str_numCH);
    %lgd.FontSize = 20;
    %lgd.Orientation = 'horizontal';
    %lgd.Location    = 'southOutside';
        
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Imagenes',foldername,slash_system,'LFPs',slash_system,'Referenciado ',C{ic(i)},' LFP con artefactos en el tiempo'];
    saveas(fig_2,name_figure_save,'png');
    saveas(fig_2,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_2)
    

    fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
    %for q = 1:largo_areasActuales
        
        % Se grafica cada LFP de un area en un mismo grafico
        %plot(registroLFP.times.steps_m, -(20*q)+registroLFP.channel(canales_eval(areas_actuales(q))).data);
    plot(registroLFP.times.steps_m, registroLFP.area(m).data);
    hold on;
                
    %end
    
    % Lineas divisorias de cada fase
    %line([registroLFP.times.start_s/60 registroLFP.times.start_s/60], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.pre_m registroLFP.times.pre_m], [-registroLFP.area(m).threshold(1)*2 registroLFP.area(m).threshold(1)*2],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.start_on_m registroLFP.times.start_on_m], [-registroLFP.area(m).threshold(1)*2 registroLFP.area(m).threshold(1)*2], 'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.end_on_m registroLFP.times.end_on_m], [-registroLFP.area(m).threshold(1)*2 registroLFP.area(m).threshold(1)*2], 'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    line([registroLFP.times.post_m registroLFP.times.post_m], [-registroLFP.area(m).threshold(1)*2 registroLFP.area(m).threshold(1)*2],'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');
    %line([registroLFP.times.end_m registroLFP.times.end_m], get(gca, 'ylim'),'Color','black','LineWidth',2.0,'Marker','.','LineStyle',':');

    set(gca,'fontsize',20)
    %xlim([0 registroLFP.times.end_m]);ylim([-(20*largo_areasActuales)+min(registroLFP.channel(canales_eval(areas_actuales(largo_areasActuales))).data)  -20+max(registroLFP.channel(canales_eval(areas_actuales(1))).data)])
    xlim([0 registroLFP.times.end_m]);ylim([-registroLFP.area(m).threshold(1)*2 registroLFP.area(m).threshold(1)*2]);%ylim([-(20*largo_areasActuales)+min(registroLFP.channel(canales_eval(areas_actuales(largo_areasActuales))).data)  -20+max(registroLFP.channel(canales_eval(areas_actuales(1))).data)])
    xlabel('Time [min]', 'FontSize', 24); ylabel('Amplitude [u.a.]', 'FontSize', 24)
    title(['(', C{ic(i)},') LFP referenced, norm & without artifacts '], 'FontSize', 24)
    %yticks(flip(1:size(str_numCH,1))*-20)
    %yticklabels(flip(str_numCH,1))
    %lgd = legend(str_numCH);
    %lgd.FontSize = 20;
    %lgd.Orientation = 'horizontal';
    %lgd.Location    = 'southOutside';
        
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

