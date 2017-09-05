function [data_all_changed, fueraUmbral_propag_logical] = rmArtifacts_threshold(data,umbral,time_step_m_tiempoTotal,pre_m,on_inicio_m, on_final_m, post_m, end_m, Fc)

% Se remueven los artefactos y se establecen los indices de la seÒal que se
% alteraron por estar sobre el umbral y su propagacion hacia adelante y atras
data_all_changed = data;
largo_data = length(data);
shift_left = 1100; % 50 100
shift_right = 2200; % 50 200

%%
fueraUmbral_pre = find(((data > umbral) | (data < -umbral)) & (time_step_m_tiempoTotal < pre_m)');
fueraUmbral_propag_pre = index_spread(fueraUmbral_pre, shift_left, shift_right);
%%
fueraUmbral_rup = find((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > pre_m) & (time_step_m_tiempoTotal < on_inicio_m))');
fueraUmbral_propag_rup = index_spread(fueraUmbral_rup, shift_left, shift_right);
%%
fueraUmbral_on = find((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > on_inicio_m) & (time_step_m_tiempoTotal < on_final_m))');
fueraUmbral_propag_on = index_spread(fueraUmbral_on, shift_left, shift_right);
%%
fueraUmbral_rdown = find((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > on_final_m) & (time_step_m_tiempoTotal < post_m))');
fueraUmbral_propag_rdown = index_spread(fueraUmbral_rdown, shift_left, shift_right);
%%
fueraUmbral_post = find((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > post_m) & (time_step_m_tiempoTotal < end_m))'); % si falla, sacar el parentesis del end_m
fueraUmbral_propag_post = index_spread(fueraUmbral_post, shift_left, shift_right);
%% 
%fueraUmbral = (fueraUmbral_pre | fueraUmbral_rup | fueraUmbral_on | fueraUmbral_rdown | fueraUmbral_post); 
fueraUmbral_propag_ind = unique([fueraUmbral_propag_pre;fueraUmbral_propag_rup;fueraUmbral_propag_on;fueraUmbral_propag_rdown;fueraUmbral_propag_post]);
fueraUmbral_propag_ind = fueraUmbral_propag_ind((fueraUmbral_propag_ind>0) & (fueraUmbral_propag_ind<=largo_data));  % Para que no tenga indices negativos y Para no tener datos sobre el largo de la sennal

%if isempty(fueraUmbral_propag_ind)
%    disp('FueraUmbral_propag_ind Vacio, con umbral:')
%    disp(umbral)
%end

fueraUmbral_propag_logical = zeros(largo_data,1);
fueraUmbral_propag_logical(fueraUmbral_propag_ind) = 1;
fueraUmbral_propag_logical = fueraUmbral_propag_logical(1:largo_data); % Para que no sobrepase el limite de la sennal debido al relleno
fueraUmbral_propag_logical = (fueraUmbral_propag_logical > 0); % Para convertirlos a 1 y 0
%%
data_all_changed = replacing_values(data_all_changed, fueraUmbral_propag_ind, Fc); % Reemplazo de artefactos propagados
%%
data_all_changed = data_all_changed(1:largo_data); % Para que no sobrepase el limite de la se√±al debido al relleno
end

function fueraUmbral_propag_ind = index_spread(fueraUmbral_ind, shift_left, shift_right)
    % Umbral de entrada como columna
    ind_s = fueraUmbral_ind-shift_left; % Determinar los indices segun posicion menos el corrieminto a la izq
    ind_e = fueraUmbral_ind+shift_right; 
    indx = [ind_s,ind_e];
    o = int2str(indx(:,1));
    p = int2str(indx(:,2));
    x =strcat(strcat(strcat(strcat(o),':'),p),',');
    x = str2num(x);
    fueraUmbral_propag_ind = unique(x(:)); %Son indices

end

function data_all_changed = replacing_values(data, fueraUmbral_propag_ind, Fc)
    
    % Sustitucion de artefactos por sinusoidal
    data_all_changed = data;
    largo_data = length(data_all_changed);
    % Time specifications:
    Fs = 1000;                   % samples per second
    dt = 1/Fs;                   % seconds per sample
    StopTime = largo_data/1000;             % seconds
    t = (0:dt:StopTime-dt)';     % seconds
    %% Sine wave:
    s = (10^-2)*sin(2*pi*Fc*t);
    %[Spectral_pmtm, f_Spectral_pmtm] = pmtm(x,3,length(x),1000);
    %figure;semilogy(f_Spectral_pmtm,Spectral_pmtm)
    data_all_changed(fueraUmbral_propag_ind) = s(1:length(fueraUmbral_propag_ind)); % Reemplazo de valores de artefacto y propagacion

end




