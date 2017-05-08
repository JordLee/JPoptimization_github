clear all
% close all
% This function is used to plot the optimized ignition delay time results
% and compare with the target(experimental) data.

%%%%%% setting  %%%%%%%%%%%%%%%%%%%%%%%%%%%
mechanism={'MFC' };
pressure=[40];
phi=1;
iteration_numb=3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:length(pressure)
    pressure_text{k}=['P',num2str(pressure(k)),'atm'];

    simulation_result_beforeoptimize_text{k}=['simulation_result_beforeoptimize_',num2str(pressure(k)),'atm','_',...
        'phi','_',num2str(phi),'.mat'];
    for i= 1 : length(iteration_numb)
    simulation_result_afteroptimize_text{k}=['simulation_result_afteroptimize_',num2str(iteration_numb(i)),'_',...
        num2str(pressure(k)),'atm','_','phi','_',num2str(phi),'.mat'];
    end
    fuel_sim_text = ['afteroptimize','_',num2str(iteration_numb(i))];
end

num_cases=25; % 25 temperature points

pure_component_ID;
real_fuel_ID;

exp_markers={'ro' 'g*' 'b^'};
sim_line={'k-' 'k-s','k-d','k-^','k-x','k-o','k-p'};
marker_size=8;
line_width=2;

i=1; %mechanism

num_cases=[26 11];
num_cases_text = {};
for k=1:num_cases(1)
    num_cases_text=[num_cases_text ['numcases',num2str(k)]];
end

for k = 1: length(pressure)

h3=figure('position',[20 50 580 480]);
set(gca,'Fontsize',13)
clear legend_text

%% defines the legend
legend_text{1}=['MFC ',pressure_text{k},', ','beforeoptimize'];
    if strcmp(pressure_text{k},'P20atm')
%         legend_text{2}=['Vasu, ',pressure_text{k},', ','target'];
        legend_text{3}=['exp, ',pressure_text{k},', ','target'];

    else
%         legend_text{2}=['Shen, ',pressure_text{k},', ','target'];
        legend_text{3}=['exp, ',pressure_text{k},', ','target'];
    end
    
legend_text{2}=['MFC ',pressure_text{k},', after optimize'];
%% loading the ignition delay times

% loads the base mechanism's ignition delay time result
    load(simulation_result_beforeoptimize_text{1})
    fuel_sim={'beforeoptimize'};

     for j=1:length(fuel_sim)
        semilogy(sim.(mechanism{i}).(fuel_sim{1}).(pressure_text{k}).table.data(:,6),...
        sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).table.data(:,10),...
        'k--','markersize',marker_size)
     end


    hold on
    
   
% loads the optimized mechanism's ignition delay time result
    load(simulation_result_afteroptimize_text{1})
    fuel_sim={fuel_sim_text};


    
     semilogy(sim.(mechanism{1}).(fuel_sim{1}).(pressure_text{k}).table.data(:,6),...
     sim.(mechanism{1}).(fuel_sim{1}).(pressure_text{k}).table.data(:,10),...
     'b','markersize',marker_size)
   
% fixes the axes
ylim([0 10^5]);


% loads the target(experimental data) ignition delay time result
    if strcmp(pressure_text{k},'P20atm')
%     semilogy(Vasu_dode_20atm(:,2),Vasu_dode_20atm(:,5),'r*','markersize',marker_size) % pure dodecane
    semilogy(Vasu_20atm(:,2),Vasu_20atm(:,5),'r^','markersize',marker_size,'markerface','r') % Jet A
    hold on;
    semilogy(Wang_20atm(:,2),Wang_20atm(:,5),'r^','markersize',marker_size,'markerface','r') % Jet A
    hold on;
    semilogy(Dooley_20atm(:,2),Dooley_20atm(:,5),'r^','markersize',marker_size,'markerface','r')  % Jet A
    else
%     semilogy(Shen_dode_40atm(:,2),Shen_dode_40atm(:,5),'r*','markersize',marker_size)% pure dodecane
    semilogy(Wang_40atm(:,2),Wang_40atm(:,5),'rd','markersize',marker_size,'markerface','r') % Jet A
    end
%% upper bound & lowerbond
% The below shows the range of the variation. This can be use to check the
% range of ignition time when the rate parameters are varied(7 variations).


%     hold on
% 
% 
%     load('simulation_result_modify_20atm_phi_1.mat')
%     fuel_sim={'modify'};
% 
% 
% %     for j=1:length(fuel_sim)
% %         for q= 1: num_cases(k)
% %         semilogy(sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(num_cases_text{q}).table.data(:,6),...
% %         sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(num_cases_text{q}).table.data(:,10),...
% %         'bo','markersize',marker_size);
% %         end
% %     end
% %     hold on;
% 
%  x.(class_numb_text{1})=[]; y.(class_numb_text{1})=[];
%     for j=1:length(fuel_sim)
%         for q= 1: num_cases(k)
%             for m = 1: length(classnumb) 
%         x.(class_numb_text{m})(q)=sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(class_numb_text{m}).(num_cases_text{q}).table.data(1,6);
%         y.(class_numb_text{m})(q)=sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(class_numb_text{m}).(num_cases_text{q}).table.data(4,10);
%             end
%             
%         end
%     end
%     for m = 1: length(classnumb) 
% %      semilogy(x.(class_numb_text{m}),y.(class_numb_text{m}),'k','markersize',marker_size,'LineWidth',1.5);
%      hold on;
%     end
%  x.(class_numb_text{1})=[]; y.(class_numb_text{1})=[];
%     for j=1:length(fuel_sim)
%         for q= 1: num_cases(k)
%             for m = 1: length(classnumb)
%         x.(class_numb_text{m})(q)=sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(class_numb_text{m}).(num_cases_text{q}).table.data(1,6);
%         y.(class_numb_text{m})(q)=sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k}).(class_numb_text{m}).(num_cases_text{q}).table.data(7,10);
%             end
%             
%         end
%     end
%         for m = 1: length(classnumb) 
% %      semilogy(x.(class_numb_text{m}),y.(class_numb_text{m}),'k','markersize',marker_size,'LineWidth',1.5);  
%      hold on;
%         end
%%  setting the position of the figure  
    legend(legend_text,'location','SouthEast','interpreter','none')
    legend('boxoff')
    xlabel('1000/T (1/K)')
    ylabel('Ignition Delay Time (micros)')
    % axis([0.7 1.6 20 40000])
    % clear legend_text
    annotation(h3,'textbox',[0.413 0.38 0.279 0.05],...
    'String',{'JetA',...
     '/Air', '\phi=1'},...
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
