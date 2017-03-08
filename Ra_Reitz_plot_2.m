clear all
% close all
%% Ra&Reitz
mechanism={'MFC' };
% fuel_sim={'base','v1','v2','v3'};

pressure=[20];
for k=1:length(pressure)
    pressure_text{k}=['P',num2str(pressure(k)),'atm'];
end
num_cases=25;


pure_component_ID;
real_fuel_ID;

exp_markers={'ro' 'g*' 'b^'};
sim_line={'k-' 'k-s','k-d','k-^','k-x','k-o','k-p'};
marker_size=8;
line_width=2;

i=1; %mechanism

%% 20atm condition

% h2=figure('position',[20 50 580 480]);
% set(gca,'Fontsize',13)
% %plot exp data
% %/4 convert to ms
% 
% 
% 
% % semilogy(Vasu_20atm(:,2),Vasu_20atm(:,5)/1000,exp_markers{1},'markersize',marker_size)
% semilogy(Vasu_dode_20atm(:,2),Vasu_dode_20atm(:,5),exp_markers{1},'markersize',marker_size);
% 
% % semilogy(Dooley_20atm(:,2),Dooley_20atm(:,5),exp_markers{3},'markersize',marker_size)
% % semilogy(Vasu_20atm(:,2),Vasu_20atm(:,5)/1000,exp_markers{2},'markersize',marker_size)
% % semilogy(Shen_40atm(:,2),Shen_40atm(:,3)/1000,exp_markers{2},'markersize',marker_size)
% 
% 
% 
% % legend_text{2}='Vasu et al.40atm, Shock Tube';
% % legend_text{1}='Vasu et al.20atm, Shock Tube';
% legend_text{1}='Vasu et al.20atm dodecane, Shock Tube';
% % legend_text{1}=' ';
% % legend_text{1}='Wang and Oehlschlaeger, Shock Tube';
% % legend_text{3}='Dooley et al., RCM';
% % legend_text{2}='Shen et al., Shock Tube';
% %plot sim data
% 
% 
% 
% 
% hold on
% fuel_sim={'beforeoptimize'};
% load('simulation_result_beforeoptimize_20atm_phi_1.mat')
% k=1;
% 
% for j=1:length(fuel_sim)
% semilogy(sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,6),...
%     sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,10),...
%     'k--','markersize',marker_size)
%     %   ,sim_line{j},  'linewidth',line_width)
% % legend_text{end+1}=[mechanism{i},'_',fuel_sim{j}];
% legend_text{end+1}=[mechanism{i},'_','before'];
% end
% 
% [peaks,locs] = findpeaks(sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,10));
% yvalue=sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,6);
% locsValue = yvalue(locs);
% hold on
% semilogy(locsValue,peaks,exp_markers{2},'markersize',marker_size);
% 
% [peaks2,locs2] = findpeaks(-sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,10));
% yvalue2=sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,6);
% locsValue2 = yvalue2(locs2);
% hold on
% semilogy(locsValue2,-peaks2,exp_markers{3},'markersize',marker_size);
% 
% difference=abs(locsValue-Vasu_dode_20atm(:,2));
% [minDifference,idx] = min(difference);
% yvalueLocalMinTemp =  Vasu_dode_20atm(:,2);
% semilogy(yvalueLocalMinTemp(idx),-peaks2,exp_markers{3},'markersize',marker_size);
% 
% 
% hold on
% 
% load('simulation_result_afteroptimize_20atm_phi_1.mat')
% 
% fuel_sim={'afteroptimize'};
% k=1;
% for j=1:length(fuel_sim)
% 
% semilogy(sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,6),...
%     sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,10),...
%     'b-','markersize',marker_size)
%     %   ,sim_line{j},  'linewidth',line_width)
% legend_text{end+1}=[mechanism{i},'_',fuel_sim{j},'_','20atm'];
% 
% end
% 
% 
% 
% legend(legend_text,'location','SouthEast','interpreter','none')
% legend('boxoff')
% xlabel('1000/T (1/K)')
% ylabel('Ignition Delay Time (micros)')
% % ylim([0.1 10000])
% % axis([0.7 1.6 0.1 10])
% % clear legend_text
% annotation(h2,'textbox',[0.413 0.38 0.279 0.05],...
%     'String',{'n-dodecane',...
%      '/Air', '\phi=1'},...
%     'FontSize',13,...
%     'FontName','Arial',...
%     'FitBoxToText','off',...
%     'LineStyle','none');
% annotation(h2,'textbox',[0.25 0.8 0.279 0.05],...
%     'String',{' 20 atm'},...
%     'FontSize',13,...
%     'FontName','Arial',...
%     'FitBoxToText','off',...
%     'LineStyle','none');
%% 40atm condition
num_cases=[26 11];
num_cases_text = {};
for k=1:num_cases(1)
    num_cases_text=[num_cases_text ['numcases',num2str(k)]];
end
classnumb=[15 22 26 27 28];
numbOfClass = length(classnumb);
class_numb_text = {};
for k=1:numbOfClass
    class_numb_text=[class_numb_text ['class',num2str(classnumb(k))]];
end
for k = 1: length(pressure)

h3=figure('position',[20 50 580 480]);
set(gca,'Fontsize',13)
clear legend_text
% % legend_text{1}='Vasu et al.40atm, Shock Tube';
% legend_text{1}='Shen et al.40atm, Shock Tube';
% % semilogy(Vasu_40atm(:,2),Vasu_40atm(:,5)/1000,exp_markers{2},'markersize',marker_size)
% semilogy(Shen_dode_40atm(:,2),Shen_dode_40atm(:,5),exp_markers{2},'markersize',marker_size)

% legend_text{1}=['ERC',pressure_text{k},'Dummy'];
% legend_text{2}=['ERC',pressure_text{k},'target(original)'];
% legend_text{3}=['ERC',pressure_text{k},'after optimize'];

legend_text{1}=['MFC ',pressure_text{k},', ','beforeoptimize'];
    if strcmp(pressure_text{k},'P20atm')
        legend_text{2}=['Vasu, ',pressure_text{k},', ','target'];
    else
        legend_text{2}=['Shen, ',pressure_text{k},', ','target'];
    end
    
legend_text{3}=['MFC ',pressure_text{k},', after optimize'];

% load('simulation_result_beforeoptimize_dummy_class2_class4_class6_moderate_20atm_phi_1.mat')
% fuel_sim={'beforeoptimize_dummy_class2_class4_class6_moderate'};

     load('simulation_result_beforeoptimize_20atm_phi_1.mat')
    fuel_sim={'beforeoptimize'};

     for j=1:length(fuel_sim)
        semilogy(sim.(mechanism{i}).(fuel_sim{1}).(pressure_text{k}).table.data(:,6),...
        sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,10),...
        'k--','markersize',marker_size)
     end




    hold on

     load('simulation_result_afteroptimize_20atm_phi_1.mat')
    fuel_sim={'afteroptimize'};

     for j=1:length(fuel_sim)
        semilogy(sim.(mechanism{i}).(fuel_sim{1}).(pressure_text{k}).table.data(:,6),...
        sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,10),...
        'k--','markersize',marker_size)
     end




    hold on
    
    

    load('simulation_result_afteroptimize_20atm_phi_1.mat')
    fuel_sim={'afteroptimize'};


    
     semilogy(sim.(mechanism{1}).(fuel_sim{1}).(pressure_text{k}).table.data(:,6),...
     sim.(mechanism{1}).(fuel_sim{1}).(pressure_text{k}).table.data(:,10),...
     'b','markersize',marker_size)
   





hold on
% 
%  semilogy(Shen_hep_40atm(:,2),Shen_hep_40atm(:,3),'r*','markersize',marker_size)
    if strcmp(pressure_text{k},'P20atm')
    semilogy(Vasu_dode_20atm(:,2),Vasu_dode_20atm(:,5),'r*','markersize',marker_size)
    else
    semilogy(Shen_dode_40atm(:,2),Shen_dode_40atm(:,5),'r*','markersize',marker_size)
    end
%% upper bound & lowerbond
    hold on


    load('simulation_result_modify_20atm_phi_1.mat')
    fuel_sim={'modify'};


%     for j=1:length(fuel_sim)
%         for q= 1: num_cases(k)
%         semilogy(sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(num_cases_text{q}).table.data(:,6),...
%         sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(num_cases_text{q}).table.data(:,10),...
%         'bo','markersize',marker_size);
%         end
%     end
%     hold on;

 x.(class_numb_text{1})=[]; y.(class_numb_text{1})=[];
    for j=1:length(fuel_sim)
        for q= 1: num_cases(k)
            for m = 1: length(classnumb) 
        x.(class_numb_text{m})(q)=sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(class_numb_text{m}).(num_cases_text{q}).table.data(1,6);
        y.(class_numb_text{m})(q)=sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(class_numb_text{m}).(num_cases_text{q}).table.data(4,10);
            end
            
        end
    end
    for m = 1: length(classnumb) 
%      semilogy(x.(class_numb_text{m}),y.(class_numb_text{m}),'k','markersize',marker_size,'LineWidth',1.5);
     hold on;
    end
 x.(class_numb_text{1})=[]; y.(class_numb_text{1})=[];
    for j=1:length(fuel_sim)
        for q= 1: num_cases(k)
            for m = 1: length(classnumb)
        x.(class_numb_text{m})(q)=sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(class_numb_text{m}).(num_cases_text{q}).table.data(1,6);
        y.(class_numb_text{m})(q)=sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(class_numb_text{m}).(num_cases_text{q}).table.data(7,10);
            end
            
        end
    end
        for m = 1: length(classnumb) 
%      semilogy(x.(class_numb_text{m}),y.(class_numb_text{m}),'k','markersize',marker_size,'LineWidth',1.5);  
     hold on;
        end
%%    
    legend(legend_text,'location','SouthEast','interpreter','none')
    legend('boxoff')
    xlabel('1000/T (1/K)')
    ylabel('Ignition Delay Time (micros)')
    % axis([0.7 1.6 20 40000])
    % clear legend_text
    annotation(h3,'textbox',[0.413 0.38 0.279 0.05],...
    'String',{'n-dodecane',...
     '/Air','class 2, 6, 7, 8, 9', '\phi=1'},...
    'FontSize',13,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'LineStyle','none');
    annotation(h3,'textbox',[0.25 0.8 0.279 0.05],...
    'String',{pressure_text{k}},...
    'FontSize',13,...
    'FontName','Arial',...
    'FitBoxToText','off',...
    'LineStyle','none');


end
