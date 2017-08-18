function salida = pink_noise_del(entrada_x, entrada_y)
% dim(entrada_y) = tiempo x frecuencia
size_time = size(entrada_y,1);
size_frec = size(entrada_y,2);
salida = entrada_y;

mean_spectrum = mean(entrada_y);
p_mean = polyfit(log(entrada_x),log(mean_spectrum),1);
m_mean = p_mean(1);
b_mean = exp(p_mean(2));
modelo_eval_mean = b_mean*entrada_x.^m_mean;  

for i = 1:size_time
    %% Eliminacion del ruido rosa con el promedio del espectro total
    salida(i,:) = entrada_y(i,:)./modelo_eval_mean;
    
    %% Eliminacion del ruido rosa mediante polyfit, modelo a*x.^m (usado antes)
    %[~,Ind_max]=max(entrada_y(i,:));
    %x=entrada_x(Ind_max:size_frec);
    %y=entrada_y(i, Ind_max:size_frec);
    %p = polyfit(log(x),log(y),1);
    %m = p(1);
    %b = exp(p(2));

    %modelo_eval = b*entrada_x.^m;
    %salida(i,:) = entrada_y(i,:)./modelo_eval;

    %ezplot(@(x) b*x.^m,[x(1) x(end)])
    %plot(x,y,'+r'); hold on
    %plot(x,b*x.^m); ylim([min(Spectral_on) max(Spectral_on)])

    %% Eliminacion del ruido rosa mediante fit, modelo a*x.^m
    %%%Malo en ON_STIM porque tiene muchos pulsos en harmonicos del
    %%%estimulo Revisar, porque ahora no funciona
    %[~,Ind_max]=max(entrada_y(i,:));
    %x=entrada_x(Ind_max:end)';
    %y=entrada_y(i,Ind_max:end)';
    %model=fit(x,y,'power1');
    %model_eval = feval(model,entrada_x);
    %model_eval(1) = model_eval(2) + (model_eval(2)+model_eval(3))/2;

    %salida(i,:) = entrada_y(i,:)./model_eval';

    %%Para que no muestre el warning: Power functions require x to be positive. Non-positive data are treated as NaN. 
    %w = warning('query','last');
    %id = w.identifier;
    %warning('off',id)

    %% Eliminacion del ruido rosa mediante 1/f
    %model = 1./entrada_x;
    %salida(i,:) = entrada_y(i,:)./model;
    
    %% No usa el rudio rosa
    %salida(i,:) = entrada_y(i,:);
end

