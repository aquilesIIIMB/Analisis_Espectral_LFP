%% Calcular datos del protoclo

% Main 
%%%% Definir que area es la lesionada segun potencia en beta del PSD
show_injuredArea(registroLFP);

area_lesionada = input('Cual es el area lesionada en este registro?[L o R]:  ','s'); %'R' o 'L'
ind_slash = find(foldername=='\' | foldername=='/');
protocolo_name = foldername(ind_slash(1)+1:ind_slash(2)-1);
%protocolo_name = input('Nombre del protocolo?[ex:+2500uA_300Hz]:  ','s'); %'+2500uA_300Hz'

if strcmp(area_lesionada,'R')
    area_nolesionada = 'L';
elseif strcmp(area_lesionada,'L')
    area_nolesionada = 'R';
else
    error('Definir bien el area lesionada')
end

canales_eval = find(~[registroLFP.channel.removed]);
[C,ia,ic] = unique({registroLFP.channel(canales_eval).area},'stable');

if ~exist('protocoloLFP','var')

    disp('Inicializando la estructura del protocolo')
    % Estructura
    protocoloLFP.name = protocolo_name;
    protocoloLFP.register_checked.name = [];
    protocoloLFP.multitaper = registroLFP.multitaper;
    protocoloLFP.times.phase_range_m = registroLFP.times.phase_range_m;
    protocoloLFP.fs = 1000;
    protocoloLFP.injured.area = [];
    protocoloLFP.uninjured.area = [];

    for m = 1:length(ia)%1:largo_dataAll  
        i = ia(m);

        % Sennal (de la forma evoakdo) (Separar por etapas) (Promedio por canal)
        areas_actuales = find(ic == ic(i));
        area = registroLFP.channel(canales_eval(areas_actuales)).area;

        % Almacenar los datos
        if strcmp(area(end),area_lesionada)
            if isempty([protocoloLFP.injured.area])
                idx_injured = 0;
            else
                idx_injured = length(protocoloLFP.injured);
            end
            protocoloLFP.injured(idx_injured+1).area = area(1:end-1);
            
            protocoloLFP.injured(idx_injured+1).area_signals.data = [];
            protocoloLFP.injured(idx_injured+1).area_signals.time = [];

            protocoloLFP.injured(idx_injured+1).spectrogram.data = [];
            protocoloLFP.injured(idx_injured+1).spectrogram.time = [];
            protocoloLFP.injured(idx_injured+1).spectrogram.frequency = [];

            protocoloLFP.injured(idx_injured+1).psd.pre.data = [];
            protocoloLFP.injured(idx_injured+1).psd.on.data = [];
            protocoloLFP.injured(idx_injured+1).psd.post.data = [];
            protocoloLFP.injured(idx_injured+1).psd.frequency = [];

            %protocoloLFP.injured(idx_injured+1).coherency.data = [];


        elseif strcmp(area(end),area_nolesionada)
            if isempty([protocoloLFP.uninjured.area])
                idx_uninjured = 0;
            else
                idx_uninjured = length(protocoloLFP.uninjured);
            end
            protocoloLFP.uninjured(idx_uninjured+1).area = area(1:end-1);

            protocoloLFP.uninjured(idx_uninjured+1).area_signals.data = [];
            protocoloLFP.uninjured(idx_uninjured+1).area_signals.time = [];

            protocoloLFP.uninjured(idx_uninjured+1).spectrogram.data = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectrogram.time = [];
            protocoloLFP.uninjured(idx_uninjured+1).spectrogram.frequency = [];

            protocoloLFP.uninjured(idx_uninjured+1).psd.pre.data = [];
            protocoloLFP.uninjured(idx_uninjured+1).psd.on.data = [];
            protocoloLFP.uninjured(idx_uninjured+1).psd.post.data = [];
            protocoloLFP.uninjured(idx_uninjured+1).psd.frequency = [];

            %protocoloLFP.uninjured(idx_uninjured+1).coherency.data = [];
            
        else
            disp('Esta area no es lesionada ni no lesionada')

        end

    end
    
end
    
if ~strcmp(protocoloLFP.name, protocolo_name)
    error('Annadiendo registro a protoclo de otro nombre')
end

disp('Annadiendo informacion al protocolo')

% Guardar el nombre del regsitro a cargar
if isempty([protocoloLFP.register_checked.name])
    idx_registerName = 0;
else
    idx_registerName = length(protocoloLFP.register_checked);
end

protocoloLFP.register_checked(idx_registerName+1).name = registroLFP.name;
            
% Variables de tiempo del registro
inicio_s = registroLFP.times.start_s;
pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;
tiempo_sennal = registroLFP.times.steps_m;
        
for m = 1:length(ia)%1:largo_dataAll  
    i = ia(m);

    % Sennal (de la forma evoakdo) (Separar por etapas) (Promedio por canal)
    areas_actuales = find(ic == ic(i));
    area = registroLFP.channel(canales_eval(areas_actuales)).area;
    disp(area)
    % Cargar datos de todos los registros de un area
    Data_ref = [registroLFP.channel(canales_eval(areas_actuales)).data];
    mean_data = mean(Data_ref,2);
    %mean_data = mean_data(tiempo_sennal>inicio_s/60.0 & tiempo_sennal<tiempo_total);
    %time_data = tiempo_sennal(tiempo_sennal>inicio_s/60.0 & tiempo_sennal<tiempo_total);
    %time_data = time_data - min(time_data);
    mean_data = mean_data(tiempo_sennal<=(sum(registroLFP.times.phase_range_m)+1));
    time_data = tiempo_sennal(tiempo_sennal<=(sum(registroLFP.times.phase_range_m)+1));
    
    mean_data = imresize(mean_data,[(sum(registroLFP.times.phase_range_m)+1)*60*1000,1]);
    time_data = imresize(time_data,[1,(sum(registroLFP.times.phase_range_m)+1)*60*1000]);
    
    % Spectrograma (se resize para definir un tamanno) 
    areas_spect = [registroLFP.average_spectrum.area];
    indx_spectrum = find(strcmp(areas_spect,area));
    %disp(areas_spect{indx_spectrum})
    
    spectrograma = registroLFP.average_spectrum(indx_spectrum).spectrogram.data;
    t_Spectrogram = registroLFP.average_spectrum(indx_spectrum).spectrogram.tiempo;
    f_Spectrogram = registroLFP.average_spectrum(indx_spectrum).spectrogram.frecuencia;
    
    %spectrograma = spectrograma(t_Spectrogram>inicio_s & t_Spectrogram<(tiempo_total*60.0),:);
    %t_Spectrogram = t_Spectrogram(t_Spectrogram>inicio_s & t_Spectrogram<(tiempo_total*60.0)) - min(t_Spectrogram);
    spectrograma = spectrograma(t_Spectrogram<=(sum(registroLFP.times.phase_range_m)+1)*60.0,:);
    t_Spectrogram = t_Spectrogram(t_Spectrogram<=(sum(registroLFP.times.phase_range_m)+1)*60.0);

    %t_size = (sum(registroLFP.times.phase_range_m)*60.0+60)*2-1; % pensando en ventanas de 1s y pasos de 0.5s por eso por mult por 2
    %f_size = 3145;

    if isempty(protocoloLFP.injured(1).spectrogram.frequency)        
        t_size = length(t_Spectrogram);
        f_size = length(f_Spectrogram);
    else
        t_size = length(protocoloLFP.injured(1).spectrogram.time);
        f_size = length(protocoloLFP.injured(1).spectrogram.frequency);
    end
    
    % Si el espectrograma se corta antes del tiempo final
    if t_size ~= length(t_Spectrogram)
        t_size = length(t_Spectrogram);
        if max(t_Spectrogram) < (registroLFP.times.phase_range_m(1)*2.5)*60+60 
            error('Al menos debe haber la mitad de tiempo de la etapa post estimulacion')
        end
    end
    
    %t_Spectrogram = t_Spectrogram(1:t_size);
    t_Spectrogram = imresize(t_Spectrogram,[1,t_size]);
    t_Spectrogram = t_Spectrogram-min(t_Spectrogram);
    f_Spectrogram = imresize(f_Spectrogram,[1,f_size]); %disp(length(f_Spectrogram));
    spectrograma = imresize(spectrograma, [t_size,f_size]);
    %spectrograma = spectrograma(1:t_size,1:f_size);
    
    % PSD
    Spectral_pre = registroLFP.average_spectrum(indx_spectrum).psd.pre.data;
    Spectral_on = registroLFP.average_spectrum(indx_spectrum).psd.on.data;
    Spectral_post = registroLFP.average_spectrum(indx_spectrum).psd.post.data;
    
    % Almacenar los datos
    if strcmp(area(end),area_lesionada)
        areas_totales = {protocoloLFP.injured.area};
        idx_injured = find(strcmp(areas_totales,area(1:end-1)));
        
        % sennal en el tiempo
        if isempty([protocoloLFP.injured(idx_injured).area_signals.data])
            idx_data = 0;
        else
            idx_data = length(protocoloLFP.injured(idx_injured).area_signals);
        end
        
        protocoloLFP.injured(idx_injured).area_signals(idx_data+1).data = mean_data;
        protocoloLFP.injured(idx_injured).area_signals(idx_data+1).time = time_data;
        
        % espectrograma
        if isempty(protocoloLFP.injured(idx_injured).spectrogram.data)
            protocoloLFP.injured(idx_injured).spectrogram.data = spectrograma;
        else
            old_spectrograma = protocoloLFP.injured(idx_injured).spectrogram.data;
            t_size = min([length(protocoloLFP.injured(idx_injured).spectrogram.time), length(t_Spectrogram)]);
            protocoloLFP.injured(idx_injured).spectrogram.data = (old_spectrograma(1:t_size,:)*idx_data + spectrograma(1:t_size,:))/(idx_data+1);
        end
        protocoloLFP.injured(idx_injured).spectrogram.time = t_Spectrogram(1:t_size);
        protocoloLFP.injured(idx_injured).spectrogram.frequency = f_Spectrogram;
        
        % PSD
        %if isempty(protocoloLFP.injured(idx_injured).psd.data.pre)
        protocoloLFP.injured(idx_injured).psd.pre(idx_data+1).data = Spectral_pre;
        protocoloLFP.injured(idx_injured).psd.on(idx_data+1).data = Spectral_on;
        protocoloLFP.injured(idx_injured).psd.post(idx_data+1).data = Spectral_post;
        %else 
        %    protocoloLFP.injured(idx_injured).psd.pre.data = (protocoloLFP.injured(idx_injured).psd.data.pre*idx_data + Spectral_pre)/(idx_data+1);
        %    protocoloLFP.injured(idx_injured).psd.on.data = (protocoloLFP.injured(idx_injured).psd.data.on*idx_data + Spectral_on)/(idx_data+1);
        %    protocoloLFP.injured(idx_injured).psd.post.data = (protocoloLFP.injured(idx_injured).psd.data.post*idx_data + Spectral_post)/(idx_data+1);
        %end
        protocoloLFP.injured(idx_injured).psd.frequency = f_Spectrogram;
        
    elseif strcmp(area(end),area_nolesionada)
        areas_totales = {protocoloLFP.uninjured.area};
        idx_uninjured = find(strcmp(areas_totales,area(1:end-1)));
        
        % sennal en el tiempo
        if isempty([protocoloLFP.uninjured(idx_uninjured).area_signals.data])
            idx_data = 0;
        else
            idx_data = length(protocoloLFP.uninjured(idx_uninjured).area_signals);
        end        
        protocoloLFP.uninjured(idx_uninjured).area_signals(idx_data+1).data = mean_data;
        protocoloLFP.uninjured(idx_uninjured).area_signals(idx_data+1).time = time_data;
        
        % Espectrograma
        if isempty(protocoloLFP.uninjured(idx_uninjured).spectrogram.data)
            protocoloLFP.uninjured(idx_uninjured).spectrogram.data = spectrograma;
        else
            old_spectrograma = protocoloLFP.uninjured(idx_uninjured).spectrogram.data;
            t_size = min([length(protocoloLFP.uninjured(idx_uninjured).spectrogram.time), length(t_Spectrogram)]);
            protocoloLFP.uninjured(idx_uninjured).spectrogram.data = (old_spectrograma(1:t_size,:)*idx_data + spectrograma(1:t_size,:))/(idx_data+1);
        end
        protocoloLFP.uninjured(idx_uninjured).spectrogram.time = t_Spectrogram(1:t_size);
        protocoloLFP.uninjured(idx_uninjured).spectrogram.frequency = f_Spectrogram;
        
        % PSD
        %if isempty(protocoloLFP.uninjured(idx_uninjured).psd.data.pre)
        protocoloLFP.uninjured(idx_uninjured).psd.pre(idx_data+1).data = Spectral_pre;
        protocoloLFP.uninjured(idx_uninjured).psd.on(idx_data+1).data = Spectral_on;
        protocoloLFP.uninjured(idx_uninjured).psd.post(idx_data+1).data = Spectral_post;
        %else
        %    protocoloLFP.uninjured(idx_uninjured).psd.pre.data = (protocoloLFP.uninjured(idx_uninjured).psd.data.pre*idx_data + Spectral_pre)/(idx_data+1);
        %    protocoloLFP.uninjured(idx_uninjured).psd.on.data = (protocoloLFP.uninjured(idx_uninjured).psd.data.on*idx_data + Spectral_on)/(idx_data+1);
        %    protocoloLFP.uninjured(idx_uninjured).psd.post.data = (protocoloLFP.uninjured(idx_uninjured).psd.data.post*idx_data + Spectral_post)/(idx_data+1);
        %end
        protocoloLFP.uninjured(idx_uninjured).psd.frequency = f_Spectrogram;
        
    else
        disp('Esta area no es lesionada ni no lesionada')
        
    end
    
end

clear area area_lesionada area_nolesionada areas_actuales areas_spect
clear areas_totales C canales_eval Data_ref f_size f_Spectrogram i ia ic
clear idx_data idx_injured idx_registerName idx_uninjured ind_slash indx_spectrum
clear inicio_s m mean_data on_final_m on_inicio_m post_m pre_m 
clear Spectral_on Spectral_post Spectral_pre spectrograma t_size t_Spectrogram
clear tiempo_sennal tiempo_total time_data protocolo_name ans old_spectrograma
close all 
