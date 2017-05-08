%%
clear all
close all

addpath(pwd)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           change 

mechanism='MFC'; %mechanism

fuel_name='JetA'; %surrogate fuel name


pressure_list=[40];
for k=1:length(pressure_list)
    pressure_text{k}=[num2str(pressure_list(k)),'atm'];

end

temp=700:25:1300; %K
% temp=975;
equi=1; %equivalence ratio
date = '05_03_2017';



%           change 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file_name=[mechanism,'_',fuel_name,'.inp'];


for k = 1:length(pressure_list)
    
    pressure = pressure_list(k);
directory=['C:\Users\unghee\Dropbox\post_process','\',mechanism,'\',fuel_name,'_',pressure_text{k},'_','phi',num2str(equi),'_',date];

mkdir(directory)
cd(directory)



mkdir('result')
cd('result')

%% problem type definition

problem_type='CONV'; % problem type, CONV: constant volume, solve energy equation
energy_eq='ENRG';    % ENRG, solve gas energy equation
sol='TRAN';          % Transient solver

%% physical property
% pressure=20; %atm
% temp=700:25:1300; %K
% 
% equi=1.5; %equivalence ratio

ifac=0.1; %ignition noise filtering factor
% klim='oh'; %species maximum fraction
if strcmp(mechanism,'MFC')
    klim='OH'; %species maximum fraction
elseif strcmp(mechanism,'Ra_Reitz')
     klim='oh';
     
end
dtig=400; %K, ignition delay definition - the time that the ambient I increases dtig 
qlos=0;  %heat loss

%% species property
if strcmp(mechanism,'MFC')
comb_product={'CO2' 'H2O' 'N2'};
elseif strcmp(mechanism,'Ra_Reitz')
comb_product={'co2' 'h2o' 'n2'};
end

load_surrogate_composition  
% 
% %UM1
% fuel={'nc12h26' 'hmn' 'mch' 'c6h5ch3'};
% fuel_composition=[0.3844 0.1484 0.2336 0.2336]; %mole fraction

% %UM2
% fuel={'nc12h26' 'hmn' 'decalin' 'c6h5ch3'};
% fuel_composition=[0.2897 0.1424 0.3188 0.2491]; %mole fraction


% fuel={'nc12h26'};
% fuel_composition=[1]; %mole fraction

if strcmp(fuel_name,'n_heptane')
 fuel={'nc7h16'};
 fuel_composition=[1]; %mole fraction

elseif strcmp(fuel_name,'n_dodecane')
    fuel={'NC12H26'};
    fuel_composition=[1]; %mole fraction

elseif strcmp(fuel_name,'JetA')
fuel={'NC12H26' 'HMN' 'DECALIN' 'C6H5CH3'};
fuel_composition=[0.4706 0.1669 0.2419 0.1206]; %mole fraction 
end


if strcmp(mechanism,'MFC')
oxidizer={'N2' 'O2'};
elseif strcmp(mechanism,'Ra_Reitz')
oxidizer={'n2' 'o2'};
end
oxidizer_composition=[0.79 0.21]; %mole fraction

%% solver control
time=1; %sec

%%


% mkdir(directory);
% cd(directory);
for i=1:length(temp)
    dir=num2str(i);
    mkdir(dir);
    cd(dir);
    temperature=temp(i);
    write_input_file;
    cd ..
end
cd ..
cd ..



end

