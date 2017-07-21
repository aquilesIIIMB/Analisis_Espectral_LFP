%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Referenciacion.m
fprintf('\nReferenciacion\n')
fprintf('%s\n',etapa)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataAll_select_ref = [];

if strcmp(tipo_de_referencia, 'none') %% Sin referencia
    largo_todas_areas = length(Area_select);

    for j = 1:largo_todas_areas

        %disp(Channel_select{j})
        eval(['data_select_ref',Channel_select{j},' = data_select',Channel_select{j},';']);
        eval(['dataAll_select_ref = [dataAll_select_ref, data_select',Channel_select{j},';']);
    end


elseif strcmp(tipo_de_referencia, 'general') %% Referencia al promedio general
    largo_todas_areas = length(Area_select);
    zdata = zscore(data_allSelect);
    average = mean(zdata,2);
    for j = 1:largo_todas_areas
        %disp(Channel_select{j})
        %eval(['data_ref = data_select',Channel_select{j},';']);
        %data_ref = ;
        data_ref = zdata(:,j) - average;
        eval(['data_select_ref',Channel_select{j},' = data_ref;']);
        dataAll_select_ref = [dataAll_select_ref, data_ref];
    end


elseif strcmp(tipo_de_referencia, 'area') %% Referencia al promedio de las areas
    % indices de las mismas areas
    [C,ia,ic] = unique(Area_select,'stable');

    for m = 1:length(ia)%1:largo_dataAll  
        i = ia(m);
        % pasar con un boton
        areas_actuales = find(ic == ic(i));

        data_area_prom = 0;
        largo_area_actual = length(areas_actuales);

        for q = 1:largo_area_actual

            %disp(C(ic(i)));
            %disp(Channel_select{areas_actuales(q)})
            eval(['data_ref = data_select',Channel_select{areas_actuales(q)},';']);
            data_area_prom = data_area_prom + data_ref;
        end    

        data_area_prom = data_area_prom./largo_area_actual;

        for j = 1:largo_area_actual

            %disp(Channel_select{areas_actuales(j)})
            eval(['data_ref = data_select',Channel_select{areas_actuales(j)},';']);
            data_ref = data_ref - data_area_prom;
            eval(['data_select_ref',Channel_select{areas_actuales(j)},' = data_ref;']);
            dataAll_select_ref = [dataAll_select_ref, data_ref];
        end


    end
end



