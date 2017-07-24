function [dataStamp, timeStamp, n] = rmArtifacts_mufti(data,umbral,time_step_m_tiempoTotal,pre_m,on_inicio_m, on_final_m, post_m)


%% detectArtifacts

largo_datos = length(data);
flagUp = 0; flagDown = 1;
n = 0; timeStamp = []; dataStamp = [];

for i = 1:largo_datos
    if (data(i) > umbral) && ~flagUp
        flagUp = 1;
        flagDown = 0;
    elseif (data(i) < umbral) && ~flagDown
        flagUp = 0;
        flagDown = 1;
        n = n + 1;
        timeStamp = [timeStamp, time_step_m_tiempoTotal(i)];
        dataStamp = [dataStamp, data(i)];
    end
    
    if flagUp
        n = n + 1;
    end
end

%%
artRemovedSignal = data;
largo_artefactos = length(dataStamp);
stimulation = zeros(size(data_elim_maxTime));
stimulation(time_step_m_tiempoTotal>on_inicio_m & time_step_m_tiempoTotal<on_final_m)=150*sin(2*pi*300*time_step_m_tiempoTotal(time_step_m_tiempoTotal>on_inicio_m & time_step_m_tiempoTotal<on_final_m));

for j = 1:largo_artefactos
    refPoint = dataStamp(j);
    localMinima = min(data(refPoint:))












end