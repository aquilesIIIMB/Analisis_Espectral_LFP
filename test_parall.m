data = zeros(length(data),16);
data_filt= zeros(length(data),16);
data_downS_aux = zeros(round(length(data)/30)+1,32);
%data_downS = zeros(round(length(data)/30)+1,64);
data_downS = zeros(round(length(data)/30)+1,32);
p = 0;
tic;
%for j=1:2
    %parfor i=1:16
        %ruta_regEval = [ruta_con100,int2str(canales_eval(i)),'.continuous'];
        %disp([ruta_con100,int2str(canales_eval(16*(j-1)+i)),'.continuous'])
        %[data(:,i), ~, ~] = load_open_ephys_data_faster(strtrim([path,[ruta_con100,int2str(canales_eval(16*(j-1)+i)),'.continuous']]));
        %Hd = design(d,'butter');
        %data_filt(:,i) = filter(Hd,data(:,i));
        %data_downS_aux(:,i) = downsample(data(:,i),simpleRate/REGISTRO.desiredSimpleRate);
    %end
    %p=p+16;
    %data_downS(:,p*(j-1)+1:j*p) = data_downS_aux;
%end
fNyq = simpleRate/2;
[b,a] = butter(20,[REGISTRO.filter_param.fc1 REGISTRO.filter_param.fc2]./fNyq,'bandpass');
parfor i=1:16
    %ruta_regEval = [ruta_con100,int2str(canales_eval(i)),'.continuous'];
    disp([ruta_con100,int2str(canales_eval(i)),'.continuous'])
    [data(:,i), ~, ~] = load_open_ephys_data_faster(strtrim([path,[ruta_con100,int2str(canales_eval(i)),'.continuous']]));
    %Hd = design(d,'butter');
    data_filt(:,i) = filter(b,a,data(:,i));
    data_downS_aux(:,i) = downsample(data(:,i),simpleRate/REGISTRO.desiredSimpleRate);
end

parfor i=1:16
    %ruta_regEval = [ruta_con100,int2str(canales_eval(i)),'.continuous'];
    disp([ruta_con100,int2str(canales_eval(16+i)),'.continuous'])
    [data(:,i), ~, ~] = load_open_ephys_data_faster(strtrim([path,[ruta_con100,int2str(canales_eval(16+i)),'.continuous']]));
    %Hd = design(d,'butter');
    data_filt(:,i) = filter(b,a,data(:,i));
    data_downS_aux(:,16+i) = downsample(data(:,i),simpleRate/REGISTRO.desiredSimpleRate);
end
toc;