clear;

%% initial setting
mechanism={'MFC'};
fuel_name={'n_dodecane'};
date = {'04_29_2017'};
fuel_sim={'modify_sensitivity_0_iteration'}; % change the number of iteration
equi = 1;
classnumb=[11 15 21 22 23 24 26 27 28]; % this value can be changed based on what mechanism use. Currently, it is set up for 361kp skeletal mech.
pressure=[20]; % add more pressure for mutiple condition optimization 
%% Target setting
addpath('C:\Users\unghee\Dropbox\post_process');
real_fuel_ID;
pure_component_ID;
Target_fuel1 = Vasu_dode_20atm; % n dodecane target value at 20 atm

Target_data1=Target_fuel1(:,5);
numbOftarget1=length(Target_data1);
Temp1=Target_fuel1(:,2);

Target_fuel2 = Shen_dode_40atm; % n dodecane target value at 40 atm
Target_data2=Target_fuel2(:,5);
Temp2 = Target_fuel2(:,2);
numbOftarget2=length(Target_data2);

Temp = [Temp1; Temp2];
Target_data = [Target_data1; Target_data2];

%% sensitivity
addpath('C:\Users\unghee\Dropbox\JPoptimization_github');
sensitivity_analysis_3; % executes sensitivity analysis

m =1;
disp('looking at sensitivity at one pressure condition')
class_to_optimize.(pressure_text{m}) = []; % saves sensitivities for pressures.
for k=1:length(classnumb)

     if (sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig_avg > 1)... %  thershold for translational sensitivity, user may change based on their needs
             && (sensitivity.(pressure_text{m}).(classnumb_text{k}).Sgr_avg >= 0.38) %  thershold for rotational sensitivity, user may change based on their needs
        class_to_optimize.(pressure_text{m}) = [class_to_optimize.(pressure_text{m}) classnumb(k)];
     end
end

classnumb = class_to_optimize.(pressure_text{m}) % classes to optimize after sensitivity analysis





%% Optimization
% classnumb= [26 27]
clearvars -except classnumb Temp Temp1 Temp2  numberOftarget Target_data Target_data1 numbOftarget1 sensitivity pressure fuel_name equi fuel_name mechanism fuel_sim date
optimization_7_repro_multiple_2 % executes mechanism optimizer


