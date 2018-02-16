function boxplot_custom(datos, areas, num_record, ylimite, y_etiqueta, titulo, name_figure_save)

azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];

% Graficar cambio en la potencia 
fig = figure('units','normalized','outerposition',[0 0 1 1]);
xt = 1:length(areas);
x = [xt-0.225;xt;xt+0.225]';

pre = boxplot(datos(:,1:3:end)',repmat(areas,1,num_record),'position',x(:,1), 'widths',0.2,'Color',azul);
h_pre=findobj(pre,'tag','Box');
set(h_pre,'LineWidth',3)
set(h_pre,'LineStyle',':') 
h_pre=findobj(pre,'tag','Upper Adjacent Value'); 
set(h_pre,'LineWidth',2); 
h_pre=findobj(pre,'tag','Lower Adjacent Value'); 
set(h_pre,'LineWidth',2); 
h_pre=findobj(pre,'tag','Median'); 
set(h_pre,'LineWidth',2);
set(h_pre,'Color',azul*0.7);
hold on

on = boxplot(datos(:,2:3:end)',repmat(areas,1,num_record),'position',x(:,2), 'widths',0.2,'Color',rojo);
h_on=findobj(on,'tag','Box');
set(h_on,'LineWidth',3)
set(h_on,'LineStyle',':')
h_on=findobj(on,'tag','Upper Adjacent Value'); 
set(h_on,'LineWidth',2); 
h_on=findobj(on,'tag','Lower Adjacent Value'); 
set(h_on,'LineWidth',2); 
h_on=findobj(on,'tag','Median'); 
set(h_on,'LineWidth',4); 
set(h_on,'Color',rojo*0.7);
hold on

post = boxplot(datos(:,3:3:end)',repmat(areas,1,num_record),'position',x(:,3), 'widths',0.2,'Color',verde);
h_post=findobj(post,'tag','Box');
set(h_post,'LineWidth',3)
set(h_post,'LineStyle',':')
h_post=findobj(post,'tag','Upper Adjacent Value'); 
set(h_post,'LineWidth',2); 
h_post=findobj(post,'tag','Lower Adjacent Value'); 
set(h_post,'LineWidth',2); 
h_post=findobj(post,'tag','Median'); 
set(h_post,'LineWidth',4); 
set(h_post,'Color',verde*0.7);
set(gca, 'XTick', xt, 'XTickLabel', areas)

lgd = legend([h_pre(1) h_on(1) h_post(1)], 'Pre-stim', 'On-stim', 'Post-stim','Location','southoutside','Orientation','horizontal');
lgd.FontSize = 20;
grid on
ylim(ylimite)
xlim([xt(1)-0.5, xt(end)+0.5])

ylabel(y_etiqueta, 'FontSize', 24)
set(gca,'fontsize',20)
title(titulo, 'FontSize', 20, 'Interpreter', 'none')
% Guardar imagen de la figura
saveas(fig,name_figure_save,'png');
saveas(fig,name_figure_save,'fig');
%waitforbuttonpress;
close(fig)  



end