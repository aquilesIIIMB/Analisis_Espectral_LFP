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

