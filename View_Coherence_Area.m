%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% View_Coherence_Area.m
fprintf('\nVisualizacion de la Coherencia\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.analysis_stages.coherence_area 
    error('Falta el bloque de analisis de coherencia para cada area');
    
end

canales_eval = find(~[registroLFP.channel.removed]);
slash_system = foldername(length(foldername));

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;
       
azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];

% Tomar las areas que hay, si hay una sola, no ejecutar
%% Calculos para el analisis del promedio de las Areas
[C,ia,ic] = unique({registroLFP.channel(canales_eval).area},'stable');
num_areas_izq = 0;
num_areas_der = 0;

for k = 1:length(C)
    area_actual = C{k};
    hemisferio = area_actual(end);
    if strcmp(hemisferio,'L')
        num_areas_izq = num_areas_izq + 1;
    elseif strcmp(hemisferio,'R')
        num_areas_der = num_areas_der + 1;
    end
end

% Analisis de la Coherencia en el Hemisferio Izquierdo
p = 2;
for i=1:num_areas_izq-1
    % Coherencia
    for j = num_areas_izq:-1:p
        
        C = registroLFP.average_sync{i,j}.coherenciogram.mag.data_raw;
        f = registroLFP.average_sync{i,j}.coherenciogram.frequency;
        t = registroLFP.average_sync{i,j}.coherenciogram.time;

        Coherence_pre_mean = registroLFP.average_sync{i,j}.coherence.pre.data;
        Coherence_on_mean = registroLFP.average_sync{i,j}.coherence.on.data;
        Coherence_post_mean = registroLFP.average_sync{i,j}.coherence.post.data;

        C_norm = registroLFP.average_sync{i,j}.coherenciogram.mag.data;   
        
        
        fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
        imagesc(t,f,C'); 
        cmap = colormap(parula(40));
        axis xy
        ylabel('Frequency [Hz]', 'FontSize', 24)
        xlabel('Time [s]', 'FontSize', 24)
        set(gca,'fontsize',20)
        ylim([1 100])
        c=colorbar('southoutside');
        caxis([0.2 0.8])
        hold on
        line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        title(['Coherenciogram multitaper between ','areas ',registroLFP.average_sync{i,j}.names{1},' & ',registroLFP.average_sync{i,j}.names{2}], 'FontSize', 24)
        ylabel(c,'Coherence', 'FontSize', 17)
        set(c,'fontsize',17)       
        name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Coherenciograms',slash_system,'Areas ',registroLFP.average_sync{i,j}.names{1},' & ',registroLFP.average_sync{i,j}.names{2},' coherenciograma multitaper'];
        saveas(fig_1,name_figure_save,'png');
        %waitforbuttonpress;
        close(fig_1)
        
        fig_3 = figure('units','normalized','outerposition',[0 0 1 1]);
        imagesc(t,f,C_norm'); 
        cmap = colormap(parula(40));
        axis xy
        ylabel('Frequency [Hz]', 'FontSize', 24)
        xlabel('Time [s]', 'FontSize', 24)
        set(gca,'fontsize',20)
        ylim([1 100])
        c=colorbar('southoutside');
        caxis([-1 1])
        hold on
        line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        title(['Normalized coherenciogram multitaper between ','areas ',registroLFP.average_sync{i,j}.names{1},' & ',registroLFP.average_sync{i,j}.names{2}], 'FontSize', 24)
        ylabel(c,'Normalized Coherence', 'FontSize', 17)
        set(c,'fontsize',17)       
        name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Coherenciograms',slash_system,'Areas ',registroLFP.average_sync{i,j}.names{1},' & ',registroLFP.average_sync{i,j}.names{2},' coherenciograma normalizada multitaper'];
        saveas(fig_3,name_figure_save,'png');
        %waitforbuttonpress;
        close(fig_3)
        
        fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
        plot(f,Coherence_pre_mean,'Color',azul,'LineWidth',2.0)
        hold on
        plot(f,Coherence_on_mean,'Color',rojo,'LineWidth',2.0)
        plot(f,Coherence_post_mean,'Color',verde,'LineWidth',2.0)
        grid on
        xlim([0 100])
        ylim([0.2 0.8])
        set(gca,'fontsize',20)
        ylabel('Coherence', 'FontSize', 24)
        xlabel('Frequency [Hz]', 'FontSize', 24)
        lgd = legend('pre-stim','on-stim','post-stim');
        lgd.FontSize = 20;
        title(['Coherence between ','areas ',registroLFP.average_sync{i,j}.names{1},' & ',registroLFP.average_sync{i,j}.names{2}], 'FontSize', 24)         
        name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Coherenciograms',slash_system,'Areas ',registroLFP.average_sync{i,j}.names{1},' & ',registroLFP.average_sync{i,j}.names{2},' promedio coherence'];
        saveas(fig_5,name_figure_save,'png');
        %waitforbuttonpress;
        close(fig_5)   

    end
    p=p+1;
end


% Analisis de la Coherencia en el Hemisferio Derecho
p = 2;
for i=1:num_areas_der-1
    % Coherencia
    for j = num_areas_der:-1:p
    
        C = registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.mag.data_raw;
        f = registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.frequency;
        t = registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.time;

        Coherence_pre_mean = registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherence.pre.data;
        Coherence_on_mean = registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherence.on.data;
        Coherence_post_mean = registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherence.post.data;

        C_norm = registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.coherenciogram.mag.data;
        

        fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
        imagesc(t,f,C'); 
        cmap = colormap(parula(40));
        axis xy
        ylabel('Frequency [Hz]', 'FontSize', 24)
        xlabel('Time [s]', 'FontSize', 24)
        set(gca,'fontsize',20)
        ylim([1 100])
        c=colorbar('southoutside');
        caxis([0.2 0.8])
        hold on
        line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        title(['Coherenciogram multitaper between ','areas ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{1},' & ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{2}], 'FontSize', 24)
        ylabel(c,'Coherence', 'FontSize', 17)
        set(c,'fontsize',17)
        name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Coherenciograms',slash_system,'Areas ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{1},' & ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{2},' coherenciograma multitaper'];
        saveas(fig_2,name_figure_save,'png');
        %waitforbuttonpress;
        close(fig_2)
        
        fig_4 = figure('units','normalized','outerposition',[0 0 1 1]);
        imagesc(t,f,C_norm'); 
        cmap = colormap(parula(40));
        axis xy
        ylabel('Frequency [Hz]', 'FontSize', 24)
        xlabel('Time [s]', 'FontSize', 24)
        set(gca,'fontsize',20)
        ylim([1 100])
        c=colorbar('southoutside');
        caxis([-1 1])
        hold on
        line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
        title(['Normalized coherenciogram multitaper between ','areas ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{1},' & ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{2}], 'FontSize', 24)
        ylabel(c,'Normalized Coherence', 'FontSize', 17)
        set(c,'fontsize',17)
        name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Coherenciograms',slash_system,'Areas ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{1},' & ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{2},' coherenciograma normalizada multitaper'];
        saveas(fig_4,name_figure_save,'png');
        %waitforbuttonpress;
        close(fig_4)
        
        fig_6 = figure('units','normalized','outerposition',[0 0 1 1]);
        plot(f,Coherence_pre_mean,'Color',azul,'LineWidth',2.0)
        hold on
        plot(f,Coherence_on_mean,'Color',rojo,'LineWidth',2.0)
        plot(f,Coherence_post_mean,'Color',verde,'LineWidth',2.0)
        grid on
        xlim([0 100])
        ylim([0.2 0.8])
        set(gca,'fontsize',20)
        ylabel('Coherence', 'FontSize', 24)
        xlabel('Frequency [Hz]', 'FontSize', 24)
        lgd = legend('pre-stim','on-stim','post-stim');
        lgd.FontSize = 20;
        title(['Coherence between ','areas ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{1},' & ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{2}], 'FontSize', 24)
        name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Coherenciograms',slash_system,'Areas ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{1},' & ',registroLFP.average_sync{i+num_areas_izq,j+num_areas_izq}.names{2},' promedio coherence'];
        saveas(fig_6,name_figure_save,'png');
        %waitforbuttonpress;
        close(fig_6)
        
    end
    p=p+1;
end


% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP path name_registro foldername inicio_foldername
