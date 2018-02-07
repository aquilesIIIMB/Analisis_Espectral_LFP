%%% MSC al cuadrado!!!
function [sum_MSC_band, coupling_strength_band, delay_band] = coherence_measurements(registroLFP, banda_eval, visualization)
    sum_MSC_band = [];
    coupling_strength_band = [];
    delay_band = [];
    areas = {};
    delta = 1:100:10^6;
    delta = delta(1:round(length(delta)/2));
    delta = delta./10^6;
    
    [C,~,~] = unique({registroLFP.area.name},'stable');
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
            
            area_actual = registroLFP.average_sync{i,j}.names;
            
            f = registroLFP.average_sync{i,j}.coherenciogram.frequency;

            Coherence_pre_mean = registroLFP.average_sync{i,j}.coherence.pre.data;
            Coherence_on_mean = registroLFP.average_sync{i,j}.coherence.on.data;
            Coherence_post_mean = registroLFP.average_sync{i,j}.coherence.post.data;
        
            sum_MSC_pre = sum(Coherence_pre_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            sum_MSC_on = sum(Coherence_on_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            sum_MSC_post = sum(Coherence_post_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            
            areas = {areas{:},[area_actual{1},'vs',area_actual{2}]};
            sum_MSC_band = [sum_MSC_band; [sum_MSC_pre,sum_MSC_on,sum_MSC_post]];
            
            if visualization(1)
                figure;
                plot(f, Coherence_pre_mean)
                hold on
                plot(f, Coherence_on_mean)
                hold on
                plot(f, Coherence_post_mean)
                ylim([0.2 0.8])
                title([area_actual{1},' & ',area_actual{2}])

                fprintf('%s\n', [area_actual{1},' & ',area_actual{2}])
                fprintf('Porcentaje de banda beta en pre: %.2f \n', sum_MSC_pre)
                fprintf('Porcentaje de banda beta en on: %.2f \n', sum_MSC_on)
                fprintf('Porcentaje de banda beta en post: %.2f \n\n', sum_MSC_post)
            end
            
        end
        p=p+1;
    end
    
    % Analisis de la Coherencia
    p = 2;
    for i=1:length(idx_final)-1
        % Coherencia
        for j = length(idx_final):-1:p
            
            area_actual = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.names;
            
            f = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherenciogram.frequency;

            Coherence_pre_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.pre.data;
            Coherence_on_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.on.data;
            Coherence_post_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.post.data;
        
            sum_MSC_pre = sum(Coherence_pre_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            sum_MSC_on = sum(Coherence_on_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            sum_MSC_post = sum(Coherence_post_mean(f>=banda_eval(1) & f<=banda_eval(2)));
            
            areas = {areas{:},[area_actual{1},'vs',area_actual{2}]};
            sum_MSC_band = [sum_MSC_band; [sum_MSC_pre,sum_MSC_on,sum_MSC_post]];
            
            if visualization(1)
                figure;
                plot(f, Coherence_pre_mean)
                hold on
                plot(f, Coherence_on_mean)
                hold on
                plot(f, Coherence_post_mean)
                ylim([0.2 0.8])
                title([area_actual{1},' & ',area_actual{2}])

                fprintf('%s\n', [area_actual{1},' & ',area_actual{2}])
                fprintf('Porcentaje de banda beta en pre: %.2f \n', sum_MSC_pre)
                fprintf('Porcentaje de banda beta en on: %.2f \n', sum_MSC_on)
                fprintf('Porcentaje de banda beta en post: %.2f \n\n', sum_MSC_post)
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
            bar(sum_MSC_band,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
        else
            fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', mean(sum_MSC_band(1:mitad_largo,:)))
            fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n',mean(sum_MSC_band(mitad_largo+1:end,:)))  
        
            y_max = max([max(sum_MSC_band(1:mitad_largo,:)) max(sum_MSC_band(mitad_largo+1:end,:))]);
            y_min = min([min(sum_MSC_band(1:mitad_largo,:)) min(sum_MSC_band(mitad_largo+1:end,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar(sum_MSC_band(1:mitad_largo,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(1:mitad_largo)))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            subplot(2,1,2)
            bar(sum_MSC_band(mitad_largo+1:end,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(mitad_largo+1:end))) 
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
        end
    end
    
    % Coupling Strength
    delta_f = 1;

    % Analisis de la Coherencia
    p = 2;
    for i=1:length(idx_inicio)-1
        % Coherencia
        for j = length(idx_inicio):-1:p
                        
            f = registroLFP.average_sync{i,j}.coherenciogram.frequency;
            f_band = f(f>=banda_eval(1) & f<=banda_eval(2));
            
            Coherence_pre_mean = registroLFP.average_sync{i,j}.coherence.pre.data;
            Coherence_on_mean = registroLFP.average_sync{i,j}.coherence.on.data;
            Coherence_post_mean = registroLFP.average_sync{i,j}.coherence.post.data;
        
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
            
            coupling_strength_band = [coupling_strength_band; [coupling_strength_pre,coupling_strength_on,coupling_strength_post]];
            
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
                ylim([0.2 0.8])
                title([area_actual{1},' & ',area_actual{2}])

                fprintf('%s\n', [area_actual{1},' & ',area_actual{2}])
                fprintf('Porcentaje de banda beta en pre: %.2f \n', coupling_strength_pre)
                fprintf('Porcentaje de banda beta en on: %.2f \n', coupling_strength_on)
                fprintf('Porcentaje de banda beta en post: %.2f \n\n', coupling_strength_post)
            end
            
        end
        p=p+1;
    end
    
    % Analisis de la Coherencia
    p = 2;
    for i=1:length(idx_final)-1
        % Coherencia
        for j = length(idx_final):-1:p
            
            f = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherenciogram.frequency;
            f_band = f(f>=banda_eval(1) & f<=banda_eval(2));
            
            Coherence_pre_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.pre.data;
            Coherence_on_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.on.data;
            Coherence_post_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.post.data;
        
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
            
            coupling_strength_band = [coupling_strength_band; [coupling_strength_pre,coupling_strength_on,coupling_strength_post]];
            
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
                ylim([0.2 0.8])
                title([area_actual{1},' & ',area_actual{2}])

                fprintf('%s\n', [area_actual{1},' & ',area_actual{2}])
                fprintf('Porcentaje de banda beta en pre: %.2f \n', coupling_strength_pre)
                fprintf('Porcentaje de banda beta en on: %.2f \n', coupling_strength_on)
                fprintf('Porcentaje de banda beta en post: %.2f \n\n', coupling_strength_post)
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
            bar(coupling_strength_band,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            
        else 
            fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %f, stim: %f, post: %f\n\n', mean(coupling_strength_band(1:mitad_largo,:)))
            fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %f, stim: %f, post: %f\n\n',mean(coupling_strength_band(mitad_largo+1:end,:)))  
        
            y_max = max([max(coupling_strength_band(1:mitad_largo,:)) max(coupling_strength_band(mitad_largo+1:end,:))]);
            y_min = min([min(coupling_strength_band(1:mitad_largo,:)) min(coupling_strength_band(mitad_largo+1:end,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar(coupling_strength_band(1:mitad_largo,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(1:mitad_largo)))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            subplot(2,1,2)
            bar(coupling_strength_band(mitad_largo+1:end,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(mitad_largo+1:end))) 
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
        end
    end
    
    % Delay
    delta_f = 1;

    % Analisis de la Coherencia
    p = 2;
    for i=1:length(idx_inicio)-1
        % Coherencia
        for j = length(idx_inicio):-1:p
                        
            f = registroLFP.average_sync{i,j}.coherenciogram.frequency;
            f_band = f(f>=banda_eval(1) & f<=banda_eval(2));
            
            Coherence_pre_mean = registroLFP.average_sync{i,j}.coherence.pre.data;
            Coherence_on_mean = registroLFP.average_sync{i,j}.coherence.on.data;
            Coherence_post_mean = registroLFP.average_sync{i,j}.coherence.post.data;
            
            phi_pre = registroLFP.average_sync{i,j}.phase.pre.data;
            phi_on = registroLFP.average_sync{i,j}.phase.on.data;
            phi_post = registroLFP.average_sync{i,j}.phase.post.data;
            
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
            
            delay_band = [delay_band; [delay_pre,delay_on,delay_post]];
            
            if visualization(3)

                fprintf('%s\n', [area_actual{1},' & ',area_actual{2}])
                fprintf('Porcentaje de banda beta en pre: %.2f \n', delay_pre)
                fprintf('Porcentaje de banda beta en on: %.2f \n', delay_on)
                fprintf('Porcentaje de banda beta en post: %.2f \n\n', delay_post)
            end
            
        end
        p=p+1;
    end
    
    % Analisis de la Coherencia
    p = 2;
    for i=1:length(idx_final)-1
        % Coherencia
        for j = length(idx_final):-1:p
            
            f = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherenciogram.frequency;
            f_band = f(f>=banda_eval(1) & f<=banda_eval(2));
            
            Coherence_pre_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.pre.data;
            Coherence_on_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.on.data;
            Coherence_post_mean = registroLFP.average_sync{i+length(idx_inicio),j+length(idx_inicio)}.coherence.post.data;
        
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
            
            delay_band = [delay_band; [delay_pre,delay_on,delay_post]];
            
            if visualization(3)

                fprintf('%s\n', [area_actual{1},' & ',area_actual{2}])
                fprintf('Porcentaje de banda beta en pre: %.2fs \n', delay_pre)
                fprintf('Porcentaje de banda beta en on: %.2fs \n', delay_on)
                fprintf('Porcentaje de banda beta en post: %.2fs \n\n', delay_post)
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
            bar(delay_band,'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            
        else 
            fprintf('Promedio de porcentaje de potencia en primer grafico\npre: %fs, stim: %fs, post: %fs\n\n', mean(delay_band(1:mitad_largo,:)))
            fprintf('Promedio de porcentaje de potencia en segundo grafico\npre: %fs, stim: %fs, post: %fs\n\n',mean(delay_band(mitad_largo+1:end,:)))  
        
            y_max = max([max(delay_band(1:mitad_largo,:)) max(delay_band(mitad_largo+1:end,:))]);
            y_min = min([min(delay_band(1:mitad_largo,:)) min(delay_band(mitad_largo+1:end,:))]);
            y_max = y_max + abs(y_max)*0.1;
            y_min = y_min - abs(y_min)*0.1;
            figure;
            subplot(2,1,1)
            bar(delay_band(1:mitad_largo,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(1:mitad_largo)))
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
            subplot(2,1,2)
            bar(delay_band(mitad_largo+1:end,:),'grouped');
            xt = get(gca, 'XTick');
            set(gca, 'XTick', xt, 'XTickLabel', string(areas(mitad_largo+1:end))) 
            legend('Pre', 'Stim', 'Post');
            grid on
            ylim([y_min y_max])
        end
    end
    
end

