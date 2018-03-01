 

idx = combntns([1,2,3,4,5],2);

for i = 1:length(idx)
    idx_1 = idx(i,1);
    idx_2 = idx(i,2);
    
    s1 = registroLFP.areas(idx_1).data;
    s2 = registroLFP.areas(idx_2).data;
    time = registroLFP.times.steps_m;

    % Datos de los parametros usados para calcular los multitapers (Chronux)
    params.tapers = ([8 7]); % [TW K], (K <= to 2TW-1)
    params.pad = 2; % Cantidad de puntos multiplos de dos sobre el largo de la sennal
    params.Fs = registroLFP.desired_fs; % Frecuencia de muestreo
    params.fpass = [0.1 100]; % Rango de frecuencias
    params.err = 0; % Error considerado
    params.trialave = 0; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

    % Datos para definir el ventaneo y avance de las ventanas en multitaper
    movingwin.window = 8; % Ventanas (En segundos)
    movingwin.winstep = movingwin.window/2; % Pasos de ventanas (segundos)

    data1 = s1(time<6); % (time>6 & time<12)
    data2 = s2(time<6); % (time>6 & time<12)
    %[C,phi,S12,S1,S2,f]=coherencyc(data1,data2,params);

    %[C,phi,S12,S1,S2,f]=coherencyc(data1,data2,params);


    [s_pre, c_pre, ph_pre, ci_pre, phi_pre] = cmtm(data1,data2,1/1000,60,1,0,0);


    data1 = s1(time>6 & time<12);
    data2 = s2(time>6 & time<12);

    [s_on, c_on, ph_on, ci_on, phi_on] = cmtm(data1,data2,1/1000,60,1,0,0);


    data1 = s1(time>13); % (time>6 & time<12)
    data2 = s2(time>13); % (time>6 & time<12)

    [s_post, c_post, ph_post, ci_post, phi_post] = cmtm(data1,data2,1/1000,60,1,0,0);

    dt = 1/500;

    %figure;
    N = length(c_pre);
    f_pre = (0:1/(N*dt):1/dt-1/(N*dt))';
    %plot(f_pre,c_pre)
    %hold on
    N = length(c_on);
    f_on = (0:1/(N*dt):1/dt-1/(N*dt))';
    %plot(f_on,c_on)
    N = length(c_post);
    f_post = (0:1/(N*dt):1/dt-1/(N*dt))';
    %plot(f_post,c_post)

    %[sum_MSC_delta, coupling_strength_delta, delay_delta] = coherence_measurements(registroLFP, [1, 4], [false, false, false], true, path);
    %titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in Bp band [8, 30] Hz'}]);
    %titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in Bp band [8, 30] Hz'}]);
    %graph_motorcircuit(coupling_strength_delta, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

    figure;
    plot(mean(c_pre(f_pre>8 & f_pre<30)),'O')
    hold on
    plot(mean(c_on(f_on>8 & f_on<30)),'O')
    plot(mean(c_post(f_post>8 & f_post<30)),'O')
    title('Izquierda')
    
    % derecha
    
    s1 = registroLFP.areas(idx_1+5).data;
    s2 = registroLFP.areas(idx_2+5).data;
    time = registroLFP.times.steps_m;

    % Datos de los parametros usados para calcular los multitapers (Chronux)
    params.tapers = ([8 7]); % [TW K], (K <= to 2TW-1)
    params.pad = 2; % Cantidad de puntos multiplos de dos sobre el largo de la sennal
    params.Fs = registroLFP.desired_fs; % Frecuencia de muestreo
    params.fpass = [0.1 100]; % Rango de frecuencias
    params.err = 0; % Error considerado
    params.trialave = 0; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

    % Datos para definir el ventaneo y avance de las ventanas en multitaper
    movingwin.window = 8; % Ventanas (En segundos)
    movingwin.winstep = movingwin.window/2; % Pasos de ventanas (segundos)

    data1 = s1(time<6); % (time>6 & time<12)
    data2 = s2(time<6); % (time>6 & time<12)
    %[C,phi,S12,S1,S2,f]=coherencyc(data1,data2,params);

    %[C,phi,S12,S1,S2,f]=coherencyc(data1,data2,params);


    [s_pre, c_pre, ph_pre, ci_pre, phi_pre] = cmtm(data1,data2,1/1000,60,1,0,0);


    data1 = s1(time>6 & time<12);
    data2 = s2(time>6 & time<12);

    [s_on, c_on, ph_on, ci_on, phi_on] = cmtm(data1,data2,1/1000,60,1,0,0);


    data1 = s1(time>13); % (time>6 & time<12)
    data2 = s2(time>13); % (time>6 & time<12)

    [s_post, c_post, ph_post, ci_post, phi_post] = cmtm(data1,data2,1/1000,60,1,0,0);

    dt = 1/500;

    %figure;
    N = length(c_pre);
    f_pre = (0:1/(N*dt):1/dt-1/(N*dt))';
    %plot(f_pre,c_pre)
    %hold on
    N = length(c_on);
    f_on = (0:1/(N*dt):1/dt-1/(N*dt))';
    %plot(f_on,c_on)
    N = length(c_post);
    f_post = (0:1/(N*dt):1/dt-1/(N*dt))';
    %plot(f_post,c_post)

    %[sum_MSC_delta, coupling_strength_delta, delay_delta] = coherence_measurements(registroLFP, [1, 4], [false, false, false], true, path);
    titulo_1 = string([{'Coupling Strength graph of left hemisphere'}; {'in Bp band [8, 30] Hz'}]);
    titulo_2 = string([{'Coupling Strength graph of right hemisphere'}; {'in Bp band [8, 30] Hz'}]);
    graph_motorcircuit(coupling_strength_delta, names_areas, path, titulo_1, titulo_2, 'Coupling Strength')

    figure;
    plot(mean(c_pre(f_pre>8 & f_pre<30)),'O')
    hold on
    plot(mean(c_on(f_on>8 & f_on<30)),'O')
    plot(mean(c_post(f_post>8 & f_post<30)),'O')
    title('Derecha')
    
end
