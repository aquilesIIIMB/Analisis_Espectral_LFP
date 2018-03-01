function graph_motorcircuit(coherence, names_areas, path, titulo_1, titulo_2, z_etiqueta)

slash_backslash = find(path=='\' | path=='/');
inicio_new_dir1 = slash_backslash(length(slash_backslash)-3);
inicio_new_dir2 = slash_backslash(length(slash_backslash)-2);
foldername = path(inicio_new_dir2:length(path)); % /+375/arturo2_2017-06-02_12-58-57/
inicio_foldername = path(1:inicio_new_dir1); % /home/cmanalisis/Aquiles/Registros/
if ~exist(foldername, 'dir')
    mkdir(inicio_foldername,'Images');
    mkdir([inicio_foldername,'Images'],foldername);
end
slash_system = foldername(length(foldername));

% Colocar ancho de barras y color de acuerdo a la coherencia
%[sum_MSC_beta_parkinson, coupling_strength_beta_parkinson, delay_beta_parkinson] = coherence_measurements(registroLFP, [8, 30], [false, false, false], false, path);
%coherence = coupling_strength_beta_parkinson;
left_coherence = coherence(1:round(size(coherence,1)/2),:);
right_coherence = coherence(round(size(coherence,1)/2)+1:end,:);

% Maximo 7 areas
%names_areas = {'DLS','S1','SMA','M1','VPL'};
colora_areas = [[0 0.4470 0.7410];[0.8500 0.3250 0.0980];[0.9290 0.6940 0.1250];[0.4940 0.1840 0.5560];[0.4660 0.6740 0.1880];[0.3010 0.7450 0.9330];[0.6350 0.0780 0.1840]];
num_niveles = 20;
limites_colorbar = [0.1, 0.3];
range_value = linspace(limites_colorbar(1),limites_colorbar(2),num_niveles);
range_mag = linspace(1,40,num_niveles);

num_areas = length(names_areas);
num_sync = combntns([1:num_areas],2);
centro = [15, 15];
primer_pto = [10, 0];
pos_nodos = zeros(num_areas, 4);

for i = 1:num_areas
    x = primer_pto(1)*round(cos(-pi/4+(i-1)*2*pi/num_areas),2)-primer_pto(2)*round((i-1)*sin(-pi/4+2*pi/num_areas),2);
    y = primer_pto(1)*round(sin(-pi/4+(i-1)*2*pi/num_areas),2)+primer_pto(2)*round((i-1)*cos(-pi/4+2*pi/num_areas),2);

    x = x + centro(1) - 1.5;
    y = y + centro(2) - 1.5;
    
    pos_nodos(i,:) = [x, y, 3, 3];


end

for i = 1:size(coherence,2)
    if i == 1
        etapa = 'PRE';
    elseif i == 2
        etapa = 'ON';
    elseif i == 3
        etapa = 'POST';
    else
        etapa = int2str(i);
    end
    
    % left graph
    weigthed_left = left_coherence(:,i);
    
    fig_1 = figure('rend','painters','pos',[10 10 1000 900]);
    color_sync = colormap(jet(num_niveles));

    for j = 1:size(num_sync,1)
        [~, idx_color_actual] = min(abs(range_value-weigthed_left(j)));
        %line([pos_nodos(num_sync(j,1),1)+1.5,pos_nodos(num_sync(j,2),1)+1.5],[pos_nodos(num_sync(j,1),2)+1.5,pos_nodos(num_sync(j,2),2)+1.5],'LineWidth',range_mag(idx_color_actual),'Color',color_sync(idx_color_actual,:))
        line([pos_nodos(num_sync(j,1),1)+1.5,pos_nodos(num_sync(j,2),1)+1.5],[pos_nodos(num_sync(j,1),2)+1.5,pos_nodos(num_sync(j,2),2)+1.5],'LineWidth',20,'Color',color_sync(idx_color_actual,:))
        hold on
    end

    for k = 1:num_areas
        rectangle('Position',pos_nodos(k,:),'Curvature',[1 1],'EdgeColor','k','LineWidth',3,'FaceColor',colora_areas(k,:))
        text(pos_nodos(k,1)+1.5,pos_nodos(k,2)+1.5, char(names_areas(k)), 'HorizontalAlignment','center','Color',[1,1,0.9],'FontSize',18,'FontWeight','bold')
        hold on
    end

    c=colorbar('eastoutside');
    caxis([limites_colorbar(1) limites_colorbar(2)])    
    xlim([0 30])
    ylim([0 30])
    title(titulo_1, 'FontSize', 18)
    ylabel(c,[z_etiqueta,' in ',etapa,'-stim stage'], 'FontSize', 20)
    set(c,'fontsize',17)
    set(gca,'XTick',[]); % hides the ticks on x-axis
    set(gca,'YTick',[]); % hides the ticks on y-axis
    set(gca,'color','None'); % hides the white bckgrnd
    set(gca,'YColor','w'); % changes the color of y-axis to white
    set(gca,'XColor','w'); % changes the color of x-axis to white
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,char(strjoin(titulo_1)),' in (',int2str(i),')',etapa,'-stim stage'];
    saveas(fig_1,name_figure_save,'png');
    saveas(fig_1,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_1)
    
    % rigth graph
    weigthed_rigth = right_coherence(:,i);
    
    fig_2 = figure('rend','painters','pos',[10 10 1000 900]);
    color_sync = colormap(jet(num_niveles));

    for j = 1:size(num_sync,1)
        [~, idx_color_actual] = min(abs(range_value-weigthed_rigth(j)));
        %line([pos_nodos(num_sync(j,1),1)+1.5,pos_nodos(num_sync(j,2),1)+1.5],[pos_nodos(num_sync(j,1),2)+1.5,pos_nodos(num_sync(j,2),2)+1.5],'LineWidth',range_mag(idx_color_actual),'Color',color_sync(idx_color_actual,:))
        line([pos_nodos(num_sync(j,1),1)+1.5,pos_nodos(num_sync(j,2),1)+1.5],[pos_nodos(num_sync(j,1),2)+1.5,pos_nodos(num_sync(j,2),2)+1.5],'LineWidth',20,'Color',color_sync(idx_color_actual,:))
        hold on
    end

    for k = 1:num_areas
        rectangle('Position',pos_nodos(k,:),'Curvature',[1 1],'EdgeColor','k','LineWidth',3,'FaceColor',colora_areas(k,:))
        text(pos_nodos(k,1)+1.5,pos_nodos(k,2)+1.5, char(names_areas(k)), 'HorizontalAlignment','center','Color',[1,1,0.9],'FontSize',18,'FontWeight','bold')
        hold on
    end
    
    c=colorbar('eastoutside');
    caxis([limites_colorbar(1) limites_colorbar(2)])
    xlim([0 30])
    ylim([0 30])
    title(titulo_2, 'FontSize', 18)
    ylabel(c,[z_etiqueta,' in ',etapa,'-stim stage'], 'FontSize', 20)
    set(c,'fontsize',17)
    set(gca,'XTick',[]); % hides the ticks on x-axis
    set(gca,'YTick',[]); % hides the ticks on y-axis
    set(gca,'color','None'); % hides the white bckgrnd
    set(gca,'YColor','w'); % changes the color of y-axis to white
    set(gca,'XColor','w'); % changes the color of x-axis to white
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,char(strjoin(titulo_2)),' in (',int2str(i),')',etapa,'-stim stage'];
    saveas(fig_2,name_figure_save,'png');
    saveas(fig_2,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_2)

end



end

