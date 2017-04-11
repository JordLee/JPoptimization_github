clear;
mechanism={'MFC'};
fuel_name={'n_dodecane'};
date = {'03_23_2017_1_iteration'};
fuel_sim={'modify_sensitivity_3'};
equi = 1;
classnumb=[11 15 21 22 23 24 26 27 28];
pressure=[20 40];
%% Target setting
addpath('/scratch/engin_flux/unghee/chemkin/MFC');
real_fuel_ID;
pure_component_ID;
Target_fuel1 = Vasu_dode_20atm;

Target_data1=Target_fuel1(:,5);
numbOftarget1=length(Target_data1);
Temp1=Target_fuel1(:,2);

Target_fuel2 = Shen_dode_40atm;
Target_data2=Target_fuel2(:,5);
Temp2 = Target_fuel2(:,2);
numbOftarget2=length(Target_data2);

Temp = [Temp1; Temp2];
Target_data = [Target_data1; Target_data2];

%% sensitivity
% addpath('C:\Users\unghee\Dropbox\JPoptimization_github');
sensitivity_analysis_3;
% sensitivity_analysis_3_modify;
% clearvars -except sensitivity classnumb classnumb_text pressure_text pressure mechanism fuel_name date fuel_sim equi

m =1;
disp('looking at sensitivity at one pressure condition')
class_to_optimize.(pressure_text{m}) = [];
for k=1:length(classnumb)

     if (sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig_avg > 1)...
             && (sensitivity.(pressure_text{m}).(classnumb_text{k}).Sgr_avg >= 0.38)
        class_to_optimize.(pressure_text{m}) = [class_to_optimize.(pressure_text{m}) classnumb(k)];
     end
end

classnumb = class_to_optimize.(pressure_text{m})



%% Optimization
% classnumb= [26 27]
clearvars -except classnumb Temp Temp1 Temp2  numberOftarget Target_data Target_data1 numbOftarget1 sensitivity pressure fuel_name equi fuel_name mechanism fuel_sim date
optimization_7_repro_multiple_2

%% call modification func. if the tolerance is larger than.. and loop back to optimization driver

% if error < k , run optimization_driver_2
