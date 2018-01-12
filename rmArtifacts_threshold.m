function [data_all_changed, fueraUmbral_propag_logical] = rmArtifacts_threshold(data,umbral, Fc)

% Se remueven los artefactos y se establecen los indices de la seÒal que se
% alteraron por estar sobre el umbral y su propagacion hacia adelante y atras
data_all_changed = data;
largo_data = length(data);
shift_left = 1100; % 50 100
shift_right = 2200; % 50 200

idx_over_inicial = find((data > umbral) | (data < -umbral));
data_over_logic_inicial = zeros(size(data));
data_over_logic_inicial(idx_over_inicial) = 1;
data_over_logic_final = data_over_logic_inicial;

%disp('Entro al shift_left')
for i = 1:shift_left
    idx_over_now = find(data_over_logic_inicial > 0) - i;
    idx_over_now = unique(idx_over_now);
    idx_over_now = idx_over_now(idx_over_now >= 0 & idx_over_now <= largo_data);
    data_over_logic_final(idx_over_now) = 1;
end

%disp('Entro al shift_right')
for i = 1:shift_right
    idx_over_now = find(data_over_logic_inicial > 0) + i;
    idx_over_now = unique(idx_over_now);
    idx_over_now = idx_over_now(idx_over_now >= 0 & idx_over_now <= largo_data);
    data_over_logic_final(idx_over_now) = 1;
end
idx_over_final = find(data_over_logic_final > 0);
%disp('Salio del shift')

fueraUmbral_propag_ind = unique(idx_over_final);

fueraUmbral_propag_logical = data_over_logic_final(1:largo_data); % Para que no sobrepase el limite de la sennal debido al relleno
fueraUmbral_propag_logical = (fueraUmbral_propag_logical > 0); % Para convertirlos a 1 y 0
%%
data_all_changed = replacing_values(data_all_changed, fueraUmbral_propag_ind, Fc); % Reemplazo de artefactos propagados
%%
data_all_changed = data_all_changed(1:largo_data); % Para que no sobrepase el limite de la se√±al debido al relleno
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




