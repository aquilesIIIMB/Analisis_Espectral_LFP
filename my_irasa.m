
function pfractal = my_irasa(x,fpass,Fs,TW_K,padding)
h = 1.1:.05:1.9;

% Datos de los parametros usados para calcular los multitapers (Chronux)
params.tapers = (TW_K); % [TW K], (K <= to 2TW-1)
params.pad = padding; % Cantidad de puntos multiplos de dos sobre el largo de la sennal
params.Fs = Fs; % Frecuencia de muestreo
params.fpass = fpass; % Rango de frecuencias
params.err = 0; % Error considerado
params.trialave = 0; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada


nh = numel(h);
%pg = zeros(length(f),nh);
pg = [];
for i = 1:nh
    [p,q] = rat(h(i));

    % Fractionally downsampled
    xh = resample(x,p,q);
    %ph = mtspectrum(xh,'thbw',nw,'f',f,'Fs',Fs,'quadratic',quad);
    ph = mtspectrumc(xh,params);

    % Fractionally upsampled
    x1h = resample(x,q,p);
    %p1h = mtspectrum(x1h,'thbw',nw,'f',f,'Fs',Fs,'quadratic',quad);
    p1h = mtspectrumc(x1h,params);

    % Geometric mean
    pg = [pg; sqrt(ph.*p1h)];
end

pfractal = median(pg,2);

end