function power_ranking_table = power_ranking_gen(power_ranking,measurementsLFP,protocolo_name,injured_area)

LastName = {'Name','Protocol','NoLesion_Pre','Lesion_Pre','Lesion_Diff_PreOn','Lesion_Diff_PrePost','Mean_Lesion_Diff_PreOn','Mean_Lesion_Diff_PrePost'};

power_left_osci = [];
power_right_osci = [];
power_left_osci_norm = [];
power_right_osci_norm = [];
power_left_frac = [];
power_right_frac = [];
power_left_frac_norm = [];
power_right_frac_norm = [];
power_left_frac_total = [];
power_right_frac_total = [];

for i = 1:length(measurementsLFP.left.power_band)
    power_left_osci = [power_left_osci; measurementsLFP.left.power_band(i).oscillations(7).pre, measurementsLFP.left.power_band(i).oscillations(7).on, measurementsLFP.left.power_band(i).oscillations(7).post];
    power_right_osci = [power_right_osci; measurementsLFP.right.power_band(i).oscillations(7).pre, measurementsLFP.right.power_band(i).oscillations(7).on, measurementsLFP.right.power_band(i).oscillations(7).post];
    
    power_left_osci_norm = [power_left_osci_norm; measurementsLFP.left.power_band(i).oscillations(7).pre_norm, measurementsLFP.left.power_band(i).oscillations(7).on, measurementsLFP.left.power_band(i).oscillations(7).post_norm];
    power_right_osci_norm = [power_right_osci_norm; measurementsLFP.right.power_band(i).oscillations(7).pre_norm, measurementsLFP.right.power_band(i).oscillations(7).on, measurementsLFP.right.power_band(i).oscillations(7).post_norm];
    
    power_left_frac = [power_left_frac; measurementsLFP.left.power_band(i).fractals(7).pre, measurementsLFP.left.power_band(i).fractals(7).on, measurementsLFP.left.power_band(i).fractals(7).post];
    power_right_frac = [power_right_frac; measurementsLFP.right.power_band(i).fractals(7).pre, measurementsLFP.right.power_band(i).fractals(7).on, measurementsLFP.right.power_band(i).fractals(7).post];
    
    power_left_frac_norm = [power_left_frac_norm; measurementsLFP.left.power_band(i).fractals(7).pre_norm, measurementsLFP.left.power_band(i).fractals(7).on_norm, measurementsLFP.left.power_band(i).fractals(7).post_norm];
    power_right_frac_norm = [power_right_frac_norm; measurementsLFP.right.power_band(i).fractals(7).pre_norm, measurementsLFP.right.power_band(i).fractals(7).on_norm, measurementsLFP.right.power_band(i).fractals(7).post_norm];
    
    power_left_frac_total = [power_left_frac_total; measurementsLFP.left.power_total(i).fractals.pre, measurementsLFP.left.power_total(i).fractals.on, measurementsLFP.left.power_total(i).fractals.post];
    power_right_frac_total = [power_right_frac_total; measurementsLFP.right.power_total(i).fractals.pre, measurementsLFP.right.power_total(i).fractals.on, measurementsLFP.right.power_total(i).fractals.post];
    
end

Name = {measurementsLFP.register_checked};
Protocolo = {protocolo_name};

%Oscillations
if strcmp(injured_area, 'L')
    NoLesion_Pre = power_right_osci(:,1);
    Lesion_Pre = power_left_osci(:,1);
    Lesion_Diff_PreOn = power_left_osci(:,1) - power_left_osci(:,2);
    Lesion_Diff_PrePost = power_left_osci(:,1) - power_left_osci(:,3); 

elseif strcmp(injured_area, 'R')
    NoLesion_Pre = power_left_osci(:,1);
    Lesion_Pre = power_right_osci(:,1);
    Lesion_Diff_PreOn = power_right_osci(:,1) - power_right_osci(:,2);
    Lesion_Diff_PrePost = power_right_osci(:,1) - power_right_osci(:,3); 
    
else
    warning('Unknowed hemisphere')
end

power_ranking_osci_now = table(Name, Protocolo, NoLesion_Pre', Lesion_Pre', Lesion_Diff_PreOn', Lesion_Diff_PrePost',mean(Lesion_Diff_PreOn), mean(Lesion_Diff_PrePost),'VariableNames',LastName);
power_ranking.power_ranking_osci = sortrows([power_ranking.power_ranking_osci;power_ranking_osci_now],[7 8],'descend');

%Oscillations Norm
if strcmp(injured_area, 'L')
    NoLesion_Pre = power_right_osci_norm(:,1);
    Lesion_Pre = power_left_osci_norm(:,1);
    Lesion_Diff_PreOn = power_left_osci_norm(:,1) - power_left_osci_norm(:,2);
    Lesion_Diff_PrePost = power_left_osci_norm(:,1) - power_left_osci_norm(:,3); 

elseif strcmp(injured_area, 'R')
    NoLesion_Pre = power_left_osci_norm(:,1);
    Lesion_Pre = power_right_osci_norm(:,1);
    Lesion_Diff_PreOn = power_right_osci_norm(:,1) - power_right_osci_norm(:,2);
    Lesion_Diff_PrePost = power_right_osci_norm(:,1) - power_right_osci_norm(:,3); 
    
else
    warning('Unknowed hemisphere')
end

power_ranking_osci_norm_now = table(Name, Protocolo, NoLesion_Pre', Lesion_Pre', Lesion_Diff_PreOn', Lesion_Diff_PrePost',mean(Lesion_Diff_PreOn), mean(Lesion_Diff_PrePost),'VariableNames',LastName);
power_ranking.power_ranking_osci_norm = sortrows([power_ranking.power_ranking_osci_norm;power_ranking_osci_norm_now],[7 8],'descend');

% Fractals
if strcmp(injured_area, 'L')
    NoLesion_Pre = power_right_frac(:,1);
    Lesion_Pre = power_left_frac(:,1);
    Lesion_Diff_PreOn = power_left_frac(:,1) - power_left_frac(:,2);
    Lesion_Diff_PrePost = power_left_frac(:,1) - power_left_frac(:,3); 

elseif strcmp(injured_area, 'R')
    NoLesion_Pre = power_left_frac(:,1);
    Lesion_Pre = power_right_frac(:,1);
    Lesion_Diff_PreOn = power_right_frac(:,1) - power_right_frac(:,2);
    Lesion_Diff_PrePost = power_right_frac(:,1) - power_right_frac(:,3); 
    
else
    warning('Unknowed hemisphere')
end

power_ranking_frac_now = table(Name, Protocolo, NoLesion_Pre', Lesion_Pre', Lesion_Diff_PreOn', Lesion_Diff_PrePost',mean(Lesion_Diff_PreOn), mean(Lesion_Diff_PrePost),'VariableNames',LastName);
power_ranking.power_ranking_frac = sortrows([power_ranking.power_ranking_frac;power_ranking_frac_now],[7 8],'descend');

% Fractals Norm
if strcmp(injured_area, 'L')
    NoLesion_Pre = power_right_frac_norm(:,1);
    Lesion_Pre = power_left_frac_norm(:,1);
    Lesion_Diff_PreOn = power_left_frac_norm(:,1) - power_left_frac_norm(:,2);
    Lesion_Diff_PrePost = power_left_frac_norm(:,1) - power_left_frac_norm(:,3); 

elseif strcmp(injured_area, 'R')
    NoLesion_Pre = power_left_frac_norm(:,1);
    Lesion_Pre = power_right_frac_norm(:,1);
    Lesion_Diff_PreOn = power_right_frac_norm(:,1) - power_right_frac_norm(:,2);
    Lesion_Diff_PrePost = power_right_frac_norm(:,1) - power_right_frac_norm(:,3); 
    
else
    warning('Unknowed hemisphere')
end

power_ranking_frac_norm_now = table(Name, Protocolo, NoLesion_Pre', Lesion_Pre', Lesion_Diff_PreOn', Lesion_Diff_PrePost',mean(Lesion_Diff_PreOn), mean(Lesion_Diff_PrePost),'VariableNames',LastName);
power_ranking.power_ranking_frac_norm = sortrows([power_ranking.power_ranking_frac_norm;power_ranking_frac_norm_now],[7 8],'descend');

% Fractals Total
if strcmp(injured_area, 'L')
    NoLesion_Pre = power_right_frac_total(:,1);
    Lesion_Pre = power_left_frac_total(:,1);
    Lesion_Diff_PreOn = power_left_frac_total(:,1) - power_left_frac_total(:,2);
    Lesion_Diff_PrePost = power_left_frac_total(:,1) - power_left_frac_total(:,3); 

elseif strcmp(injured_area, 'R')
    NoLesion_Pre = power_left_frac_total(:,1);
    Lesion_Pre = power_right_frac_total(:,1);
    Lesion_Diff_PreOn = power_right_frac_total(:,1) - power_right_frac_total(:,2);
    Lesion_Diff_PrePost = power_right_frac_total(:,1) - power_right_frac_total(:,3); 
    
else
    warning('Unknowed hemisphere')
end

power_ranking_frac_total_now = table(Name, Protocolo, NoLesion_Pre', Lesion_Pre', Lesion_Diff_PreOn', Lesion_Diff_PrePost',mean(Lesion_Diff_PreOn), mean(Lesion_Diff_PrePost),'VariableNames',LastName);
power_ranking.power_ranking_frac_total = sortrows([power_ranking.power_ranking_frac_total;power_ranking_frac_total_now],[7 8],'descend');


power_ranking_table = power_ranking;

end