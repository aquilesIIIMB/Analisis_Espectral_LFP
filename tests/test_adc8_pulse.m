etapas_m = [6,6,6];
[data, timestamps, info] = load_open_ephys_data_faster('D:\Descargas\Trabajo de titulo\Database\-2500_300Hz\arturo3_2017-07-04_15-48-06\100_ADC8.continuous');
pulso = data>0;
derv_data = diff(data>0);
idx_cambio_pulso = find(derv_data~=0)+1;
fin_pre = idx_cambio_pulso(1);
inicio_post = idx_cambio_pulso(end)-1;
inicio_stim = idx_cambio_pulso(2)-1;
fin_stim = idx_cambio_pulso(end-1);

time_max_reg_seg = length(data)/30000;
% Tiempo total en minutos de lo registrado
time_step_s = linspace(0,time_max_reg_seg,length(data)); % minutos

tiempo_fin_pre = time_step_s(fin_pre);
tinicial = tiempo_fin_pre - etapas_m(1)*60;
tiempo_inicio_stim_sennal = time_step_s(inicio_stim);
tiempo_fin_stim_sennal = time_step_s(fin_stim);
tiempo_inicio_post = time_step_s(inicio_post);
tiempo_fin_post = tiempo_inicio_post + etapas_m(3)*60;

tiempo_inicio_stim = tiempo_fin_pre + ((tiempo_inicio_post - tiempo_fin_pre) - etapas_m(2)*60) / 2;
tiempo_fin_stim = tiempo_inicio_post - ((tiempo_inicio_post - tiempo_fin_pre) - etapas_m(2)*60) / 2;

tiempos_etapas = [tinicial, tiempo_fin_pre, tiempo_inicio_stim, tiempo_inicio_stim_sennal, tiempo_fin_stim_sennal, tiempo_fin_stim, tiempo_inicio_post, tiempo_fin_post];

%plot(time_step_s/60, pulso, '-*')
%hold on
%plot(tiempos_etapas/60, tiempos_etapas*0+1, 'ro')

plot((time_step_s(time_step_s>=tinicial & time_step_s<=tiempo_fin_post)-tinicial)/60, pulso(time_step_s>=tinicial & time_step_s<=tiempo_fin_post), '-*')
hold on
plot((tiempos_etapas-tinicial)/60, tiempos_etapas*0+1, 'ro')
% No cohincide el segundo punto rojo, tiempo_fin_pre no aparece
% correcatemente
