%A = [0 1 2; 1 0 3; 2 3 0];
%A = symdec(5,1);
%node_names = {'A','B','C','D','F'};
%G = graph(A,node_names);
%p = plot(G)

%G.Nodes.NodeColors = [1,2,3,4,5]';%degree(G);
%G.Nodes.NodeSizes = [10 20 10 100 40]';
%p.NodeCData = G.Nodes.NodeColors;
%colorbar
pos_SMA = [2 19 2 2]; 
pos_M1 = [10 24 2 2]; 
pos_S1 = [19 22 2 2]; 
pos_DLS = [8 4 2 2]; 
pos_VPL = [17 7 2 2];

line([pos_SMA(1)+1,pos_M1(1)+1],[pos_SMA(2)+1,pos_M1(2)+1],'LineWidth',3)
line([pos_SMA(1)+1,pos_S1(1)+1],[pos_SMA(2)+1,pos_S1(2)+1],'LineWidth',3)
line([pos_SMA(1)+1,pos_DLS(1)+1],[pos_SMA(2)+1,pos_DLS(2)+1],'LineWidth',3)
line([pos_SMA(1)+1,pos_VPL(1)+1],[pos_SMA(2)+1,pos_VPL(2)+1],'LineWidth',3)
line([pos_M1(1)+1,pos_S1(1)+1],[pos_M1(2)+1,pos_S1(2)+1],'LineWidth',3)
line([pos_M1(1)+1,pos_DLS(1)+1],[pos_M1(2)+1,pos_DLS(2)+1],'LineWidth',3)
line([pos_M1(1)+1,pos_VPL(1)+1],[pos_M1(2)+1,pos_VPL(2)+1],'LineWidth',3)
line([pos_S1(1)+1,pos_DLS(1)+1],[pos_S1(2)+1,pos_DLS(2)+1],'LineWidth',3)
line([pos_S1(1)+1,pos_VPL(1)+1],[pos_S1(2)+1,pos_VPL(2)+1],'LineWidth',3)
line([pos_DLS(1)+1,pos_VPL(1)+1],[pos_DLS(2)+1,pos_VPL(2)+1],'LineWidth',3)

rectangle('Position',pos_SMA,'Curvature',[1 1],'EdgeColor','b','LineWidth',3,'FaceColor','b')
text(pos_SMA(1)+1,pos_SMA(2)+1,'SMA','HorizontalAlignment','center','Color','w','FontSize',16,'FontWeight','bold')

rectangle('Position',pos_M1,'Curvature',[1 1],'EdgeColor','r','LineWidth',3,'FaceColor','r')
text(pos_M1(1)+1,pos_M1(2)+1,'M1','HorizontalAlignment','center','Color','w','FontSize',16,'FontWeight','bold')

rectangle('Position',pos_S1,'Curvature',[1 1],'EdgeColor','g','LineWidth',3,'FaceColor','g')
text(pos_S1(1)+1,pos_S1(2)+1,'S1','HorizontalAlignment','center','Color','w','FontSize',16,'FontWeight','bold')

rectangle('Position',pos_DLS,'Curvature',[1 1],'EdgeColor','y','LineWidth',3,'FaceColor','y')
text(pos_DLS(1)+1,pos_DLS(2)+1,'DLS','HorizontalAlignment','center','Color','w','FontSize',16,'FontWeight','bold')

rectangle('Position',pos_VPL,'Curvature',[1 1],'EdgeColor','k','LineWidth',3,'FaceColor','k')
text(pos_VPL(1)+1,pos_VPL(2)+1,'VPL','HorizontalAlignment','center','Color','w','FontSize',16,'FontWeight','bold')

xlim([0 25])
ylim([0 30])




% Colocar ancho de barras y color de acuerdo a la coherencia
[sum_MSC_beta_parkinson, coupling_strength_beta_parkinson, delay_beta_parkinson] = coherence_measurements(registroLFP, [8, 30], [false, false, false], false, path);

coupling_strength_beta_parkinson = coupling_strength_beta_parkinson/sum(sum(coupling_strength_beta_parkinson));
left_coherence = coupling_strength_beta_parkinson(1:round(size(coupling_strength_beta_parkinson,1)/2),:);
right_coherence = coupling_strength_beta_parkinson(round(size(coupling_strength_beta_parkinson,1)/2)+1:end,:);

pos_SMA = [1.5 18.5 3 3]; 
pos_M1 = [9.5 23.5 3 3]; 
pos_S1 = [18.5 21.5 3 3]; 
pos_DLS = [7.5 3.5 3 3]; 
pos_VPL = [16.5 6.5 3 3];


for i = 1:3
    weigthed_left = left_coherence(:,i);
    weigthed_left = weigthed_left*1000;
    
    fig = figure('rend','painters','pos',[10 10 900 900]);%figure('units','normalized','outerposition',[0 0 1 1]);

    line([pos_SMA(1)+1.5,pos_M1(1)+1.5],[pos_SMA(2)+1,pos_M1(2)+1],'LineWidth',weigthed_left(1))
    line([pos_SMA(1)+1.5,pos_S1(1)+1.5],[pos_SMA(2)+1,pos_S1(2)+1],'LineWidth',weigthed_left(2))
    line([pos_SMA(1)+1.5,pos_DLS(1)+1.5],[pos_SMA(2)+1,pos_DLS(2)+1],'LineWidth',weigthed_left(3))
    line([pos_SMA(1)+1.5,pos_VPL(1)+1.5],[pos_SMA(2)+1,pos_VPL(2)+1],'LineWidth',weigthed_left(4))
    line([pos_M1(1)+1.5,pos_S1(1)+1.5],[pos_M1(2)+1,pos_S1(2)+1],'LineWidth',weigthed_left(5))
    line([pos_M1(1)+1.5,pos_DLS(1)+1.5],[pos_M1(2)+1,pos_DLS(2)+1],'LineWidth',weigthed_left(6))
    line([pos_M1(1)+1.5,pos_VPL(1)+1.5],[pos_M1(2)+1,pos_VPL(2)+1],'LineWidth',weigthed_left(7))
    line([pos_S1(1)+1.5,pos_DLS(1)+1.5],[pos_S1(2)+1,pos_DLS(2)+1],'LineWidth',weigthed_left(8))
    line([pos_S1(1)+1.5,pos_VPL(1)+1.5],[pos_S1(2)+1,pos_VPL(2)+1],'LineWidth',weigthed_left(9))
    line([pos_DLS(1)+1.5,pos_VPL(1)+1.5],[pos_DLS(2)+1,pos_VPL(2)+1],'LineWidth',weigthed_left(10))

    rectangle('Position',pos_SMA,'Curvature',[1 1],'EdgeColor','b','LineWidth',3,'FaceColor','b')
    text(pos_SMA(1)+1.5,pos_SMA(2)+1.5,'SMA','HorizontalAlignment','center','Color','w','FontSize',18,'FontWeight','bold')

    rectangle('Position',pos_M1,'Curvature',[1 1],'EdgeColor','r','LineWidth',3,'FaceColor','r')
    text(pos_M1(1)+1.5,pos_M1(2)+1.5,'M1','HorizontalAlignment','center','Color','w','FontSize',18,'FontWeight','bold')

    rectangle('Position',pos_S1,'Curvature',[1 1],'EdgeColor','g','LineWidth',3,'FaceColor','g')
    text(pos_S1(1)+1.5,pos_S1(2)+1.5,'S1','HorizontalAlignment','center','Color','w','FontSize',18,'FontWeight','bold')

    rectangle('Position',pos_DLS,'Curvature',[1 1],'EdgeColor','y','LineWidth',3,'FaceColor','y')
    text(pos_DLS(1)+1.5,pos_DLS(2)+1.5,'DLS','HorizontalAlignment','center','Color','w','FontSize',18,'FontWeight','bold')

    rectangle('Position',pos_VPL,'Curvature',[1 1],'EdgeColor','k','LineWidth',3,'FaceColor','k')
    text(pos_VPL(1)+1.5,pos_VPL(2)+1.5,'VPL','HorizontalAlignment','center','Color','w','FontSize',18,'FontWeight','bold')

    xlim([0 25])
    ylim([0 30])
    
    weigthed_rigth = right_coherence(:,i);
    weigthed_rigth = weigthed_rigth*1000;
    
    fig = figure('rend','painters','pos',[10 10 900 900]);%figure('units','normalized','outerposition',[0 0 1 1]);

    line([pos_SMA(1)+1.5,pos_M1(1)+1.5],[pos_SMA(2)+1,pos_M1(2)+1],'LineWidth',weigthed_rigth(1))
    line([pos_SMA(1)+1.5,pos_S1(1)+1.5],[pos_SMA(2)+1,pos_S1(2)+1],'LineWidth',weigthed_rigth(2))
    line([pos_SMA(1)+1.5,pos_DLS(1)+1.5],[pos_SMA(2)+1,pos_DLS(2)+1],'LineWidth',weigthed_rigth(3))
    line([pos_SMA(1)+1.5,pos_VPL(1)+1.5],[pos_SMA(2)+1,pos_VPL(2)+1],'LineWidth',weigthed_rigth(4))
    line([pos_M1(1)+1.5,pos_S1(1)+1.5],[pos_M1(2)+1,pos_S1(2)+1],'LineWidth',weigthed_rigth(5))
    line([pos_M1(1)+1.5,pos_DLS(1)+1.5],[pos_M1(2)+1,pos_DLS(2)+1],'LineWidth',weigthed_rigth(6))
    line([pos_M1(1)+1.5,pos_VPL(1)+1.5],[pos_M1(2)+1,pos_VPL(2)+1],'LineWidth',weigthed_rigth(7))
    line([pos_S1(1)+1.5,pos_DLS(1)+1.5],[pos_S1(2)+1,pos_DLS(2)+1],'LineWidth',weigthed_rigth(8))
    line([pos_S1(1)+1.5,pos_VPL(1)+1.5],[pos_S1(2)+1,pos_VPL(2)+1],'LineWidth',weigthed_rigth(9))
    line([pos_DLS(1)+1.5,pos_VPL(1)+1.5],[pos_DLS(2)+1,pos_VPL(2)+1],'LineWidth',weigthed_rigth(10))

    rectangle('Position',pos_SMA,'Curvature',[1 1],'EdgeColor','b','LineWidth',3,'FaceColor','b')
    text(pos_SMA(1)+1.5,pos_SMA(2)+1.5,'SMA','HorizontalAlignment','center','Color','w','FontSize',18,'FontWeight','bold')

    rectangle('Position',pos_M1,'Curvature',[1 1],'EdgeColor','r','LineWidth',3,'FaceColor','r')
    text(pos_M1(1)+1.5,pos_M1(2)+1.5,'M1','HorizontalAlignment','center','Color','w','FontSize',18,'FontWeight','bold')

    rectangle('Position',pos_S1,'Curvature',[1 1],'EdgeColor','g','LineWidth',3,'FaceColor','g')
    text(pos_S1(1)+1.5,pos_S1(2)+1.5,'S1','HorizontalAlignment','center','Color','w','FontSize',18,'FontWeight','bold')

    rectangle('Position',pos_DLS,'Curvature',[1 1],'EdgeColor','y','LineWidth',3,'FaceColor','y')
    text(pos_DLS(1)+1.5,pos_DLS(2)+1.5,'DLS','HorizontalAlignment','center','Color','w','FontSize',18,'FontWeight','bold')

    rectangle('Position',pos_VPL,'Curvature',[1 1],'EdgeColor','k','LineWidth',3,'FaceColor','k')
    text(pos_VPL(1)+1.5,pos_VPL(2)+1.5,'VPL','HorizontalAlignment','center','Color','w','FontSize',18,'FontWeight','bold')

    xlim([0 25])
    ylim([0 30])
end


