function data_all_changed = rmArtifacts_mean(data,umbral,time_step_m_tiempoTotal,pre_m,on_inicio_m, on_final_m, post_m)

data_all_changed = data;
%%
entreUmbral_pre = (((data < umbral) & (data > -umbral)) & (time_step_m_tiempoTotal < pre_m)');
fueraUmbral_pre = (((data > umbral) | (data < -umbral)) & (time_step_m_tiempoTotal < pre_m)');
%%
entreUmbral_rup = ((data < umbral) & (data > -umbral) & ((time_step_m_tiempoTotal > pre_m) & (time_step_m_tiempoTotal < on_inicio_m))');
fueraUmbral_rup = ((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > pre_m) & (time_step_m_tiempoTotal < on_inicio_m))');
%%
entreUmbral_on = ((data < umbral) & (data > -umbral) & ((time_step_m_tiempoTotal > on_inicio_m) & (time_step_m_tiempoTotal < on_final_m))');
fueraUmbral_on = ((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > on_inicio_m) & (time_step_m_tiempoTotal < on_final_m))');
%%
entreUmbral_rdown = ((data < umbral) & (data > -umbral) & ((time_step_m_tiempoTotal > on_final_m) & (time_step_m_tiempoTotal < post_m))');
fueraUmbral_rdown = ((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > on_final_m) & (time_step_m_tiempoTotal < post_m))');
%%
entreUmbral_post = ((data < umbral) & (data > -umbral) & (time_step_m_tiempoTotal > post_m)');
fueraUmbral_post = ((data > umbral) | (data < -umbral) & (time_step_m_tiempoTotal > post_m)');

B1=zeros(size(fueraUmbral_pre));
B2=zeros(size(fueraUmbral_rup));
B3=zeros(size(fueraUmbral_on));
B4=zeros(size(fueraUmbral_rdown));
B5=zeros(size(fueraUmbral_post));

for n=1:50
    B1(1:end-n) = fueraUmbral_pre(n+1:end)|B1(1:end-n);
    B1(n+1:end) = fueraUmbral_pre(1:end-n)|B1(n+1:end);
    
    B2(1:end-n) = fueraUmbral_rup(n+1:end)|B2(1:end-n);
    B2(n+1:end) = fueraUmbral_rup(1:end-n)|B2(n+1:end);
    
    B3(1:end-n) = fueraUmbral_on(n+1:end)|B3(1:end-n);
    B3(n+1:end) = fueraUmbral_on(1:end-n)|B3(n+1:end);
    
    B4(1:end-n) = fueraUmbral_rdown(n+1:end)|B4(1:end-n);
    B4(n+1:end) = fueraUmbral_rdown(1:end-n)|B4(n+1:end);
    
    B5(1:end-n) = fueraUmbral_post(n+1:end)|B5(1:end-n);
    B5(n+1:end) = fueraUmbral_post(1:end-n)|B5(n+1:end);
    
end
%%
fueraUmbral_pre = B1|fueraUmbral_pre;
entre_sinfueraUmbral_pre = (~fueraUmbral_pre & entreUmbral_pre) & (~fueraUmbral_pre | entreUmbral_pre);
data_all_changed(fueraUmbral_pre) = mean(data(entre_sinfueraUmbral_pre));
%%

fueraUmbral_rup = B2|fueraUmbral_rup;
entre_sinfueraUmbral_rup = (~fueraUmbral_rup & entreUmbral_rup) & (~fueraUmbral_rup | entreUmbral_rup);
data_all_changed(fueraUmbral_rup) = mean(data(entre_sinfueraUmbral_rup));
%%

fueraUmbral_on = B3|fueraUmbral_on;
entre_sinfueraUmbral_on = (~fueraUmbral_on & entreUmbral_on) & (~fueraUmbral_on | entreUmbral_on);
data_all_changed(fueraUmbral_on) = mean(data(entre_sinfueraUmbral_on));
%%

fueraUmbral_rdown = B4|fueraUmbral_rdown;
entre_sinfueraUmbral_rdown = (~fueraUmbral_rdown & entreUmbral_rdown) & (~fueraUmbral_rdown | entreUmbral_rdown);
data_all_changed(fueraUmbral_rdown) = mean(data(entre_sinfueraUmbral_rdown));
%%

fueraUmbral_post = B5|fueraUmbral_post;
entre_sinfueraUmbral_post = (~fueraUmbral_post & entreUmbral_post) & (~fueraUmbral_post | entreUmbral_post);
data_all_changed(fueraUmbral_post) = mean(data(entre_sinfueraUmbral_post));

end