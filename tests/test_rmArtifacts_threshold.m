

umbral = 7;
data = randi(10,1,50);

data = data_ref_artifacted;
umbral = registroLFP.channel(canales_eval(j)).threshold;
Fc = registroLFP.frec_sin_artifacts;

data_all_changed = data;
largo_data = length(data);
shift_left = 1100; % 50 100
shift_right = 2200; % 50 200

idx_over_inicial = find(data>umbral);
data_over_logic_inicial = zeros(size(data));
data_over_logic_inicial(idx_over_inicial) = 1;
data_over_logic_final = data_over_logic_inicial;
%idx_over_inicial

disp('Entro al shift_left')
for i = 1:shift_left
    idx_over_now = find(data_over_logic_inicial > 0) - i;
    idx_over_now = unique(idx_over_now);
    idx_over_now = idx_over_now(idx_over_now >= 0 & idx_over_now <= largo_data);
    data_over_logic_final(idx_over_now) = 1;
end
%idx_over_final

disp('Entro al shift_right')
for i = 1:shift_right
    idx_over_now = find(data_over_logic_inicial > 0) + i;
    idx_over_now = unique(idx_over_now);
    idx_over_now = idx_over_now(idx_over_now >= 0 & idx_over_now <= largo_data);
    data_over_logic_final(idx_over_now) = 1;
end
idx_over_final = find(data_over_logic_final > 0);
disp('Salio del shift')


