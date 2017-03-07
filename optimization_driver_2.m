clear;
mechanism={'MFC'};
fuel_name={'n_dodecane'};
date = {'03_06_2017'};
fuel_sim={'modify_sensitivity'};
equi = 1;
classnumb=[11 15 21 22 23 24 26 27 28];
pressure=[40];
%% sensitivity
addpath('C:\Users\unghee\Dropbox\JPoptimization_github');
sensitivity_analysis_3;
clearvars -except sensitivity classnumb classnumb_text pressure_text pressure mechanism fuel_name date fuel_sim equi


m =1;
disp('looking at sensitivity at one pressure condition')
class_to_optimize.(pressure_text{m}) = [];
for k=1:length(classnumb)
    
%     if (sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig_avg > 1) && (sensitivity.(classnumb_text{k}).Sgr_avg > 0.5)
     if (sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig_avg > 1)...
             && (sensitivity.(pressure_text{m}).(classnumb_text{k}).Sgr_avg > 0.5)
        class_to_optimize.(pressure_text{m}) = [class_to_optimize.(pressure_text{m}) classnumb(k)];
     end
end

classnumb = class_to_optimize.(pressure_text{m})


%% Target setting
addpath('C:\Users\unghee\Dropbox\post_process');
real_fuel_ID;
pure_component_ID;
Target_fuel1 = Shen_dode_40atm;
Target_data.pressure_text{1}=Target_fuel1(:,5);
Temp.pressure_text{1} = Target_fuel1(:,2);
numbOftarget.(pressure_text{1}) =length(Target_data.pressure_text{1});
% Target_data=Target_fuel1(:,5);
% numbOftarget=length(Target_data);
% Temp=Target_fuel1(:,2);
Temp = [Temp.pressure_text{1}];
Target_data = [Temp.pressure_text{1}];


%% Optimization

clearvars -except classnumb Temp numberOftarget Target_data sensitivity pressure fuel_name
optimization_7_repro_multiple_2


%modification after optimize
% clearvars -except sensitivity classnumb pressure classnumb_text
% class_to_optimize = [];
% for k=1:length(classnumb)
%     
%     if (sensitivity.(pressure_text{k}).(classnumb_text{k}).Sig_avg > 1) && (sensitivity.(classnumb_text{k}).Sgr_avg > 0.5)
%         pressure_text{k}.class_to_optimize = [class_to_optimize k];
%     end
% end
% 
% 
% classnumb=pressure_text{k}.class_to_optimize;
% classnumb = [4,6];
%load 

% load -> output rightaway  bash