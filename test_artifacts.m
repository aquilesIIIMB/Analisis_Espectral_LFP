%plot(data_all(:,1))
%hold on
%linea_ref = refline([0 300]); linea_ref.Color = 'r';
%umbral = 4*mean(abs(data_all(:,1)))/0.675;
%data_all_changed = data_all(:,1);

%for i = 1:length(data_all(:,1))
    
%    if data_all(i,1) > umbral
%        data_all_changed(i,1) = mean(data_all_changed(1:i,1));
%    elseif data_all(i,1) < -umbral
%        data_all_changed(i,1) = mean(data_all_changed(1:i,1));
%    end
%    
%end

%plot(data_all(:,1))
%hold on
%plot(data_all_changed(:,1))

%a = ((data_elim_maxTime < umbral) + (data_elim_maxTime > -umbral))/2;
data_all_changed = data_elim_maxTime;
%%
entreUmbral_pre = (((data_elim_maxTime < umbral) & (data_elim_maxTime > -umbral)) & (time_step_m_tiempoTotal < pre_m)');
fueraUmbral_pre = (((data_elim_maxTime > umbral) | (data_elim_maxTime < -umbral)) & (time_step_m_tiempoTotal < pre_m)');

B=zeros(size(fueraUmbral_pre));
for n=1:50
    B(1:end-n) = fueraUmbral_pre(n+1:end)|B(1:end-n);
    B(n+1:end) = fueraUmbral_pre(1:end-n)|B(n+1:end);
end
fueraUmbral_pre = B|fueraUmbral_pre;
entre_sinfueraUmbral_pre = (~fueraUmbral_pre & entreUmbral_pre) & (~fueraUmbral_pre | entreUmbral_pre);
data_all_changed(fueraUmbral_pre) = mean(data_elim_maxTime(entre_sinfueraUmbral_pre));
%%
entreUmbral_rup = ((data_elim_maxTime < umbral) & (data_elim_maxTime > -umbral) & ((time_step_m_tiempoTotal > pre_m) & (time_step_m_tiempoTotal < on_inicio_m))');
fueraUmbral_rup = ((data_elim_maxTime > umbral) | (data_elim_maxTime < -umbral) & ((time_step_m_tiempoTotal > pre_m) & (time_step_m_tiempoTotal < on_inicio_m))');

B=zeros(size(fueraUmbral_rup));
for n=1:50
    B(1:end-n) = fueraUmbral_rup(n+1:end)|B(1:end-n);
    B(n+1:end) = fueraUmbral_rup(1:end-n)|B(n+1:end);
end
fueraUmbral_rup = B|fueraUmbral_rup;
entre_sinfueraUmbral_rup = (~fueraUmbral_rup & entreUmbral_rup) & (~fueraUmbral_rup | entreUmbral_rup);
data_all_changed(fueraUmbral_rup) = mean(data_elim_maxTime(entre_sinfueraUmbral_rup));
%%
entreUmbral_on = ((data_elim_maxTime < umbral) & (data_elim_maxTime > -umbral) & ((time_step_m_tiempoTotal > on_inicio_m) & (time_step_m_tiempoTotal < on_final_m))');
fueraUmbral_on = ((data_elim_maxTime > umbral) | (data_elim_maxTime < -umbral) & ((time_step_m_tiempoTotal > on_inicio_m) & (time_step_m_tiempoTotal < on_final_m))');

B=zeros(size(fueraUmbral_on));
for n=1:50
    B(1:end-n) = fueraUmbral_on(n+1:end)|B(1:end-n);
    B(n+1:end) = fueraUmbral_on(1:end-n)|B(n+1:end);
end
fueraUmbral_on = B|fueraUmbral_on;
entre_sinfueraUmbral_on = (~fueraUmbral_on & entreUmbral_on) & (~fueraUmbral_on | entreUmbral_on);
data_all_changed(fueraUmbral_on) = mean(data_elim_maxTime(entre_sinfueraUmbral_on));
%%
entreUmbral_rdown = ((data_elim_maxTime < umbral) & (data_elim_maxTime > -umbral) & ((time_step_m_tiempoTotal > on_final_m) & (time_step_m_tiempoTotal < post_m))');
fueraUmbral_rdown = ((data_elim_maxTime > umbral) | (data_elim_maxTime < -umbral) & ((time_step_m_tiempoTotal > on_final_m) & (time_step_m_tiempoTotal < post_m))');

B=zeros(size(fueraUmbral_rdown));
for n=1:50
    B(1:end-n) = fueraUmbral_rdown(n+1:end)|B(1:end-n);
    B(n+1:end) = fueraUmbral_rdown(1:end-n)|B(n+1:end);
end
fueraUmbral_rdown = B|fueraUmbral_rdown;
entre_sinfueraUmbral_rdown = (~fueraUmbral_rdown & entreUmbral_rdown) & (~fueraUmbral_rdown | entreUmbral_rdown);
data_all_changed(fueraUmbral_rdown) = mean(data_elim_maxTime(entre_sinfueraUmbral_rdown));
%%
entreUmbral_post = ((data_elim_maxTime < umbral) & (data_elim_maxTime > -umbral) & (time_step_m_tiempoTotal > post_m)');
fueraUmbral_post = ((data_elim_maxTime > umbral) | (data_elim_maxTime < -umbral) & (time_step_m_tiempoTotal > post_m)');

B=zeros(size(fueraUmbral_post));
for n=1:50
    B(1:end-n) = fueraUmbral_post(n+1:end)|B(1:end-n);
    B(n+1:end) = fueraUmbral_post(1:end-n)|B(n+1:end);
end
fueraUmbral_post = B|fueraUmbral_post;
entre_sinfueraUmbral_post = (~fueraUmbral_post & entreUmbral_post) & (~fueraUmbral_post | entreUmbral_post);
data_all_changed(fueraUmbral_post) = mean(data_elim_maxTime(entre_sinfueraUmbral_post));
%% Para hacer la interpolacion
%a = data_elim_maxTime-data_all_changed;
%largo_a = length(a);

%for i = 1: largo_a
    
%    if 
%end

%%
figure
plot(data_elim_maxTime)
figure
plot(data_all_changed,'r')
figure
plot(data_elim_maxTime-data_all_changed,'g')

%data_ft = data_elim_maxTime(fueraUmbral_pre|fueraUmbral_rup|fueraUmbral_on|fueraUmbral_rdown|fueraUmbral_post);
data_ft = data_elim_maxTime;
%plot(abs(fft(data_ft)))
[Spectral_pmtm, f_Spectral_pmtm] = pmtm(data_ft,3,length(data_ft),1000);
figure;semilogy(f_Spectral_pmtm,Spectral_pmtm)
[Spectral_pmtm_fase, f_Spectral_pmtm] = pmtm(data_ft(fueraUmbral_post),3,length(data_ft(fueraUmbral_post)),1000);
figure;semilogy(f_Spectral_pmtm,Spectral_pmtm_fase)