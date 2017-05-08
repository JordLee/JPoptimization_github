clear all
close all

%%
mechanism={'MFC'};

fuel_sim={'afteroptimize_3'};
fuel_name={'JetA'};
date = {'05_03_2017'};
equi =1;

pressure = [40];
for k=1:length(pressure)
    pressure_text{k}=['P',num2str(pressure(k)),'atm'];
end
num_cases=25;


for i=1:length(mechanism)
    for j=1:length(fuel_sim)
        
%         phi=1 simulation results
        for k=1:length(pressure)
        location=['C:\Users\unghee\Dropbox\post_process','\',mechanism{i},'\',fuel_name{1},'_',num2str(pressure(k)),'atm','_','phi',num2str(equi),'_',date{1},'\',fuel_sim{j}];
      
        sim.(mechanism{i}).(fuel_sim{j}).(pressure_text{k})=read_ignition_delay(location,num_cases);

        end
      
        
    end
end   

directory=['C:\Users\unghee\Dropbox\post_process','\',mechanism{1},'\',fuel_name{1},'_',num2str(pressure(1)),'atm','_','phi',num2str(equi),'_',date{1}];

cd(directory);
cd(fuel_sim{1});
filename = ['simulation_result','_',fuel_sim{1},'_',num2str(pressure(1)),'atm','_','phi','_',num2str(equi),'.mat'];
save(filename,'sim')
