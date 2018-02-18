%% Example of ECoG data
% set parameter
srate = 1000; % sampling frequency
movingwin = [3 1]; % [window size, sliding step]
frange = [1 100];
win = movingwin(1)*srate;
step = movingwin(2)*srate;

% load ECoG data from one sensor recorded in the left occipital of one
% macaque in eyes-closed awake state, totally 5 mins
load('ECoG_data.mat');

% separate fractal and oscillatory components using sliding window
nwin = floor((length(data) - win)/step);
sig = zeros(win,nwin);
for i = 1 : nwin
    sig(:,i) = data(ceil((i-1)*step)+1 : ceil((i-1)*step)+win);
end
tic
Frac = amri_sig_fractal(sig,srate,'detrend',1,'frange',frange);
Frac.time = (0:step/srate:step*(nwin-1)/srate)';
toc

% fitting power-law function to the fractal power spectra
Frange = [15, 100]; % define frequency range for power-law fitting
Frac = amri_sig_plawfit(Frac,Frange);

% show averaged fractal and oscillatory power spectrum
figure;
subplot(2,1,1);
loglog(Frac.freq,mean(Frac.mixd,2),'b'); hold on
loglog(Frac.freq,mean(Frac.frac,2),'r');
subplot(2,1,2);
plot(Frac.freq, mean(Frac.osci,2));


%% Spect to time
spect_MT = registroLFP.average_spectrum(1).spectrogram.data_raw;

size_t = size(spect_MT, 1);
size_f = size(spect_MT, 2);
signal_reco = ifft(spect_MT(1, :),4*1000, 'symmetric');

for i = 2:size_t
    y = ifft(spect_MT(i, :),4*1000, 'symmetric');
    signal_reco = [signal_reco(1:end-2*1000), mean([signal_reco(end-2*1000+1:end);y(1:2*1000)]), y(2*1000+1:end)];
end



%% Test con mis datos
% set parameter
srate = 1000; % sampling frequency
movingwin = [4 2]; % [window size, sliding step]
frange = [0.1 100];
win = movingwin(1)*srate;
step = movingwin(2)*srate;

% load ECoG data from one sensor recorded in the left occipital of one
% macaque in eyes-closed awake state, totally 5 mins
%R = L+5;
data = registroLFP.area(1).data;

% separate fractal and oscillatory components using sliding window
nwin = floor((length(data) - win)/step);
sig = zeros(win,nwin);
for i = 1 : nwin
    sig(:,i) = data(ceil((i-1)*step)+1 : ceil((i-1)*step)+win);
end
tic
Frac = amri_sig_fractal(sig,srate,'detrend',1,'frange',frange);
Frac.time = (0:step/srate:step*(nwin-1)/srate)';
toc

% fitting power-law function to the fractal power spectra
Frange = [15, 100]; % define frequency range for power-law fitting
Frac = amri_sig_plawfit(Frac,Frange);

% show averaged fractal and oscillatory power spectrum
figure;
subplot(2,1,1);
loglog(Frac.freq,mean(Frac.mixd,2),'b'); hold on
loglog(Frac.freq,mean(Frac.frac,2),'r');
subplot(2,1,2);
plot(Frac.freq, mean(Frac.osci,2));

% Spectrogram
%-------------------Plot---Mean Spectrogram------------------------------------
Spectrogram_mean = Frac.osci';
t_Spectrogram_mean = Frac.time;
f_Spectrogram_mean = Frac.freq;
fig_8 = figure('units','normalized','outerposition',[0 0 1 1]);
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
ylabel(c,'Normalized Power [dBPink]', 'FontSize', 17)
set(c,'fontsize',17)


% PSD
figure;
plot(Frac.freq, mean(Frac.osci(:,(Frac.time < 6*60)), 2));
hold on;
plot(Frac.freq, mean(Frac.osci(:,(Frac.time > 7*60 & Frac.time < 12*60)), 2));
hold on;
plot(Frac.freq, mean(Frac.osci(:,(Frac.time < 13*60)), 2));
legend('Pre-stim', 'On-stim', 'Post-stim')
xlim([0, 40])

% Para calcular la energia de la banda
min_psd = min([min(psd_pre),min(psd_on),min(psd_post)]);

