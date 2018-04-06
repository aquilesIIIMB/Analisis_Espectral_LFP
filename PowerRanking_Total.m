%%% Analisis entre protocolos
% Eliminacion de variables que no se utilizaran
clearvars -except path name_registro foldername inicio_foldername power_ranking slash_system areas
close all

LastName = {'Protocol','Mean_Lesion_Diff_PreOn','Mean_Lesion_Diff_PrePost'};
power_ranking_total.power_ranking_osci = table([],[],[],'VariableNames',LastName);
power_ranking_total.power_ranking_frac = table([],[],[],'VariableNames',LastName);
power_ranking_total.power_ranking_frac_total = table([],[],[],'VariableNames',LastName);

protocol_grouped = {'20Hz','150Hz','300Hz',...
    '-375','-2500','-5000',...
    '+375','+750','+2500','+5000',...
    '-2500_300Hz',...
    '+375_300Hz','+2500_300Hz','+5000_300Hz'};

protocol_total_grouped = [];

% Osci
protocol_sorted = power_ranking.power_ranking_osci.Protocol;
Name_sorted = power_ranking.power_ranking_osci.Name;
power_diff_pre_on = power_ranking.power_ranking_osci.Mean_Lesion_Diff_PreOn;
power_diff_pre_post = power_ranking.power_ranking_osci.Mean_Lesion_Diff_PrePost;

mean_osci_pre_on =[];
boxplot_osci_pre_on = [];
name_osci = [];

for i = 1:length(protocol_grouped)

    idx_protocol = find(string(protocol_sorted) == protocol_grouped{i});
    mean_protocol_pre_on = mean(power_diff_pre_on(idx_protocol));
    mean_protocol_pre_post = mean(power_diff_pre_post(idx_protocol));
    
    mean_osci_pre_on = [mean_osci_pre_on; mean_protocol_pre_on];
    boxplot_osci_pre_on = [boxplot_osci_pre_on; power_diff_pre_on(idx_protocol)];
    protocol_total_grouped = [protocol_total_grouped; protocol_sorted(idx_protocol)];
    name_osci = [name_osci ;Name_sorted(idx_protocol)];
    
    power_ranking_total_osci = table(protocol_grouped(i),mean_protocol_pre_on,mean_protocol_pre_post,'VariableNames',LastName);
    power_ranking_total.power_ranking_osci = sortrows([power_ranking_total.power_ranking_osci;power_ranking_total_osci],[2 3],'descend');
 
    
end

% Frac
protocol_sorted = power_ranking.power_ranking_frac.Protocol;
Name_sorted = power_ranking.power_ranking_frac.Name;
power_diff_pre_on = power_ranking.power_ranking_frac.Mean_Lesion_Diff_PreOn;
power_diff_pre_post = power_ranking.power_ranking_frac.Mean_Lesion_Diff_PrePost;

mean_frac_pre_on =[];
boxplot_frac_pre_on = [];
name_frac = [];

for i = 1:length(protocol_grouped)

    idx_protocol = find(string(protocol_sorted) == protocol_grouped{i});
    mean_protocol_pre_on = mean(power_diff_pre_on(idx_protocol));
    mean_protocol_pre_post = mean(power_diff_pre_post(idx_protocol));
    
    mean_frac_pre_on = [mean_frac_pre_on; mean_protocol_pre_on];
    boxplot_frac_pre_on = [boxplot_frac_pre_on; power_diff_pre_on(idx_protocol)];
    name_frac = [name_frac ;Name_sorted(idx_protocol)];

    power_ranking_total_frac = table(protocol_grouped(i),mean_protocol_pre_on,mean_protocol_pre_post,'VariableNames',LastName);
    power_ranking_total.power_ranking_frac = sortrows([power_ranking_total.power_ranking_frac;power_ranking_total_frac],[2 3],'descend');
 
    
end

% Frac Total
protocol_sorted = power_ranking.power_ranking_frac_total.Protocol;
Name_sorted = power_ranking.power_ranking_frac_total.Name;
power_diff_pre_on = power_ranking.power_ranking_frac_total.Mean_Lesion_Diff_PreOn;
power_diff_pre_post = power_ranking.power_ranking_frac_total.Mean_Lesion_Diff_PrePost;

mean_frac_total_pre_on =[];
boxplot_frac_total_pre_on = [];
name_frac_total = [];

for i = 1:length(protocol_grouped)

    idx_protocol = find(string(protocol_sorted) == protocol_grouped{i});
    mean_protocol_pre_on = mean(power_diff_pre_on(idx_protocol));
    mean_protocol_pre_post = mean(power_diff_pre_post(idx_protocol));
    
    mean_frac_total_pre_on = [mean_frac_total_pre_on; mean_protocol_pre_on];
    boxplot_frac_total_pre_on = [boxplot_frac_total_pre_on; power_diff_pre_on(idx_protocol)];
    name_frac_total = [name_frac_total ;Name_sorted(idx_protocol)];

    power_ranking_total_frac_total = table(protocol_grouped(i),mean_protocol_pre_on,mean_protocol_pre_post,'VariableNames',LastName);
    power_ranking_total.power_ranking_frac_total = sortrows([power_ranking_total.power_ranking_frac_total;power_ranking_total_frac_total],[2 3],'descend');
 
    
end
    
%% Grafico
azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];
morado = [0.494, 0.184, 0.556];
amarillo = [0.929, 0.694, 0.125];
azul_claro = [0.2 0.6470 0.9410];
rojo_oscuro = [0.635, 0.078, 0.184];
verde_claro = [0.666, 0.874, 0.388];

x = [0.75,1,1.25,...
    1.75,2,2.25,...
    2.7,2.9,3.1,3.3,...
    4,...
    4.75,5,5.25];

rats = [string({'Maravilla', 'Arturo', 'Charles', 'Dani', 'Tony', 'Orlando'})...
    ;string({'Rat01', 'Rat02', 'Rat03', 'Rat04', 'Rat05', 'Rat06'})];

% Means
fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
plot([0,x(end)+0.5],[0,0],'k--','LineWidth',2)
hold on
p1 = plot(x, mean_osci_pre_on,'+','MarkerSize',10,'LineWidth',4);
hold on
p2 = plot(x, mean_frac_pre_on,'x','MarkerSize',10,'LineWidth',4);
p3 = plot(x, mean_frac_total_pre_on,'o','MarkerSize',10,'LineWidth',4);
set(gca, 'XTick', x, 'XTickLabel', protocol_grouped, 'TickLabelInterpreter','none')
ylabel('Power difference Pre-On [W/Hz]', 'FontSize', 24)
lgd = legend([p1 p2 p3],'oscillatory (band)', 'scale-free (band)', 'scale-free (total)');
lgd.FontSize = 20;
set(gca,'fontsize',18)
xlim([x(1)-0.25 x(end)+0.25])
ylim([-0.4 1])
xtickangle(45)
grid on
title('Comparison among protocols', 'FontSize', 24)
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',slash_system,'MEANS Comparison among protocols'];
saveas(fig_1,name_figure_save,'png');
saveas(fig_1,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_1)

% Point plot

% Osci
idx_maravilla = strfind(name_osci, 'aravilla');
idx_maravilla = find(~cellfun(@isempty,idx_maravilla));

idx_charles = strfind(name_osci, 'harles');
idx_charles = find(~cellfun(@isempty,idx_charles));

idx_arturo = strfind(name_osci, 'rturo');
idx_arturo = find(~cellfun(@isempty,idx_arturo));

idx_dani = strfind(name_osci, 'dani');
idx_dani = find(~cellfun(@isempty,idx_dani));

idx_tony = strfind(name_osci, 'ton');
idx_tony = find(~cellfun(@isempty,idx_tony));

idx_orlando = strfind(name_osci, 'rlando');
idx_orlando_2 = strfind(name_osci, 'RLANDO');
idx_orlando = find(~cellfun(@isempty,idx_orlando));
idx_orlando_2 = find(~cellfun(@isempty,idx_orlando_2));
idx_orlando = unique([idx_orlando; idx_orlando_2]);

fig_21 = figure('units','normalized','outerposition',[0 0 1 1]);
plot([0,x(end)+0.5],[0,0],'k--','LineWidth',2)
hold on

for i = 1:length(protocol_grouped)
    idx_group = find(protocol_total_grouped == string(protocol_grouped(i)));
    
    osci_sorted_maravilla = boxplot_osci_pre_on(idx_group(ismember(idx_group,idx_maravilla)));
    if ~isempty(osci_sorted_maravilla)
        osciM = plot(repmat(x(i),length(osci_sorted_maravilla),1), osci_sorted_maravilla,'+','Color',azul,'MarkerSize',10,'LineWidth',3);
    end
    
    osci_sorted_arturo = boxplot_osci_pre_on(idx_group(ismember(idx_group,idx_arturo)));
    if ~isempty(osci_sorted_arturo)
        osciA = plot(repmat(x(i),length(osci_sorted_arturo),1), osci_sorted_arturo,'+','Color',rojo,'MarkerSize',10,'LineWidth',3);
    end
    
    osci_sorted_charles = boxplot_osci_pre_on(idx_group(ismember(idx_group,idx_charles)));
    if ~isempty(osci_sorted_charles)
        osciC = plot(repmat(x(i),length(osci_sorted_charles),1), osci_sorted_charles,'+','Color',verde,'MarkerSize',10,'LineWidth',3);
    end
    
    osci_sorted_dani = boxplot_osci_pre_on(idx_group(ismember(idx_group,idx_dani)));
    if ~isempty(osci_sorted_dani)
        osciD = plot(repmat(x(i),length(osci_sorted_dani),1), osci_sorted_dani,'+','Color',morado,'MarkerSize',10,'LineWidth',3);
    end
    
    osci_sorted_tony = boxplot_osci_pre_on(idx_group(ismember(idx_group,idx_tony)));
    if ~isempty(osci_sorted_tony)
        osciT = plot(repmat(x(i),length(osci_sorted_tony),1), osci_sorted_tony,'+','Color',amarillo,'MarkerSize',10,'LineWidth',3);
    end
    
    osci_sorted_orlando = boxplot_osci_pre_on(idx_group(ismember(idx_group,idx_orlando)));
    if ~isempty(osci_sorted_orlando)
        osciO = plot(repmat(x(i),length(osci_sorted_orlando),1), osci_sorted_orlando,'+','Color',azul_claro,'MarkerSize',10,'LineWidth',3);
    end
         
end
set(gca, 'XTick', x, 'XTickLabel', protocol_grouped, 'TickLabelInterpreter','none')
lgd = legend([osciM osciA osciC osciD osciT osciO],'Rat01', 'Rat02', 'Rat03', 'Rat04', 'Rat05', 'Rat06','Location','eastoutside','Orientation','vertical');
lgd.FontSize = 20;
ylabel('Power difference Pre-On [W/Hz]', 'FontSize', 24)
set(gca,'fontsize',18)
xlim([x(1)-0.25 x(end)+0.25])
ylim([-1.2 1.5]) %ylim([-0.2 0.5])
xtickangle(45)
grid on
title('Comparison among protocols using Oscillation power in [8, 30]Hz', 'FontSize', 24)
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',slash_system,'POINTS Comparison among protocols using Oscillation power in [8, 30]Hz'];
saveas(fig_21,name_figure_save,'png');
saveas(fig_21,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_21)

% Frac
idx_maravilla = strfind(name_frac, 'aravilla');
idx_maravilla = find(~cellfun(@isempty,idx_maravilla));

idx_charles = strfind(name_frac, 'harles');
idx_charles = find(~cellfun(@isempty,idx_charles));

idx_arturo = strfind(name_frac, 'rturo');
idx_arturo = find(~cellfun(@isempty,idx_arturo));

idx_dani = strfind(name_frac, 'dani');
idx_dani = find(~cellfun(@isempty,idx_dani));

idx_tony = strfind(name_frac, 'ton');
idx_tony = find(~cellfun(@isempty,idx_tony));

idx_orlando = strfind(name_frac, 'rlando');
idx_orlando_2 = strfind(name_frac, 'RLANDO');
idx_orlando = find(~cellfun(@isempty,idx_orlando));
idx_orlando_2 = find(~cellfun(@isempty,idx_orlando_2));
idx_orlando = unique([idx_orlando; idx_orlando_2]);

fig_22 = figure('units','normalized','outerposition',[0 0 1 1]);
plot([0,x(end)+0.5],[0,0],'k--','LineWidth',2)
hold on
for i = 1:length(protocol_grouped)
    idx_group = find(protocol_total_grouped == string(protocol_grouped(i)));
    
    frac_sorted_maravilla = boxplot_frac_pre_on(idx_group(ismember(idx_group,idx_maravilla)));
    if ~isempty(frac_sorted_maravilla)
        osciM = plot(repmat(x(i),length(frac_sorted_maravilla),1), frac_sorted_maravilla,'+','Color',azul,'MarkerSize',10,'LineWidth',3);
    end
    
    frac_sorted_arturo = boxplot_frac_pre_on(idx_group(ismember(idx_group,idx_arturo)));
    if ~isempty(frac_sorted_arturo)
        osciA = plot(repmat(x(i),length(frac_sorted_arturo),1), frac_sorted_arturo,'+','Color',rojo,'MarkerSize',10,'LineWidth',3);
    end
    
    frac_sorted_charles = boxplot_frac_pre_on(idx_group(ismember(idx_group,idx_charles)));
    if ~isempty(frac_sorted_charles)
        osciC = plot(repmat(x(i),length(frac_sorted_charles),1), frac_sorted_charles,'+','Color',verde,'MarkerSize',10,'LineWidth',3);
    end
    
    frac_sorted_dani = boxplot_frac_pre_on(idx_group(ismember(idx_group,idx_dani)));
    if ~isempty(frac_sorted_dani)
        osciD = plot(repmat(x(i),length(frac_sorted_dani),1), frac_sorted_dani,'+','Color',morado,'MarkerSize',10,'LineWidth',3);
    end
    
    frac_sorted_tony = boxplot_frac_pre_on(idx_group(ismember(idx_group,idx_tony)));
    if ~isempty(frac_sorted_tony)
        osciT = plot(repmat(x(i),length(frac_sorted_tony),1), frac_sorted_tony,'+','Color',amarillo,'MarkerSize',10,'LineWidth',3);
    end
    
    frac_sorted_orlando = boxplot_frac_pre_on(idx_group(ismember(idx_group,idx_orlando)));
    if ~isempty(frac_sorted_orlando)
        osciO = plot(repmat(x(i),length(frac_sorted_orlando),1), frac_sorted_orlando,'+','Color',azul_claro,'MarkerSize',10,'LineWidth',3);
    end
         
end
set(gca, 'XTick', x, 'XTickLabel', protocol_grouped, 'TickLabelInterpreter','none')
lgd = legend([osciM osciA osciC osciD osciT osciO],'Rat01', 'Rat02', 'Rat03', 'Rat04', 'Rat05', 'Rat06','Location','eastoutside','Orientation','vertical');
lgd.FontSize = 20;
ylabel('Power difference Pre-On [W/Hz]', 'FontSize', 24)
set(gca,'fontsize',18)
xlim([x(1)-0.25 x(end)+0.25])
ylim([-1.2 1.5])
xtickangle(45)
grid on
title('Comparison among protocols using Scale-free power in [8, 30]Hz', 'FontSize', 24)
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',slash_system,'POINTS Comparison among protocols using Scale-free power in [8, 30]Hz'];
saveas(fig_22,name_figure_save,'png');
saveas(fig_22,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_22)

% Frac Total
idx_maravilla = strfind(name_frac_total, 'aravilla');
idx_maravilla = find(~cellfun(@isempty,idx_maravilla));

idx_charles = strfind(name_frac_total, 'harles');
idx_charles = find(~cellfun(@isempty,idx_charles));

idx_arturo = strfind(name_frac_total, 'rturo');
idx_arturo = find(~cellfun(@isempty,idx_arturo));

idx_dani = strfind(name_frac_total, 'dani');
idx_dani = find(~cellfun(@isempty,idx_dani));

idx_tony = strfind(name_frac_total, 'ton');
idx_tony = find(~cellfun(@isempty,idx_tony));

idx_orlando = strfind(name_frac_total, 'rlando');
idx_orlando_2 = strfind(name_frac_total, 'RLANDO');
idx_orlando = find(~cellfun(@isempty,idx_orlando));
idx_orlando_2 = find(~cellfun(@isempty,idx_orlando_2));
idx_orlando = unique([idx_orlando; idx_orlando_2]);

fig_23 = figure('units','normalized','outerposition',[0 0 1 1]);
plot([0,x(end)+0.5],[0,0],'k--','LineWidth',2)
hold on
for i = 1:length(protocol_grouped)
    idx_group = find(protocol_total_grouped == string(protocol_grouped(i)));
    
    frac_total_sorted_maravilla = boxplot_frac_total_pre_on(idx_group(ismember(idx_group,idx_maravilla)));
    if ~isempty(frac_total_sorted_maravilla)
        osciM = plot(repmat(x(i),length(frac_total_sorted_maravilla),1), frac_total_sorted_maravilla,'+','Color',azul,'MarkerSize',10,'LineWidth',3);
    end
    
    frac_total_sorted_arturo = boxplot_frac_total_pre_on(idx_group(ismember(idx_group,idx_arturo)));
    if ~isempty(frac_total_sorted_arturo)
        osciA = plot(repmat(x(i),length(frac_total_sorted_arturo),1), frac_total_sorted_arturo,'+','Color',rojo,'MarkerSize',10,'LineWidth',3);
    end
    
    frac_total_sorted_charles = boxplot_frac_total_pre_on(idx_group(ismember(idx_group,idx_charles)));
    if ~isempty(frac_total_sorted_charles)
        osciC = plot(repmat(x(i),length(frac_total_sorted_charles),1), frac_total_sorted_charles,'+','Color',verde,'MarkerSize',10,'LineWidth',3);
    end
    
    frac_total_sorted_dani = boxplot_frac_total_pre_on(idx_group(ismember(idx_group,idx_dani)));
    if ~isempty(frac_total_sorted_dani)
        osciD = plot(repmat(x(i),length(frac_total_sorted_dani),1), frac_total_sorted_dani,'+','Color',morado,'MarkerSize',10,'LineWidth',3);
    end
    
    frac_total_sorted_tony = boxplot_frac_total_pre_on(idx_group(ismember(idx_group,idx_tony)));
    if ~isempty(frac_total_sorted_tony)
        osciT = plot(repmat(x(i),length(frac_total_sorted_tony),1), frac_total_sorted_tony,'+','Color',amarillo,'MarkerSize',10,'LineWidth',3);
    end
    
    frac_total_sorted_orlando = boxplot_frac_total_pre_on(idx_group(ismember(idx_group,idx_orlando)));
    if ~isempty(frac_total_sorted_orlando)
        osciO = plot(repmat(x(i),length(frac_total_sorted_orlando),1), frac_total_sorted_orlando,'+','Color',azul_claro,'MarkerSize',10,'LineWidth',3);
    end
         
end
set(gca, 'XTick', x, 'XTickLabel', protocol_grouped, 'TickLabelInterpreter','none')
lgd = legend([osciM osciA osciC osciD osciT osciO],'Rat01', 'Rat02', 'Rat03', 'Rat04', 'Rat05', 'Rat06','Location','eastoutside','Orientation','vertical');
lgd.FontSize = 20;
set(gca, 'XTick', x, 'XTickLabel', protocol_grouped, 'TickLabelInterpreter','none')
ylabel('Power difference Pre-On [W/Hz]', 'FontSize', 24)
set(gca,'fontsize',18)
xlim([x(1)-0.25 x(end)+0.25])
ylim([-1.2 1.5])
xtickangle(45)
grid on
title('Comparison among protocols using total Scale-free power', 'FontSize', 24)
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',slash_system,'POINTS Comparison among protocols using total Scale-free power'];
saveas(fig_23,name_figure_save,'png');
saveas(fig_23,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_23)


% Boxplot

% Osci
fig_31 = figure('units','normalized','outerposition',[0 0 1 1]);
plot([0,x(end)+0.5],[0,0],'k--','LineWidth',2)
hold on
osci_BP = boxplot(boxplot_osci_pre_on, protocol_total_grouped,'position',x, 'widths',0.1);
h_osci=findobj(osci_BP,'tag','Box');
set(h_osci,'LineWidth',3)
set(h_osci,'LineStyle',':')
h_osci=findobj(osci_BP,'tag','Upper Adjacent Value'); 
set(h_osci,'LineWidth',3); 
h_osci=findobj(osci_BP,'tag','Lower Adjacent Value'); 
set(h_osci,'LineWidth',3); 
h_osci=findobj(osci_BP,'tag','Median'); 
set(h_osci,'LineWidth',4); 
set(gca, 'XTick', x, 'XTickLabel', protocol_grouped, 'TickLabelInterpreter','none')
ylabel('Power difference Pre-On [W/Hz]', 'FontSize', 24)
set(gca,'fontsize',18)
xlim([x(1)-0.25 x(end)+0.25])
ylim([-1.2 1.5])
xtickangle(45)
grid on
title('Comparison among protocols using Oscillation power in [8, 30]Hz', 'FontSize', 24)
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',slash_system,'BOXPLOT Comparison among protocols using Oscillation power in [8, 30]Hz'];
saveas(fig_31,name_figure_save,'png');
saveas(fig_31,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_31)

% Frac
fig_32 = figure('units','normalized','outerposition',[0 0 1 1]);
plot([0,x(end)+0.5],[0,0],'k--','LineWidth',2)
hold on
frac_BP = boxplot(boxplot_frac_pre_on, protocol_total_grouped,'position',x, 'widths',0.1);
h_frac=findobj(frac_BP,'tag','Box');
set(h_frac,'LineWidth',3)
set(h_frac,'LineStyle',':')
h_frac=findobj(frac_BP,'tag','Upper Adjacent Value'); 
set(h_frac,'LineWidth',3); 
h_frac=findobj(frac_BP,'tag','Lower Adjacent Value'); 
set(h_frac,'LineWidth',3); 
h_frac=findobj(frac_BP,'tag','Median'); 
set(h_frac,'LineWidth',4);
set(gca, 'XTick', x, 'XTickLabel', protocol_grouped, 'TickLabelInterpreter','none')
ylabel('Power difference Pre-On [W/Hz]', 'FontSize', 24)
set(gca,'fontsize',18)
xlim([x(1)-0.25 x(end)+0.25])
ylim([-1.2 1.5])
xtickangle(45)
grid on
title('Comparison among protocols using Scale-free power in [8, 30]Hz', 'FontSize', 24)
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',slash_system,'BOXPLOT Comparison among protocols using Scale-free power in [8, 30]Hz'];
saveas(fig_32,name_figure_save,'png');
saveas(fig_32,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_32)

% Frac Total
fig_33 = figure('units','normalized','outerposition',[0 0 1 1]);
plot([0,x(end)+0.5],[0,0],'k--','LineWidth',2)
hold on
frac_total_BP = boxplot(boxplot_frac_total_pre_on, protocol_total_grouped,'position',x, 'widths',0.1);
h_frac_total=findobj(frac_total_BP,'tag','Box');
set(h_frac_total,'LineWidth',3)
set(h_frac_total,'LineStyle',':')
h_frac_total=findobj(frac_total_BP,'tag','Upper Adjacent Value'); 
set(h_frac_total,'LineWidth',3); 
h_frac_total=findobj(frac_total_BP,'tag','Lower Adjacent Value'); 
set(h_frac_total,'LineWidth',3); 
h_frac_total=findobj(frac_total_BP,'tag','Median'); 
set(h_frac_total,'LineWidth',4);
set(gca, 'XTick', x, 'XTickLabel', protocol_grouped, 'TickLabelInterpreter','none')
ylabel('Power difference Pre-On [W/Hz]', 'FontSize', 24)
set(gca,'fontsize',18)
xlim([x(1)-0.25 x(end)+0.25])
ylim([-1.2 1.5])
xtickangle(45)
grid on
title('Comparison among protocols using total Scale-free power', 'FontSize', 24)
% Guardar imagen de la figura
name_figure_save = [inicio_foldername,'Images',slash_system,'BOXPLOT Comparison among protocols using total Scale-free power'];
saveas(fig_33,name_figure_save,'png');
saveas(fig_33,name_figure_save,'fig');
%waitforbuttonpress;
close(fig_33)

clearvars -except path name_registro foldername inicio_foldername slash_system areas power_ranking_total rats

% Guardar la matriz del ranking
path_name_registro = [inicio_foldername,'Images',slash_system,'power_ranking_total'];

% Descomentar para guardar
save(path_name_registro,'-v7.3')

disp(['It was saved in: ',path_name_registro])
    
    
