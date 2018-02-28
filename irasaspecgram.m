function [irasa, phase] = irasaspecgram(data, movingwin, params)

% set parameter
srate = params.Fs; % sampling frequency
frange = params.fpass;
win = movingwin(1)*srate;
step = movingwin(2)*srate;

% separate fractal and oscillatory components using sliding window
nwin = floor((length(data) - win)/step);
sig = zeros(win,nwin);
for i = 1 : nwin
    sig(:,i) = data(ceil((i-1)*step)+1 : ceil((i-1)*step)+win);
end
tic
irasa = amri_sig_fractal(sig,srate,'detrend',1,'frange',frange);
irasa.time = (0:step/srate:step*(nwin-1)/srate)';
toc

% fitting power-law function to the fractal power spectra
%Frange = [1, 100]; % define frequency range for power-law fitting
Frange = frange;
irasa = amri_sig_plawfit(irasa,Frange);

% show averaged fractal and oscillatory power spectrum
%figure;
%subplot(2,1,1);
%loglog(Frac.freq,mean(Frac.mixd,2),'b'); hold on
%loglog(Frac.freq,mean(Frac.frac,2),'r');
%subplot(2,1,2);
%plot(irasa.freq, mean(irasa.osci,2));


end