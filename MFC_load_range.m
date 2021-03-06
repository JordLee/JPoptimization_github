clear all
close all

%%
mechanism={'MFC'};
% fuel_sim={'base','v1','v2','v3' };
fuel_sim={'modify'};
fuel_name={'n_dodecane'};
date = {'03_08_2017'};
equi =1;
% pressure=[20 40 ];
pressure = [20];
for k=1:length(pressure)
    pressure_text{k}=['P',num2str(pressure(k)),'atm'];
end

classnumb=[15 22 26 27 28];
numbOfClass = length(classnumb);
class_numb_text = {};
for k=1:numbOfClass
    class_numb_text=[class_numb_text ['class',num2str(classnumb(k))]];
end
num_cases=[26 11];
num_cases_text = {};
for k=1:num_cases(1)
    num_cases_text=[num_cases_text ['numcases',num2str(k)]];
end
%%

for i=1:length(mechanism)
    for j=1:length(fuel_sim)
     for k = 1: length(classnumb)   
%         phi=1 simulation results
        for m=1:length(pressure)
            for q=1:num_cases(m)
                location=['C:\Users\unghee\Dropbox\post_process','\',mechanism{i},'\',fuel_name{1},'_',num2str(pressure(m))...
                 ,'atm','_','phi',num2str(equi),'_',date{1},'\',fuel_sim{j},'\',class_numb_text{k},'\',num2str(q)];        
                sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{m}).(class_numb_text{k}).(num_cases_text{q})=read_ignition_delay(location,7);
            end
        end
        
     end
    end
end   


directory=['C:\Users\unghee\Dropbox\post_process','\',mechanism{1},'\',fuel_name{1},'_',num2str(pressure(1))...
    ,'atm','_','phi',num2str(equi),'_',date{1}];
cd(directory);
cd(fuel_sim{1});
filename = ['simulation_result','_',fuel_sim{1},'_',num2str(pressure(1)),'atm','_','phi','_',num2str(equi),'.mat'];
save(filename,'sim')
