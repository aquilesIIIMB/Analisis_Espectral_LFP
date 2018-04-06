window = 1; %1s
winstep = window / 2;
params.Fs = 1000; % Frecuencia de muestreo
params.fpass = [0.1 100]; % Rango de frecuencias

% irasa es una estructura donde esta el espectrograma mixto, fractal y oscilatorio
irasa = irasaspecgram(data,[window winstep], params);

% Para graficar el Spectrograma mixto
Spectrogram_mean = irasa.mixd';
t_Spectrogram_mean = irasa .time;
f_Spectrogram_mean = irasa .freq;
fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(Spectrogram_mean',1,numel(Spectrogram_mean)),[5 99]);
imagesc(t_Spectrogram_mean,f_Spectrogram_mean,Spectrogram_mean',clim);
cmap = colormap(parula(40));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([1 100])
c=colorbar('southoutside');
%caxis([-1 1])
ylabel(c,'Power [W/Hz]', 'FontSize', 17)
set(c,'fontsize',17)

% Para graficar el Spectrograma de fractales o scale-free (señales arritmicas)
Spectrogram_mean = irasa.frac';
t_Spectrogram_mean = irasa .time;
f_Spectrogram_mean = irasa .freq;
fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(Spectrogram_mean',1,numel(Spectrogram_mean)),[5 99]);
imagesc(t_Spectrogram_mean,f_Spectrogram_mean,Spectrogram_mean',clim);
cmap = colormap(parula(40));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([1 100])
c=colorbar('southoutside');
%caxis([-1 1])
ylabel(c,'Power [W/Hz]', 'FontSize', 17)
set(c,'fontsize',17)

% Para graficar el Spectrograma de Oscilaciones
Spectrogram_mean = irasa.osci';
t_Spectrogram_mean = irasa .time;
f_Spectrogram_mean = irasa .freq;
fig_3 = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(Spectrogram_mean',1,numel(Spectrogram_mean)),[5 99]);
imagesc(t_Spectrogram_mean,f_Spectrogram_mean,Spectrogram_mean',clim);
cmap = colormap(parula(40));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([1 100])
c=colorbar('southoutside');
%caxis([-1 1])
ylabel(c,'Power [W/Hz]', 'FontSize', 17)
set(c,'fontsize',17)