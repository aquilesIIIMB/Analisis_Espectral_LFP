function [sum_MSC_band, coupling_strength_band, delay_band] = coherence_measurements(registroLFP, banda_eval, visualization, save_image, path)
    

    banda_actual = 'None';
    
    if banda_eval == [1, 4]
        banda_actual = 'delta';
    elseif banda_eval == [4, 8]
        banda_actual = 'theta';
    elseif banda_eval == [8, 12]
        banda_actual = 'alpha';
    elseif banda_eval == [12, 20]
        banda_actual = 'beta_low';
    elseif banda_eval == [20, 30]
        banda_actual = 'beta_high';
    elseif banda_eval == [12, 30]
        banda_actual = 'beta';
    elseif banda_eval == [8, 30]
        banda_actual = 'beta_parkinson';
    elseif banda_eval == [30, 60]
        banda_actual = 'gamma_low';
    elseif banda_eval == [60, 90]
        banda_actual = 'gamma_high';
    elseif banda_eval == [30, 90]
        banda_actual = 'gamma';
    end
    
    names_areas = {registroLFP.areas.name};
    % Eliminar la ultima letra de las areas (el hemisferio)
    names_areas = cellfun(@(S) S(1:end-1), names_areas, 'Uniform', 0);
    names_areas = unique(names_areas,'stable');
    length_areas = length(names_areas);
    num_sync = combntns([1:length_areas],2);
    length_sync = size(num_sync,1);

    sum_MSC_band = zeros(2*length_sync,3);
    coupling_strength_band = zeros(2*length_sync,3);
    delay_band = zeros(2*length_sync,3);
    areas = cell(2*length_sync,1);
    delta = 1:100:10^6;
    delta = delta(1:round(length(delta)/2));
    delta = delta./10^6;
       
    azul = [0 0.4470 0.7410];
    rojo = [0.85, 0.325, 0.098];
    verde = [0.466, 0.674, 0.188];
    
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
    
    [C,~,~] = unique({registroLFP.areas.name},'stable');
    idx_areas_izq = [];
    idx_areas_der = [];
    
    for k = 1:length(C)
        area_actual = C{k};
        hemisferio = area_actual(end);
        if strcmp(hemisferio,'L')
            idx_areas_izq = [idx_areas_izq, k];
        elseif strcmp(hemisferio,'R')
            idx_areas_der = [idx_areas_der, k];
        end
    end
    
    if idx_areas_izq(1) < idx_areas_der(1)
        idx_inicio = idx_areas_izq;
        idx_final = idx_areas_der;
    else
        idx_inicio = idx_areas_der;
        idx_final = idx_areas_izq;
    end
    
    % Sum MSC

    % Analisis de la Coherencia
    p = 2;
    for i=1:length(idx_inicio)-1
        % Coherencia
        for j = length(idx_inicio):-1:p
            
            area_actual = registroLFP.average_sync{i,j}.areas;
            
            f = registroLFP.average_sync{i,j}.coherenciogram.frequency;

            Coherence_pre_mean = registroLFP.average_sync{i,j}.coherence.pre.^2;
            Coherence_on_mean = registroLFP.average_sync{i,j}.coherence.on.^2;
            Coherence_post_mean = registroLFP.average_sync{i,j}.coherence.post.^2;
        
            sum_MSC_pre = sum(Coherence_pre_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            sum_MSC_on = sum(Coherence_on_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            sum_MSC_post = sum(Coherence_post_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            
            idx_comb = find(num_sync(:,1)==i & num_sync(:,2)==j);
            areas{idx_comb} = [area_actual{1}(1:end-1),'&',area_actual{2}(1:end-1)];
            sum_MSC_band(idx_comb,:) = [sum_MSC_pre,sum_MSC_on,sum_MSC_post];
            
            if visualization(1)
                figure;
                plot(f, Coherence_pre_mean)
                hold on
                plot(f, Coherence_on_mean)
                hold on
                plot(f, Coherence_post_mean)
                ylim([0 0.6])
                title([area_actual{1}(1:end-1),' & ',area_actual{2}(1:end-1)])

                fprintf('%s\n', [area_actual{1}(1:end-1),' & ',area_actual{2}(1:end-1)])
                fprintf('Porcentaje de banda en pre: %.2f \n', sum_MSC_pre)
                fprintf('Porcentaje de banda en on: %.2f \n', sum_MSC_on)
                fprintf('Porcentaje de banda en post: %.2f \n\n', sum_MSC_post)
            end
            
        end
        p=p+1;
    end
    
    % Analisis de la Coherencia
    p = 2;
    for i=1:length(idx_final)-1
        % Coherencia
        for j = length(idx_final):-1:p
            
            area_actual = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.areas;
            
            f = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherenciogram.frequency;

            Coherence_pre_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.pre.^2;
            Coherence_on_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.on.^2;
            Coherence_post_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.post.^2;
        
            sum_MSC_pre = sum(Coherence_pre_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            sum_MSC_on = sum(Coherence_on_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            sum_MSC_post = sum(Coherence_post_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            
            idx_comb = find(num_sync(:,1)==i & num_sync(:,2)==j)+length_sync;
            areas{idx_comb} = [area_actual{1}(1:end-1),'&',area_actual{2}(1:end-1)];
            sum_MSC_band(idx_comb,:) = [sum_MSC_pre,sum_MSC_on,sum_MSC_post];
            
            if visualization(1)
                figure;
                plot(f, Coherence_pre_mean)
                hold on
                plot(f, Coherence_on_mean)
                hold on
                plot(f, Coherence_post_mean)
                ylim([0 0.6])
                title([area_actual{1}(1:end-1),' & ',area_actual{2}(1:end-1)])

                fprintf('%s\n', [area_actual{1}(1:end-1),' & ',area_actual{2}(1:end-1)])
                fprintf('Porcentaje de banda en pre: %.2f \n', sum_MSC_pre)
                fprintf('Porcentaje de banda en on: %.2f \n', sum_MSC_on)
                fprintf('Porcentaje de banda en post: %.2f \n\n', sum_MSC_post)
            end
            
        end
        p=p+1;
    end
        

    if visualization(1)
        disp(' ')
        mitad_largo = round(size(sum_MSC_band,1)/2);  

        if mitad_largo == 1
            fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', sum_MSC_band(1:mitad_largo,:))
            fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n', sum_MSC_band(mitad_largo+1:end,:))  
        
            y_max = max([max(sum_MSC_band(1:mitad_largo,:)) max(sum_MSC_band(mitad_largo+1:end,:))]);
            y_min = min([min(sum_MSC_band(1:mitad_largo,:)) min(sum_MSC_band(mitad_largo+1:end,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            bar_inifin = bar(sum_MSC_band,'grouped');
            bar_inifin(1).FaceColor = azul; bar_inifin(2).FaceColor = rojo; bar_inifin(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            xlim([xt(1)-0.5, xt(end)+0.5])
            title(['Sum MSC in band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),']'])
        else
            fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', mean(sum_MSC_band(1:mitad_largo,:)))
            fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n',mean(sum_MSC_band(mitad_largo+1:end,:)))  
        
            y_max = max([max(sum_MSC_band(1:mitad_largo,:)) max(sum_MSC_band(mitad_largo+1:end,:))]);
            y_min = min([min(sum_MSC_band(1:mitad_largo,:)) min(sum_MSC_band(mitad_largo+1:end,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar_ini = bar(sum_MSC_band(1:mitad_largo,:),'grouped');
            bar_ini(1).FaceColor = azul; bar_ini(2).FaceColor = rojo; bar_ini(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(1:mitad_largo)))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            xlim([xt(1)-0.5, xt(end)+0.5])
            title(['Sum MSC in band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),']'])
            subplot(2,1,2)
            bar_fin = bar(sum_MSC_band(mitad_largo+1:end,:),'grouped');
            bar_fin(1).FaceColor = azul; bar_fin(2).FaceColor = rojo; bar_fin(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(mitad_largo+1:end))) 
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            xlim([xt(1)-0.5, xt(end)+0.5])
        end
    end
    
    % Coupling Strength
    delta_f = 1;

    % Analisis de la Coherencia
    p = 2;
    for i=1:length(idx_inicio)-1
        % Coherencia
        for j = length(idx_inicio):-1:p
            
            area_actual = registroLFP.average_sync{i,j}.areas;
                        
            f = registroLFP.average_sync{i,j}.coherenciogram.frequency;
            f_band = f(f>=banda_eval(1) & f<=banda_eval(2));
            
            Coherence_pre_mean = registroLFP.average_sync{i,j}.coherence.pre.^2;
            Coherence_on_mean = registroLFP.average_sync{i,j}.coherence.on.^2;
            Coherence_post_mean = registroLFP.average_sync{i,j}.coherence.post.^2;
        
            [max_pre_band,I_pre] = max(Coherence_pre_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            [max_on_band,I_on] = max(Coherence_on_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            [max_post_band,I_post] = max(Coherence_post_mean(f>=banda_eval(1) & f<=banda_eval(2)));

            Coherence_pre_mean_band = Coherence_pre_mean(f>=f_band(I_pre)-delta_f & f<=f_band(I_pre)+delta_f);
            Coherence_on_mean_band = Coherence_on_mean(f>=f_band(I_on)-delta_f & f<=f_band(I_on)+delta_f);
            Coherence_post_mean_band = Coherence_post_mean(f>=f_band(I_post)-delta_f & f<=f_band(I_post)+delta_f);
            
            coupling_strength_pre = sum(Coherence_pre_mean_band)./(2*delta_f);
            coupling_strength_on = sum(Coherence_on_mean_band)./(2*delta_f);
            coupling_strength_post = sum(Coherence_post_mean_band)./(2*delta_f);
            
            % Normalizacion con el maximo
            coupling_strength_pre = coupling_strength_pre./(sum(Coherence_pre_mean_band.*0+1)./(2*delta_f));
            coupling_strength_on = coupling_strength_on./(sum(Coherence_on_mean_band.*0+1)./(2*delta_f));
            coupling_strength_post = coupling_strength_post./(sum(Coherence_post_mean_band.*0+1)./(2*delta_f));
            
            idx_comb = find(num_sync(:,1)==i & num_sync(:,2)==j);
            coupling_strength_band(idx_comb,:) = [coupling_strength_pre,coupling_strength_on,coupling_strength_post];
            
            if visualization(2)
                figure;
                plot(f(f>=f_band(I_pre)-delta_f & f<=f_band(I_pre)+delta_f), Coherence_pre_mean_band,'LineWidth',3.5)
                hold on
                plot(f_band(I_pre), max_pre_band, 'k*')
                hold on
                plot(f(f>=f_band(I_on)-delta_f & f<=f_band(I_on)+delta_f), Coherence_on_mean_band,'LineWidth',3.5)
                hold on
                plot(f_band(I_on), max_on_band, 'k*')
                hold on
                plot(f(f>=f_band(I_post)-delta_f & f<=f_band(I_post)+delta_f), Coherence_post_mean_band,'LineWidth',3.5)
                hold on
                plot(f_band(I_post), max_post_band, 'k*')
                ylim([0 0.9])
                title([area_actual{1},' & ',area_actual{2}])

                fprintf('%s\n', [area_actual{1},' & ',area_actual{2}])
                fprintf('Porcentaje de banda en pre: %.2f \n', coupling_strength_pre)
                fprintf('Porcentaje de banda en on: %.2f \n', coupling_strength_on)
                fprintf('Porcentaje de banda en post: %.2f \n\n', coupling_strength_post)
            end
            
        end
        p=p+1;
    end
    
    % Analisis de la Coherencia
    p = 2;
    for i=1:length(idx_final)-1
        % Coherencia
        for j = length(idx_final):-1:p
            
            area_actual = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.areas;
            
            f = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherenciogram.frequency;
            f_band = f(f>=banda_eval(1) & f<=banda_eval(2));
            
            Coherence_pre_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.pre.^2;
            Coherence_on_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.on.^2;
            Coherence_post_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.post.^2;
        
            [max_pre_band,I_pre] = max(Coherence_pre_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            [max_on_band,I_on] = max(Coherence_on_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            [max_post_band,I_post] = max(Coherence_post_mean(f>=banda_eval(1) & f<=banda_eval(2)));

            Coherence_pre_mean_band = Coherence_pre_mean(f>=f_band(I_pre)-delta_f & f<=f_band(I_pre)+delta_f);
            Coherence_on_mean_band = Coherence_on_mean(f>=f_band(I_on)-delta_f & f<=f_band(I_on)+delta_f);
            Coherence_post_mean_band = Coherence_post_mean(f>=f_band(I_post)-delta_f & f<=f_band(I_post)+delta_f);
            
            coupling_strength_pre = sum(Coherence_pre_mean_band)./(2*delta_f);
            coupling_strength_on = sum(Coherence_on_mean_band)./(2*delta_f);
            coupling_strength_post = sum(Coherence_post_mean_band)./(2*delta_f);
            
            % Normalizacion con el maximo
            coupling_strength_pre = coupling_strength_pre./(sum(Coherence_pre_mean_band.*0+1)./(2*delta_f));
            coupling_strength_on = coupling_strength_on./(sum(Coherence_on_mean_band.*0+1)./(2*delta_f));
            coupling_strength_post = coupling_strength_post./(sum(Coherence_post_mean_band.*0+1)./(2*delta_f));
            
            idx_comb = find(num_sync(:,1)==i & num_sync(:,2)==j)+length_sync;
            coupling_strength_band(idx_comb,:) = [coupling_strength_pre,coupling_strength_on,coupling_strength_post];
            
            if visualization(2)
                figure;
                plot(f(f>=f_band(I_pre)-delta_f & f<=f_band(I_pre)+delta_f), Coherence_pre_mean_band,'LineWidth',3.5)
                hold on
                plot(f_band(I_pre), max_pre_band, 'k*')
                hold on
                plot(f(f>=f_band(I_on)-delta_f & f<=f_band(I_on)+delta_f), Coherence_on_mean_band,'LineWidth',3.5)
                hold on
                plot(f_band(I_on), max_on_band, 'k*')
                hold on
                plot(f(f>=f_band(I_post)-delta_f & f<=f_band(I_post)+delta_f), Coherence_post_mean_band,'LineWidth',3.5)
                hold on
                plot(f_band(I_post), max_post_band, 'k*')
                ylim([0 0.9])
                title([area_actual{1},' & ',area_actual{2}])

                fprintf('%s\n', [area_actual{1},' & ',area_actual{2}])
                fprintf('Porcentaje de banda en pre: %.2f \n', coupling_strength_pre)
                fprintf('Porcentaje de banda en on: %.2f \n', coupling_strength_on)
                fprintf('Porcentaje de banda en post: %.2f \n\n', coupling_strength_post)
            end
            
        end
        p=p+1;
    end
        

    if visualization(2)
        disp(' ')
        mitad_largo = round(size(coupling_strength_band,1)/2);  

        if mitad_largo == 1
            fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', coupling_strength_band(1:mitad_largo,:))
            fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n', coupling_strength_band(mitad_largo+1:end,:)) 
            
            y_max = max([max(coupling_strength_band(1:mitad_largo,:)) max(coupling_strength_band(mitad_largo+1:end,:))]);
            y_min = min([min(coupling_strength_band(1:mitad_largo,:)) min(coupling_strength_band(mitad_largo+1:end,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            bar_inifin = bar(coupling_strength_band,'grouped');
            bar_inifin(1).FaceColor = azul; bar_inifin(2).FaceColor = rojo; bar_inifin(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            xlim([xt(1)-0.5, xt(end)+0.5])
            title(['Coupling Strength in band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),']'])

        else 
            fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', mean(coupling_strength_band(1:mitad_largo,:)))
            fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n',mean(coupling_strength_band(mitad_largo+1:end,:)))  
        
            y_max = max([max(coupling_strength_band(1:mitad_largo,:)) max(coupling_strength_band(mitad_largo+1:end,:))]);
            y_min = min([min(coupling_strength_band(1:mitad_largo,:)) min(coupling_strength_band(mitad_largo+1:end,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar_ini = bar(coupling_strength_band(1:mitad_largo,:),'grouped');
            bar_ini(1).FaceColor = azul; bar_ini(2).FaceColor = rojo; bar_ini(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(1:mitad_largo)))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            xlim([xt(1)-0.5, xt(end)+0.5])
            title(['Coupling Strength in band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),']'])
            subplot(2,1,2)
            bar_fin = bar(coupling_strength_band(mitad_largo+1:end,:),'grouped');
            bar_fin(1).FaceColor = azul; bar_fin(2).FaceColor = rojo; bar_fin(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(mitad_largo+1:end))) 
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            xlim([xt(1)-0.5, xt(end)+0.5])
        end
    end
            
    if save_image
        disp(' ')
        mitad_largo = round(size(coupling_strength_band,1)/2);  

        if mitad_largo == 1                    
            fig_31 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_inj = bar(coupling_strength_band,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas))
            lgd = legend([bar_inj(1) bar_inj(2) bar_inj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_inj(1).FaceColor = azul; bar_inj(2).FaceColor = rojo; bar_inj(3).FaceColor = verde;
            grid on
            ylim([0 0.9])
            xlim([xt(1)-0.5, xt(end)+0.5])
            ylabel('Coupling Strength', 'FontSize', 24)
            set(gca,'fontsize',15)
            title(['Coupling Strength of lefth and rigth hemisphere in ',banda_actual,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Coupling Strength in band ',banda_actual,' of lefth and rigth hemisphere'];
            saveas(fig_31,name_figure_save,'png');
            saveas(fig_31,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_31)
            
        else
            fig_31 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_inj = bar(coupling_strength_band(1:mitad_largo,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(1:mitad_largo)))
            lgd = legend([bar_inj(1) bar_inj(2) bar_inj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_inj(1).FaceColor = azul; bar_inj(2).FaceColor = rojo; bar_inj(3).FaceColor = verde;
            grid on
            ylim([0 0.9])
            xlim([xt(1)-0.5, xt(end)+0.5])
            ylabel('Coupling Strength', 'FontSize', 24)
            set(gca,'fontsize',15)
            title(['Coupling Strength of left hemisphere in ',banda_actual,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Coupling Strength in band ',banda_actual,' of lefth hemisphere'];
            saveas(fig_31,name_figure_save,'png');
            saveas(fig_31,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_31)

            fig_32 = figure('units','normalized','outerposition',[0 0 1 1]);
            bar_uninj = bar(coupling_strength_band(mitad_largo+1:end,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(mitad_largo+1:end))) 
            lgd = legend([bar_uninj(1) bar_uninj(2) bar_uninj(3)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
            lgd.FontSize = 20;
            bar_uninj(1).FaceColor = azul; bar_uninj(2).FaceColor = rojo; bar_uninj(3).FaceColor = verde;
            grid on
            ylim([0 0.9])
            xlim([xt(1)-0.5, xt(end)+0.5])
            ylabel('Coupling Strength', 'FontSize', 24)
            set(gca,'fontsize',15)
            title(['Coupling Strength of right hemisphere in ',banda_actual,' band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),'] Hz'], 'FontSize', 20, 'Interpreter', 'none')
            % Guardar imagen de la figura
            name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Coupling Strength in band ',banda_actual,' of right hemisphere'];
            saveas(fig_32,name_figure_save,'png');
            saveas(fig_32,name_figure_save,'fig');
            %waitforbuttonpress;
            close(fig_32)
        end
    end
    
    % Delay
    delta_f = 1;

    % Analisis del Delay
    p = 2;
    for i=1:length(idx_inicio)-1
        % Delay
        for j = length(idx_inicio):-1:p
            
            area_actual = registroLFP.average_sync{i,j}.areas;
                        
            f = registroLFP.average_sync{i,j}.coherenciogram.frequency;
            f_band = f(f>=banda_eval(1) & f<=banda_eval(2));
            
            Coherence_pre_mean = registroLFP.average_sync{i,j}.coherence.pre.^2;
            Coherence_on_mean = registroLFP.average_sync{i,j}.coherence.on.^2;
            Coherence_post_mean = registroLFP.average_sync{i,j}.coherence.post.^2;
            
            phi_pre = registroLFP.average_sync{i,j}.phase.pre;
            phi_on = registroLFP.average_sync{i,j}.phase.on;
            phi_post = registroLFP.average_sync{i,j}.phase.post;
            
            [~,I_pre] = max(Coherence_pre_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            [~,I_on] = max(Coherence_on_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            [~,I_post] = max(Coherence_post_mean(f>=banda_eval(1) & f<=banda_eval(2)));

            Coherence_pre_mean_band = Coherence_pre_mean(f>=f_band(I_pre)-delta_f & f<=f_band(I_pre)+delta_f);
            Coherence_on_mean_band = Coherence_on_mean(f>=f_band(I_on)-delta_f & f<=f_band(I_on)+delta_f);
            Coherence_post_mean_band = Coherence_post_mean(f>=f_band(I_post)-delta_f & f<=f_band(I_post)+delta_f);
            
            a_pre = (Coherence_pre_mean_band./(1-Coherence_pre_mean_band));
            b_pre = phi_pre(f>=f_band(I_pre)-delta_f & f<=f_band(I_pre)+delta_f);
            c_pre = f(f>=f_band(I_pre)-delta_f & f<=f_band(I_pre)+delta_f);
            obj_pre = -inf;
            a_on = (Coherence_on_mean_band./(1-Coherence_on_mean_band));
            b_on = phi_on(f>=f_band(I_on)-delta_f & f<=f_band(I_on)+delta_f);
            c_on = f(f>=f_band(I_on)-delta_f & f<=f_band(I_on)+delta_f);
            obj_on = -inf;
            a_post = (Coherence_post_mean_band./(1-Coherence_post_mean_band));
            b_post = phi_post(f>=f_band(I_post)-delta_f & f<=f_band(I_post)+delta_f);
            c_post = f(f>=f_band(I_post)-delta_f & f<=f_band(I_post)+delta_f);
            obj_post = -inf;
            
            for d = 1:length(delta)
                obj_pre_temp = sum(a_pre'.*cos(b_pre' - 2.*pi.*c_pre.*delta(d)));
                
                if obj_pre_temp > obj_pre
                    delay_pre = delta(d);
                    obj_pre = obj_pre_temp;
                end
                
                obj_on_temp = sum(a_on'.*cos(b_on' - 2.*pi.*c_on.*delta(d)));
                
                if obj_on_temp > obj_on
                    delay_on = delta(d);
                    obj_on = obj_on_temp;
                end
                
                obj_post_temp = sum(a_post'.*cos(b_post' - 2.*pi.*c_post.*delta(d)));
                
                if obj_post_temp > obj_post
                    delay_post = delta(d);
                    obj_post = obj_post_temp;
                end
            end
            
            idx_comb = find(num_sync(:,1)==i & num_sync(:,2)==j);
            delay_band(idx_comb,:) = [delay_pre,delay_on,delay_post];
            
            if visualization(3)

                fprintf('%s\n', [area_actual{1},' & ',area_actual{2}])
                fprintf('Porcentaje de banda en pre: %f \n', delay_pre)
                fprintf('Porcentaje de banda en on: %f \n', delay_on)
                fprintf('Porcentaje de banda en post: %f \n\n', delay_post)
            end
            
        end
        p=p+1;
    end
    
    % Analisis del Delay
    p = 2;
    for i=1:length(idx_final)-1
        % Delay
        for j = length(idx_final):-1:p
            
            area_actual = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.areas;
            
            f = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherenciogram.frequency;
            f_band = f(f>=banda_eval(1) & f<=banda_eval(2));
            
            Coherence_pre_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.pre.^2;
            Coherence_on_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.on.^2;
            Coherence_post_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.post.^2;
            
            phi_pre = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.phase.pre;
            phi_on = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.phase.on;
            phi_post = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.phase.post;
        
            [~,I_pre] = max(Coherence_pre_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            [~,I_on] = max(Coherence_on_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            [~,I_post] = max(Coherence_post_mean(f>=banda_eval(1) & f<=banda_eval(2)));

            Coherence_pre_mean_band = Coherence_pre_mean(f>=f_band(I_pre)-delta_f & f<=f_band(I_pre)+delta_f);
            Coherence_on_mean_band = Coherence_on_mean(f>=f_band(I_on)-delta_f & f<=f_band(I_on)+delta_f);
            Coherence_post_mean_band = Coherence_post_mean(f>=f_band(I_post)-delta_f & f<=f_band(I_post)+delta_f);
            
            a_pre = (Coherence_pre_mean_band./(1-Coherence_pre_mean_band));
            b_pre = phi_pre(f>=f_band(I_pre)-delta_f & f<=f_band(I_pre)+delta_f);
            c_pre = f(f>=f_band(I_pre)-delta_f & f<=f_band(I_pre)+delta_f);
            obj_pre = -inf;
            a_on = (Coherence_on_mean_band./(1-Coherence_on_mean_band));
            b_on = phi_on(f>=f_band(I_on)-delta_f & f<=f_band(I_on)+delta_f);
            c_on = f(f>=f_band(I_on)-delta_f & f<=f_band(I_on)+delta_f);
            obj_on = -inf;
            a_post = (Coherence_post_mean_band./(1-Coherence_post_mean_band));
            b_post = phi_post(f>=f_band(I_post)-delta_f & f<=f_band(I_post)+delta_f);
            c_post = f(f>=f_band(I_post)-delta_f & f<=f_band(I_post)+delta_f);
            obj_post = -inf;
            
            for d = 1:length(delta)
                obj_pre_temp = sum(a_pre'.*cos(b_pre' - 2.*pi.*c_pre.*delta(d)));
                
                if obj_pre_temp > obj_pre
                    delay_pre = delta(d);
                    obj_pre = obj_pre_temp;
                end
                
                obj_on_temp = sum(a_on'.*cos(b_on' - 2.*pi.*c_on.*delta(d)));
                
                if obj_on_temp > obj_on
                    delay_on = delta(d);
                    obj_on = obj_on_temp;
                end
                
                obj_post_temp = sum(a_post'.*cos(b_post' - 2.*pi.*c_post.*delta(d)));
                
                if obj_post_temp > obj_post
                    delay_post = delta(d);
                    obj_post = obj_post_temp;
                end
            end
            
            idx_comb = find(num_sync(:,1)==i & num_sync(:,2)==j)+length_sync;
            delay_band(idx_comb,:) = [delay_pre,delay_on,delay_post];
            
            if visualization(3)

                fprintf('%s\n', [area_actual{1},' & ',area_actual{2}])
                fprintf('Porcentaje de banda en pre: %fs \n', delay_pre)
                fprintf('Porcentaje de banda en on: %fs \n', delay_on)
                fprintf('Porcentaje de banda en post: %fs \n\n', delay_post)
            end
            
        end
        p=p+1;
    end
        

    if visualization(3)
        disp(' ')
        mitad_largo = round(size(delay_band,1)/2);  

        if mitad_largo == 1
            fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %fs, stim: %fs, post: %fs\n\n', delay_band(1:mitad_largo,:))
            fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %fs, stim: %fs, post: %fs\n\n', delay_band(mitad_largo+1:end,:)) 
            
            y_max = max([max(delay_band(1:mitad_largo,:)) max(delay_band(mitad_largo+1:end,:))]);
            y_min = min([min(delay_band(1:mitad_largo,:)) min(delay_band(mitad_largo+1:end,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            bar_inifin = bar(delay_band.*1000,'grouped');
            bar_inifin(1).FaceColor = azul; bar_inifin(2).FaceColor = rojo; bar_inifin(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max].*1000)
            xlim([xt(1)-0.5, xt(end)+0.5])
            title(['Delay in band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),']'])
            
        else 
            fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %fs, stim: %fs, post: %fs\n\n', mean(delay_band(1:mitad_largo,:)))
            fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %fs, stim: %fs, post: %fs\n\n',mean(delay_band(mitad_largo+1:end,:)))  
        
            y_max = max([max(delay_band(1:mitad_largo,:)) max(delay_band(mitad_largo+1:end,:))]);
            y_min = min([min(delay_band(1:mitad_largo,:)) min(delay_band(mitad_largo+1:end,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar_ini = bar(delay_band(1:mitad_largo,:).*1000,'grouped');
            bar_ini(1).FaceColor = azul; bar_ini(2).FaceColor = rojo; bar_ini(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(1:mitad_largo)))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max].*1000)
            xlim([xt(1)-0.5, xt(end)+0.5])
            title(['Delay in band [',int2str(banda_eval(1)),'-',int2str(banda_eval(2)),']'])
            subplot(2,1,2)
            bar_fin = bar(delay_band(mitad_largo+1:end,:).*1000,'grouped');
            bar_fin(1).FaceColor = azul; bar_fin(2).FaceColor = rojo; bar_fin(3).FaceColor = verde;
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(mitad_largo+1:end))) 
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max].*1000)
            xlim([xt(1)-0.5, xt(end)+0.5])
        end
    end
    
end

