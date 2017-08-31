function [data_all_changed, fueraUmbral_propag_logical] = rmArtifacts_threshold(data,umbral,time_step_m_tiempoTotal,pre_m,on_inicio_m, on_final_m, post_m, end_m)

data_all_changed = data;
largo_data = length(data);
x = 0:1/1000:largo_data/1000-1/1000;
s=(10^-2)*sin(2*pi*90*x);
shift_left = 1100; % 50 100
shift_right = 2200; % 50 200

%amp = 4;
%umbral = 5*mean(abs(data_ref_artifacted))/0.675;
%%
%umbral = amp*mean(abs(data(time_step_m_tiempoTotal < pre_m)))/0.675;
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
%umbral = amp*mean(abs(data((time_step_m_tiempoTotal > pre_m) & (time_step_m_tiempoTotal < on_inicio_m))))/0.675;
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
%umbral = amp*mean(abs(data((time_step_m_tiempoTotal > on_inicio_m) & (time_step_m_tiempoTotal < on_final_m))))/0.675;
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
%umbral = amp*mean(abs(data((time_step_m_tiempoTotal > on_final_m) & (time_step_m_tiempoTotal < post_m))))/0.675;
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
%umbral = amp*mean(abs(data((time_step_m_tiempoTotal > post_m) & (time_step_m_tiempoTotal < end_m))))/0.675;
fueraUmbral_post = ((data > umbral) | (data < -umbral) & ((time_step_m_tiempoTotal > post_m) & (time_step_m_tiempoTotal < end_m))'); % si falla, sacar el parentesis del end_m
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
fueraUmbral_propag_pre = fueraUmbral_propag_pre(fueraUmbral_propag_pre>0); % Para que no tenga indices negativos
fueraUmbral_propag_post = fueraUmbral_propag_post(fueraUmbral_propag_post<=largo_data); % Para no tener datos sobre el largo de la señal

fueraUmbral_propag_ind = unique([fueraUmbral_propag_pre;fueraUmbral_propag_rup;fueraUmbral_propag_on;fueraUmbral_propag_rdown;fueraUmbral_propag_post]);
fueraUmbral_propag_ind = fueraUmbral_propag_ind((fueraUmbral_propag_ind>0) & (fueraUmbral_propag_ind<=largo_data));

if isempty(fueraUmbral_propag_ind)
    disp('Vacio')
end
fueraUmbral_propag_logical(fueraUmbral_propag_ind) = 1;
fueraUmbral_propag_logical = fueraUmbral_propag_logical(1:largo_data); % Para que no sobrepase el limite de la señal debido al relleno
fueraUmbral_propag_logical = (fueraUmbral_propag_logical > 0);
%%
%data_all_changed(unique(fueraUmbral_propag_pre)) = s(1:length(unique(fueraUmbral_propag_pre)));
%%
%data_all_changed(unique(fueraUmbral_propag_rup)) = s(1:length(unique(fueraUmbral_propag_rup)));
%%
%data_all_changed(unique(fueraUmbral_propag_on)) = s(1:length(unique(fueraUmbral_propag_on)));
%%
%data_all_changed(unique(fueraUmbral_propag_rdown)) = s(1:length(unique(fueraUmbral_propag_rdown)));
%%
%data_all_changed(unique(fueraUmbral_propag_post)) = s(1:length(unique(fueraUmbral_propag_post)));
%%
data_all_changed(fueraUmbral_propag_ind) = s(1:length(fueraUmbral_propag_ind));
%%
data_all_changed = data_all_changed(1:largo_data); % Para que no sobrepase el limite de la señal debido al relleno
end

