clear;
close all;
mechanism={'Ra_Reitz'};
fuel_name={'n_heptane'};
date = {'01_30_2017'};
fuel_sim={'modify_class2_class4_class6_moderate'};
equi = 1;
pressure=[40];
classnumb=[2 4 6];

sensitivity_analysis_3;

clearvars -except sensitivity classnumb classnumb_text pressure_text pressure mechanism fuel_name date fuel_sim equi
% Determine classes with overall sensitivity
classnumb_optimize.entire.(pressure_text{1}) = [];
% classnumb_optimize.entire.(pressure_text{1}) = sturct([]);
pressure_optimize_text =[];
pressure_optimize =[];
for m = 1 : length(pressure)
    for k=1:length(classnumb)
    
      if (sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig_avg > 1) && (sensitivity.(pressure_text{m}).(classnumb_text{k}).Sgr_avg > 0.5)
          classnumb_optimize.entire.(pressure_text{m}) = [ classnumb_optimize.entire.(pressure_text{m}) classnumb(k)];
         
      end
    end
     pressure_optimize_text = [pressure_optimize pressure_text{m}];
     pressure_optimize = [pressure_optimize pressure(m)];
end
     
 for m = 1 : length(pressure_optimize)        
 classnumb=classnumb_optimize.entire.(pressure_text{m}); %have to change for multiple pressure in optimization.m
 end
%% HTR optimize 
% add sgr information for the future work
classnumb_optimize.HTR.(pressure_text{1}) = [];
pressure_optimize_text =[];
pressure_optimize =[];
for m = 1 : length(pressure)
    for k=1:length(classnumb)
    
        if (abs(sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig(4))) > 1
            classnumb_optimize.HTR.(pressure_text{m}) = [classnumb_optimize.HTR.(pressure_text{m}) classnumb(k)];
        end
    end
       pressure_optimize_text = [pressure_optimize pressure_text{m}];
       pressure_optimize = [pressure_optimize pressure(m)];
end
for m = 1 : length(pressure_optimize)  
classnumb=classnumb_optimize.HTR.(pressure_text{m});
end
pressure = pressure_optimize;

clearvars -except classnumb pressure mechanism fuel_name date fuel_sim equi classnumb_optimize sensitivity
range = 1:10;
% optimization_10;
optimization_7_repro_multiple_2;
%%
% final result for HTR, and LockDouwn
clearvars -except final_result pressure mechanism fuel_name date fuel_sim equi classnumb_optimize sensitivity pressure_text

numbOfPressure=length(pressure) ;
for k=1:length(pressure)
    pressure_text{k}=['P',num2str(pressure(k)),'atm'];
end

classnumb_optimize.NTC.(pressure_text{1})=[];
pressure_optimize_text =[];
pressure_optimize =[];
Entire = classnumb_optimize.entire.(pressure_text{1});
HTR = classnumb_optimize.HTR.(pressure_text{1});

classnumb_optimize.NTC.(pressure_text{1})...
    = setxor(Entire,HTR);
numbOfClass_NTC = length(classnumb_optimize.NTC.(pressure_text{1}));

class_numb_text_NTC = {};
for k=1:numbOfClass_NTC
%     classnumb_text{classnumb(k)}=['class',num2str(classnumb(k))];
    class_numb_text_NTC=[class_numb_text_NTC ['class',num2str(classnumb_optimize.NTC.(pressure_text{1})(k))]];
end

classnumbOfNTC = [];
for m = 1 : length(pressure)
    for k=1:numbOfClass_NTC
    
        if (abs(sensitivity.(pressure_text{m}).(class_numb_text_NTC{k}).Sig(2)) > 1) 
            classnumbOfNTC = [classnumbOfNTC classnumb_optimize.NTC.(pressure_text{1})(k)];
        end
    end
       pressure_optimize_text = [pressure_optimize pressure_text{m}];
       pressure_optimize = [pressure_optimize pressure(m)];
end
classnumb_optimize.NTC.(pressure_text{m}) = classnumbOfNTC;

for m = 1 : length(pressure_optimize)  
classnumb=classnumb_optimize.NTC.(pressure_text{m});
end
pressure = pressure_optimize;


clearvars -except final_result classnumb pressure mechanism fuel_name date fuel_sim equi classnumb_optimize sensitivity
range = 12:20;

optimization_7_repro_multiple_2;

%modification after optimize

%load 

% load -> output rightaway  bash