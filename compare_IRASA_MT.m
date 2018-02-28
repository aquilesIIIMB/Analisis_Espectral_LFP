data_1 = registroLFP.area(2).data;
data_2 = registroLFP.area(4).data;

%% Multitaper
% Datos de los parametros usados para calcular los multitapers (Chronux)
params.tapers = ([4 7]); % [TW K], (K <= to 2TW-1)
params.pad = 2; % Cantidad de puntos multiplos de dos sobre el largo de la sennal
params.Fs = 1000; % Frecuencia de muestreo
params.fpass = [0.1 100]; % Rango de frecuencias
params.err = 0; % Error considerado
trialave = 0; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

% Datos para definir el ventaneo y avance de las ventanas en multitaper
window = 1; % Ventanas (En segundos)
winstep = window/2; % Pasos de ventanas (segundos)

[Spectrogram_MT,time_MT,freq_MT] = mtspecgramc(data, [window winstep], params);

%-------------------Plot---Mean Spectrogram------------------------------------
Spectrogram = Spectrogram_MT;
time = time_MT;
freq = freq_MT;
fig_MT = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(Spectrogram',1,numel(Spectrogram)),[5 99]);
imagesc(time,freq,Spectrogram',clim);
cmap = colormap(parula(40));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([0.1 100])
c=colorbar('southoutside');
%caxis([-1 1])
ylabel(c,'Normalized Power [dBPink]', 'FontSize', 17)
set(c,'fontsize',17)

%% IRASA
% Datos de los parametros usados para calcular los IRASA
params.Fs = 1000; % Frecuencia de muestreo
params.fpass = [0.1 100]; % Rango de frecuencias

% Datos para definir el ventaneo y avance de las ventanas en multitaper
window = 1; % Ventanas (En segundos)
winstep = window/2; % Pasos de ventanas (segundos)

[irasa, phase] = irasaspecgram(data, [window winstep], params);
    
%-------------------Plot---Mean Spectrogram------------------------------------
Spectrogram = irasa.osci';
time = irasa.time;
freq = irasa.freq;
fig_IRASA = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(Spectrogram',1,numel(Spectrogram)),[5 99]);
imagesc(time,freq,Spectrogram',clim);
cmap = colormap(parula(40));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([0.1 100])
c=colorbar('southoutside');
%caxis([-1 1])
ylabel(c,'Normalized Power [dBPink]', 'FontSize', 17)
set(c,'fontsize',17)

figure;
plot(freq, Spectrogram')

%% Coherence
% Datos de los parametros usados para calcular los IRASA
params.Fs = 1000; % Frecuencia de muestreo
params.fpass = [0.1 100]; % Rango de frecuencias

% Datos para definir el ventaneo y avance de las ventanas en multitaper
window = 1; % Ventanas (En segundos)
winstep = window/2; % Pasos de ventanas (segundos)

[irasa_1, phase_1] = irasaspecgram(data_1, [window winstep], params);
[irasa_2, phase_2] = irasaspecgram(data_2, [window winstep], params);

min_osci = min([min(min(irasa_1.osci)),min(min(irasa_2.osci))]);
irasa_1.osci = irasa_1.osci - min_osci;
irasa_2.osci = irasa_2.osci - min_osci;

%cross_s = irasa_1.osci.*irasa_2.osci.*exp((phase_1-phase_2).*1i);
%coh = abs(cross_s)./sqrt(((abs(irasa_1.osci.*exp(phase_1.*1i)).^2).*(abs(irasa_2.osci.*exp(phase_2.*1i)).^2)));
%coh = abs(cross_s)./sqrt((irasa_1.osci.^2).*(irasa_2.osci.^2));

range_time = (time < 6*60);
%range_time = (time > 7*60 & time < 12*60);
%range_time = (time < 13*60);
J1 = irasa_1.frac(:,range_time).*exp(phase_1(:,range_time).*1i);
J2 = irasa_2.frac(:,range_time).*exp(phase_2(:,range_time).*1i);
S12=(J1.*conj(J2));
S1=abs(J1).^2;
S2=abs(J2).^2;
C12=sum(S12,2)./sqrt(sum(S1,2).*sum(S2,2));
coh = abs(C12); 
%coh = coh./max(max(coh));

%-------------------Plot---Mean Spectrogram------------------------------------
Spectrogram = sqrt(((irasa_1.osci.^2).*(irasa_2.osci.^2)))';
%Spectrogram = irasa_1.osci';
%Spectrogram = irasa_2.osci';
%Spectrogram = abs(cross_s)';
Spectrogram = phase_2';
time = irasa_1.time;
freq = irasa_1.freq;
fig_IRASA = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(Spectrogram',1,numel(Spectrogram)),[5 99]);
imagesc(time,freq,Spectrogram',clim);
cmap = colormap(parula(40));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([0.1 100])
c=colorbar('southoutside');
%caxis([-1 1])
ylabel(c,'Normalized Power [dBPink]', 'FontSize', 17)
set(c,'fontsize',17)

figure;
plot(freq, Spectrogram')

% Coh
figure;
plot(freq, mean(Spectrogram((time < 6*60),:))');
hold on;
plot(freq, mean(Spectrogram((time > 7*60 & time < 12*60),:))');
hold on;
plot(freq, mean(Spectrogram((time < 13*60),:))');
legend('Pre-stim', 'On-stim', 'Post-stim')
xlim([0, 60])


% Coh with max
figure;
plot(freq, max(Spectrogram((time < 6*60),:))','LineWidth',3);
hold on;
plot(freq, max(Spectrogram((time > 7*60 & time < 12*60),:))','LineWidth',2);
hold on;
plot(freq, max(Spectrogram((time < 13*60),:))','LineWidth',1);
legend('Pre-stim', 'On-stim', 'Post-stim')
xlim([0, 60])