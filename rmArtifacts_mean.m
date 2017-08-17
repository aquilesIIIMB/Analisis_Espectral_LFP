function [data_all_changed, fueraUmbral_propag_logical] = rmArtifacts_mean(data,umbral,time_step_m_tiempoTotal,pre_m,on_inicio_m, on_final_m, post_m)

data_all_changed = data;
largo_data = length(data);
x = 0:1/1000:largo_data/1000-1/1000;
s=(10^-2)*sin(2*pi*90*x);
shift_left = 1000; % 50 100
shift_right = 2500; % 50 200
%%
fueraUmbral_pre = (((data > umbral) | (data < -umbral)) & (time_step_m_tiempoTotal < pre_m)');
ind_s = find(fueraUmbral_pre)-shift_left; % Determinar los indices segun posicion menos el corrieminto a la izq
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
fueraUmbral_propag_post = x(:); %Son indices
%% 
%fueraUmbral = (fueraUmbral_pre | fueraUmbral_rup | fueraUmbral_on | fueraUmbral_rdown | fueraUmbral_post); 
fueraUmbral_propag_logical = zeros(largo_data,1);
fueraUmbral_propag_ind = unique([fueraUmbral_propag_pre;fueraUmbral_propag_rup;fueraUmbral_propag_on;fueraUmbral_propag_rdown;fueraUmbral_propag_post]);
fueraUmbral_propag_logical(fueraUmbral_propag_ind) = 1;
fueraUmbral_propag_logical = (fueraUmbral_propag_logical > 0);
%%
%B = zeros(size(data));
%B(fueraUmbral_propag_pre) = 1;
%entre_sinfueraUmbral_pre = ~B;
%data_all_changed(fueraUmbral_propag_pre) = mean(data(entre_sinfueraUmbral_pre));
data_all_changed(unique(fueraUmbral_propag_pre)) = s(1:length(unique(fueraUmbral_propag_pre)));
%%
%B = zeros(size(data));
%B(fueraUmbral_propag_rup) = 1;
%entre_sinfueraUmbral_rup = ~B;
%data_all_changed(fueraUmbral_propag_rup) = mean(data(entre_sinfueraUmbral_rup));
data_all_changed(unique(fueraUmbral_propag_rup)) = s(1:length(unique(fueraUmbral_propag_rup)));
%%
%B = zeros(size(data));
%B(fueraUmbral_propag_on) = 1;
%entre_sinfueraUmbral_on = ~B;
%data_all_changed(fueraUmbral_propag_on) = mean(data(entre_sinfueraUmbral_on));
data_all_changed(unique(fueraUmbral_propag_on)) = s(1:length(unique(fueraUmbral_propag_on)));
%%
%B = zeros(size(data));
%B(fueraUmbral_propag_rdown) = 1;
%entre_sinfueraUmbral_rdown = ~B;
%data_all_changed(fueraUmbral_propag_rdown) = mean(data(entre_sinfueraUmbral_rdown));
data_all_changed(unique(fueraUmbral_propag_rdown)) = s(1:length(unique(fueraUmbral_propag_rdown)));
%%
%B = zeros(size(data));
%B(fueraUmbral_propag_post) = 1;
%entre_sinfueraUmbral_post = ~B;
%data_all_changed(fueraUmbral_propag_post) = mean(data(entre_sinfueraUmbral_post));
data_all_changed(unique(fueraUmbral_propag_post)) = s(1:length(unique(fueraUmbral_propag_post)));
%%
%x=linspace(0,19.4,largo_data);
%s=1*sin(2*pi*300*x);
%data_all_changed=data_all_changed.*s;
%entre_sinfueraUmbral = (entre_sinfueraUmbral_pre | entre_sinfueraUmbral_rup | entre_sinfueraUmbral_on | entre_sinfueraUmbral_rdown | entre_sinfueraUmbral_post); 
%x = 0:1/1000:largo_data/1000-1/1000;
%s=(10^-2)*sin(2*pi*200*x);
%data_all_changed(entre_sinfueraUmbral)=s(1:length(entre_sinfueraUmbral));
%calcular el largo del umbral
end

