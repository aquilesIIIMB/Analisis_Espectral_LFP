function [data_all_changed, fueraUmbral] = rmArtifacts_mean(data,umbral,time_step_m_tiempoTotal,pre_m,on_inicio_m, on_final_m, post_m)

data_all_changed = data;
shift_left = 50; % 50
shift_right = 50; % 50
%%
fueraUmbral_pre = (((data > umbral) | (data < -umbral)) & (time_step_m_tiempoTotal < pre_m)');
ind_s = find(fueraUmbral_pre)-shift_left;
ind_e = find(fueraUmbral_pre)+shift_right;
indx = [ind_s,ind_e];
o = int2str(indx(:,1));
p = int2str(indx(:,2));
x =strcat(strcat(strcat(strcat(o),':'),p),',');
x = str2num(x);
fueraUmbral_propag_pre = x(:);
%%
fueraUmbral_rup = ((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > pre_m) & (time_step_m_tiempoTotal < on_inicio_m))');
ind_s = find(fueraUmbral_rup)-shift_left;
ind_e = find(fueraUmbral_rup)+shift_right;
indx = [ind_s,ind_e];
o = int2str(indx(:,1));
p = int2str(indx(:,2));
x =strcat(strcat(strcat(strcat(o),':'),p),',');
x = str2num(x);
fueraUmbral_propag_rup = x(:);
%%
fueraUmbral_on = ((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > on_inicio_m) & (time_step_m_tiempoTotal < on_final_m))');
ind_s = find(fueraUmbral_on)-shift_left;
ind_e = find(fueraUmbral_on)+shift_right;
indx = [ind_s,ind_e];
o = int2str(indx(:,1));
p = int2str(indx(:,2));
x =strcat(strcat(strcat(strcat(o),':'),p),',');
x = str2num(x);
fueraUmbral_propag_on = x(:);
%%
fueraUmbral_rdown = ((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > on_final_m) & (time_step_m_tiempoTotal < post_m))');
ind_s = find(fueraUmbral_rdown)-shift_left;
ind_e = find(fueraUmbral_rdown)+shift_right;
indx = [ind_s,ind_e];
o = int2str(indx(:,1));
p = int2str(indx(:,2));
x =strcat(strcat(strcat(strcat(o),':'),p),',');
x = str2num(x);
fueraUmbral_propag_rdown = x(:);
%%
fueraUmbral_post = ((data > umbral) | (data < -umbral) & (time_step_m_tiempoTotal > post_m)');
ind_s = find(fueraUmbral_post)-shift_left;
ind_e = find(fueraUmbral_post)+shift_right;
indx = [ind_s,ind_e];
o = int2str(indx(:,1));
p = int2str(indx(:,2));
x =strcat(strcat(strcat(strcat(o),':'),p),',');
x = str2num(x);
fueraUmbral_propag_post = x(:);
%% 
fueraUmbral = (fueraUmbral_pre | fueraUmbral_rup | fueraUmbral_on | fueraUmbral_rdown | fueraUmbral_post); 
%%
B = zeros(size(data));
B(fueraUmbral_propag_pre) = 1;
entre_sinfueraUmbral_pre = ~B;
data_all_changed(fueraUmbral_propag_pre) = mean(data(entre_sinfueraUmbral_pre));
%%
B = zeros(size(data));
B(fueraUmbral_propag_rup) = 1;
entre_sinfueraUmbral_rup = ~B;
data_all_changed(fueraUmbral_propag_rup) = mean(data(entre_sinfueraUmbral_rup));
%%
B = zeros(size(data));
B(fueraUmbral_propag_on) = 1;
entre_sinfueraUmbral_on = ~B;
data_all_changed(fueraUmbral_propag_on) = mean(data(entre_sinfueraUmbral_on));
%%
B = zeros(size(data));
B(fueraUmbral_propag_rdown) = 1;
entre_sinfueraUmbral_rdown = ~B;
data_all_changed(fueraUmbral_propag_rdown) = mean(data(entre_sinfueraUmbral_rdown));
%%
B = zeros(size(data));
B(fueraUmbral_propag_post) = 1;
entre_sinfueraUmbral_post = ~B;
data_all_changed(fueraUmbral_propag_post) = mean(data(entre_sinfueraUmbral_post));

end

