%%% Grafica de evolucion de potencia en el tiempo

%Name_power = string(power_ranking.power_ranking_osci.Name);
Name_power = string(power_ranking.power_ranking_frac_total.Name);
%LesionPre = power_ranking.power_ranking_osci.Lesion_Pre;
LesionPre = power_ranking.power_ranking_frac_total.Lesion_Pre;
%Protocol = string(power_ranking.power_ranking_osci.Protocol);
Protocol = string(power_ranking.power_ranking_frac_total.Protocol);

idx_record = strfind(Name_power, 'aravilla');
%idx_record = strfind(Name_power, 'harles');
%idx_record = strfind(Name_power, 'rturo');
%idx_record = strfind(Name_power, 'dani');
%idx_record = strfind(Name_power, 'ton');
idx_record = find(~cellfun(@isempty,idx_record));

%idx_record = strfind(Name_power, 'rlando');
%idx_record_2 = strfind(Name_power, 'RLANDO');
%idx_record = find(~cellfun(@isempty,idx_record));
%idx_record_2 = find(~cellfun(@isempty,idx_record_2));
%idx_record = unique([idx_record; idx_record_2]);

Name_record = Name_power(idx_record);
Name_date = extractAfter(Name_record,'_');
Name_date = extractBefore(Name_date,'_');

Power_time_table = sortrows(table(Name_power(idx_record,:), Protocol(idx_record,:), Name_date, LesionPre(idx_record,:),'VariableNames',{'Name','Protocol','Date','Lesion_Pre'}), 3, 'ascend');

% Filtrar tablas
Power_time_table = Power_time_table(Power_time_table.Date == {'2017-06-05'} | ...
    Power_time_table.Date == {'2017-06-06'} | ...
    Power_time_table.Date == {'2017-06-08'} | ...
    Power_time_table.Date == {'2017-06-09'} | ...
    Power_time_table.Date == {'2017-06-15'} | ...
    Power_time_table.Date == {'2017-06-16'} ,:);


azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];
morado = [0.494, 0.184, 0.556];
amarillo = [1, 1, 0];
azul_claro = [0.2 0.6470 0.9410];
rojo_oscuro = [0.635, 0.078, 0.184];
verde_claro = [0.666, 0.874, 0.388];

fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
bar_lesion_pre = bar(Power_time_table.Lesion_Pre,'grouped');
bar_lesion_pre(1).FaceColor = azul; 
bar_lesion_pre(2).FaceColor = rojo; 
bar_lesion_pre(3).FaceColor = verde;
bar_lesion_pre(4).FaceColor = morado; 
bar_lesion_pre(5).FaceColor = amarillo;
grid on
lgd = legend(areas,...
    'Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', Power_time_table.Date)
xtickangle(45)
xlim([0.5, xt(end)+0.5])
ylabel('Power [W/Hz]', 'FontSize', 24)
set(gca,'FontSize',20)

%path = '/media/cmanalisis/DATA/Registros_Flo/Registros_ratasPUC/-375/maravilla_2017-06-05_10-47-34';
%path = '/media/cmanalisis/DATA/Registros_Flo/Registros_ratasPUC/300Hz/maravilla_2017-06-06_13-41-42';
%path = '/media/cmanalisis/DATA/Registros_Flo/Registros_ratasPUC/+375_300Hz/maravilla_2017-06-08_12-42-34';
%path = '/media/cmanalisis/DATA/Registros_Flo/Registros_ratasPUC/-2500/maravilla_2017-06-16_16-43-08';
%path = '/media/cmanalisis/DATA/Registros_Flo/Registros_ratasPUC/+2500_300Hz/maravilla_2017-06-17_16-39-32';
%path = '/media/cmanalisis/DATA/Registros_Flo/Registros_ratasPUC/+5000/maravilla_2017-06-19_12-44-21';
%path = '/media/cmanalisis/DATA/Registros_Flo/Registros_ratasPUC/150Hz/maravilla_2017-07-04_15-19-26';

max_amp_total = [];
for j = 1:length(Power_time_table.Date)
    max_amp = [];
    path = ['/media/cmanalisis/DATA/Registros_Flo/Registros_ratasPUC/',char(Power_time_table.Protocol(j)),'/',char(Power_time_table.Name(j))];
    disp(Power_time_table.Date)
    
    for i = 1:8
        ch_number = ['/100_CH',int2str(5+i),'.continuous']; %5 o 37
        disp(ch_number)
        [data, ~, ~] = load_open_ephys_data_faster(strtrim([path, ch_number]));

        % Disenno del filtro pasa banda
        Hd_low = designfilt(registroLFP.filter_param(1).type,'FilterOrder',registroLFP.filter_param(1).n, ...
        'HalfPowerFrequency',registroLFP.filter_param(1).fc,'DesignMethod',registroLFP.filter_param(1).design_method,'SampleRate',registroLFP.filter_param(1).fs);

        % Filtrado del primer LFP
        data_filt = filtfilt(Hd_low, data);

        % Downsamplear el primer LFP para llevar los registros a la tasa de muestro requerida
        data_downS = downsample(data_filt,registroLFP.sampleRate/registroLFP.desired_fs);

        % Filtro pasa alto despues de downsamplin debido a la baja Fc
        Hd_high = designfilt(registroLFP.filter_param(2).type,'FilterOrder',registroLFP.filter_param(2).n, ...
        'HalfPowerFrequency',registroLFP.filter_param(2).fc,'DesignMethod',registroLFP.filter_param(2).design_method,'SampleRate',registroLFP.filter_param(2).fs);

        data_downS_filtHigh = filtfilt(Hd_high, data_downS);

        data_redy = data_downS_filtHigh(1:round(length(data_downS_filtHigh)/3));
        max_amp = [max_amp; max(data_redy)-mean(data_redy)];

    end
    max_amp = mean(max_amp);
    max_amp_total = [max_amp_total; max_amp];
end




