% clear all
% close all

% classnumb=[15 22 26 27 28];
% classnumb=[11 15 22 24 26 27 28];
numbOfClass = length(classnumb);
class_numb_text = {};
for k=1:numbOfClass
    class_numb_text=[class_numb_text ['class',num2str(classnumb(k))]];
end
fuel_sim={'modify'};

%% read modification ignition delay time 
% mechanism={'MFC'};
mechanism={'MFC'};
date = {'03_16_2017_1_iteration'};
fuel_name = {'n_dodecane'};
% fuel_name = {'n_heptane'};
equi=1;

currentloc = 'C:\Users\unghee\Dropbox\post_process';


% pressure=[20];
for k=1:length(pressure)
    pressure_text{k}=[num2str(pressure(k)),'atm'];

end
m = 1;
directory=[fuel_name{1},'_',pressure_text{m},'_','phi',num2str(equi),'_',date{1}];
location_rateParam=[currentloc,'\',mechanism{1},'\',directory,'\',fuel_sim{1},'\',class_numb_text{1}];
cd(location_rateParam)
load rateParam.mat;
clear m;
%% exp data

% addpath('C:\Users\unghee\Dropbox\post_process');
% real_fuel_ID;
% pure_component_ID;
% Target_fuel1 = Vasu_dode_20atm;
% Target_data1=Target_fuel1(:,5);
% Temp1 = Target_fuel1(:,2);
% numbOftarget1 =length(Target_data1);


% Target_fuel2 = Shen_dode_40atm;
% Target_data2=Target_fuel2(:,5);
% Temp2 = Target_fuel2(:,2);
% numbOftarget2 =length(Target_data2);

% Temp = [Temp1; Temp2];
% Target_data = [Target_data1; Target_data2];

numbOftarget2=0;
Temp = Temp1;
Target_data = Target_data1;

cd ../../..

    
    A = rateParam.(class_numb_text{1})(:,1);
    E = rateParam.(class_numb_text{1})(:,2);
%% read modification ignition delay time 

currentloc = 'C:\Users\unghee\Dropbox\post_process';
num_cases_modification= size(A,1);

m=1; % pressure 20atm
directory=[fuel_name{1},'_',pressure_text{m},'_','phi',num2str(equi),'_',date{1}];

for j = 1: numbOftarget1
    for k = 1: numbOfClass

    location_modification=[currentloc,'\',mechanism{1},'\',directory,'\',fuel_sim{1},'\',class_numb_text{k},'\',num2str(j)];
    time_struct_modification=read_ignition_delay(location_modification,num_cases_modification);
    time_modification.(class_numb_text{k})(:,j)=time_struct_modification.table.data(:,10);
    temp_modification.(class_numb_text{k})(:,j)=time_struct_modification.table.data(:,6);
    end
    
end
for k = 1: numbOfClass

    time_modification.(class_numb_text{k})=time_modification.(class_numb_text{k})(:,1: numbOftarget1);
    temp_modification.(class_numb_text{k})=temp_modification.(class_numb_text{k})(:,1: numbOftarget1); 
end

% m =2 ; % pressure 40atm
% directory=[fuel_name{1},'_',pressure_text{m},'_','phi',num2str(equi),'_',date{1}];
% 
% for j = 1: numbOftarget2
%     for k = 1: numbOfClass
% 
%     location_modification=[currentloc,'\',mechanism{1},'\',directory,'\',fuel_sim{1},'\',class_numb_text{k},'\',num2str(j)];
%     time_struct_modification=read_ignition_delay(location_modification,num_cases_modification);
%     time_modification.(class_numb_text{k})(:,numbOftarget1+j)=time_struct_modification.table.data(:,10);
%     temp_modification.(class_numb_text{k})(:,numbOftarget1+j)=time_struct_modification.table.data(:,6);
%     end
%     
% end





%%  coefficient
for j = 1 : size(Temp,1)  

    Temp_current = Temp(j);
    

    for k = 1: numbOfClass
    time_current = time_modification.(class_numb_text{k})(:,j);
    A = rateParam.(class_numb_text{k})(:,1);
    E = rateParam.(class_numb_text{k})(:,2);
    M = [log(A) log(Temp_current)*ones(7,1) E log(A).*(E) log(A).*log(A) E.^2];
    d = log(time_current);
    coefs_inv = lsqlin(M,d);
    coefs_element = coefs_inv';
    
    

    coefs.(class_numb_text{k})(j,:)=coefs_element;

    prediction.(class_numb_text{k}){:,j}=M*coefs_element'-d;
%     predictionreg.(class_numb_text{k}){:,j}=M*coefs_element';
%     plotregression(d,M*coefs_element')
    end
    
    
end
% plot regression
% 
% for k = 1: numbOfClass
% plotregression(log(time_modification.(class_numb_text{k})(:,1:10)),predictionreg.(class_numb_text{k})(1:10))
% end




%% OPTIMIZER

% Target Temp value

numberOftempPoints = size(Target_data,1);
%% objective function

ObjectiveFunction = @(X) find_rate_weighting(X,coefs,Temp,numbOfClass,class_numb_text,Target_data,numbOftarget1,numbOftarget2);
LB =[];
UB =[];
% class2
if strcmp(mechanism{1},'Ra_Reitz') && ismember(2,classnumb)
LB =[LB rateParam.('class2')(1,1)*0.13 0 ];
UB =[UB rateParam.('class2')(1,1)*10 rateParam.('class2')(1,2)+2000 ];

end
% class4
if strcmp(mechanism{1},'Ra_Reitz') && ismember(4,classnumb)
LB =[LB rateParam.('class4')(1,1)*0.13 0 ];
UB =[UB rateParam.('class4')(1,1)*10 rateParam.('class4')(1,2)+2000 ];
end

% class6
if strcmp(mechanism{1},'Ra_Reitz') && ismember(6,classnumb)
LB =[LB rateParam.('class6')(1,1)*0.13 0 ];
UB =[UB rateParam.('class6')(1,1)*10 rateParam.('class6')(1,2)+2000 ];
end

% ndodecane
if strcmp(mechanism{1},'MFC') && ismember(11,classnumb)
LB =[LB rateParam.('class11')(1,1)*0.13 0 ];
UB =[UB rateParam.('class11')(1,1)*10 rateParam.('class11')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(15,classnumb)
LB =[LB rateParam.('class15')(1,1)*0.13 0 ];
UB =[UB rateParam.('class15')(1,1)*10 rateParam.('class15')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(21,classnumb)
LB =[LB rateParam.('class21')(1,1)*0.13 0 ];
UB =[UB rateParam.('class21')(1,1)*10 rateParam.('class21')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(22,classnumb)
LB =[LB rateParam.('class22')(1,1)*0.13 0 ];
UB =[UB rateParam.('class22')(1,1)*10 rateParam.('class22')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(23,classnumb)
LB =[LB rateParam.('class23')(1,1)*0.13 0 ];
UB =[UB rateParam.('class23')(1,1)*10 rateParam.('class23')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(24,classnumb)
LB =[LB rateParam.('class24')(1,1)*0.13 0 ];
UB =[UB rateParam.('class24')(1,1)*10 rateParam.('class24')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(26,classnumb)
LB =[LB rateParam.('class26')(1,1)*0.13 0 ];
UB =[UB rateParam.('class26')(1,1)*10 rateParam.('class26')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(27,classnumb)
LB =[LB rateParam.('class27')(1,1)*0.13 0 ];
UB =[UB rateParam.('class27')(1,1)*10 rateParam.('class27')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(28,classnumb)
LB =[LB rateParam.('class28')(1,1)*0.13 0 ];
UB =[UB rateParam.('class28')(1,1)*10 rateParam.('class28')(1,2)+2000 ];
end

nvars=2*numbOfClass;
options=gaoptimset('PopulationSize',500);
[result_ga,Fval,exitFlag,Output] = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB,[],options);
[result_fmin,Fval,exitFlag,Output] = fmincon(ObjectiveFunction,result_ga,[],[],[],[],LB,UB);

X = result_ga;

error=ObjectiveFunction(X)

for i = 1 : numbOfClass
final_result.(class_numb_text{i})= [result_ga(1,2*i-1:2*i); result_fmin(1,2*i-1:2*i)];
end

location_save=[currentloc,'\',mechanism{1},'\',directory];
cd(location_save)
cd ../

save('final_result.mat','final_result')

