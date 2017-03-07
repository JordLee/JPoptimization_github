% clear all
% close all

% classnumb=[11 15 21 22 23 24 26 27 28];
numbOfClass = length(classnumb);
class_numb_text = {};
for k=1:numbOfClass
    class_numb_text=[class_numb_text ['class',num2str(classnumb(k))]];
end
fuel_sim={'modify'};

%% read modification ignition delay time 
% mechanism={'MFC'};
% mechanism={'MFC'};
% date = {'03_06_2017'};
% fuel_name = {'n_dodecane'};
% % fuel_name = {'n_heptane'};
% equi=1;

currentloc = 'C:\Users\unghee\Dropbox\post_process';



% pressure=[20 40];
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
% % Temp1=flip(Temp1);
% % Target_data1=flip(Target_data1);
% 
% Target_fuel2 = Shen_dode_40atm;
% Target_data2=Target_fuel2(:,5);
% Temp2 = Target_fuel2(:,2);
% 
% % Temp2=flip(Temp2);
% % Target_data2=flip(Target_data2);
% 
% numbOftarget2 =length(Target_data2);
% 
% 
% Temp = [Temp1; Temp2];
% Target_data = [Target_data1; Target_data2];
% % Temp = Temp1;
% % Target_data = Target_data1;
% 
% cd ../../..


%% dummy target

% num_cases_target=25;
% m = 1;  % pressure 20atm
% directory=[fuel_name{1},'_',pressure_text{m},'_','phi',num2str(equi),'_',date{1}];
% location_target=[currentloc,'\',mechanism{1},'\',directory,'\','beforeoptimize'];
% cd(location_target)
% addpath(currentloc)
% time_struct_target=read_ignition_delay(location_target,num_cases_target);
% Temp1=time_struct_target.table.data(:,6)/1000; % do we have to include temp?
% 
% 
% Target_data1=time_struct_target.table.data(:,10);
% % range = 12:22; % works slightly well ??
% % range = 12:25; % works slightly as well..
% range = 1:25;
% Temp1=flip(Temp1);
% Target_data1=flip(Target_data1);
% Temp1 = Temp1(range);
% Target_data1 = Target_data1(range);
% 
% cd ../../..
% 
% num_cases_target=25;
% m = 2;  % pressure 40atm
% directory=[fuel_name{1},'_',pressure_text{m},'_','phi',num2str(equi),'_',date{1}];
% location_target=[currentloc,'\',mechanism{1},'\',directory,'\','beforeoptimize'];
% cd(location_target)
% addpath(currentloc)
% time_struct_target=read_ignition_delay(location_target,num_cases_target);
% Temp2=time_struct_target.table.data(:,6)/1000; % do we have to include temp?
% 
% 
% Target_data2=time_struct_target.table.data(:,10);
% % range = 12:22; % works slightly well ??
% % range = 12:25; % works slightly as well..
% % range = 1:25;
% Temp2=flip(Temp2);
% Target_data2=flip(Target_data2);
% Temp2 = Temp2(range);
% Target_data2 = Target_data2(range);
% 
% cd ../../..
% Temp = [Temp1; Temp2];
% Target_data = [Target_data1 Target_data2];

    
    A = rateParam.(class_numb_text{1})(:,1);
    E = rateParam.(class_numb_text{1})(:,2);
%% read modification ignition delay time 
% mechanism={'Ra_Reitz'};
currentloc = 'C:\Users\unghee\Dropbox\post_process';
num_cases_modification= size(A,1);
% date = {'01_30_2017'};
% fuel_name = {'n_heptane'};

m=1; % pressure 20atm
directory=[fuel_name{1},'_',pressure_text{m},'_','phi',num2str(equi),'_',date{1}];
% for j = range
for j = 1: numbOftarget.pressure_text{m}
    for k = 1: numbOfClass
% location_modification=[currentloc,'\',mechanism{1},'_','modify','_',date{1},'\',num2str(Temp_un(j))];
    location_modification=[currentloc,'\',mechanism{1},'\',directory,'\',fuel_sim{1},'\',class_numb_text{k},'\',num2str(j)];
    time_struct_modification=read_ignition_delay(location_modification,num_cases_modification);
    time_modification.(class_numb_text{k})(:,j)=time_struct_modification.table.data(:,10);
    temp_modification.(class_numb_text{k})(:,j)=time_struct_modification.table.data(:,6);
    end
    
end
for k = 1: numbOfClass
%     time_modification.(class_numb_text{k})=time_modification.(class_numb_text{k})(:,range);
%     temp_modification.(class_numb_text{k})=temp_modification.(class_numb_text{k})(:,range); 
    time_modification.(class_numb_text{k})=time_modification.(class_numb_text{k})(:,1: numbOftarget.pressure_text{m});
    temp_modification.(class_numb_text{k})=temp_modification.(class_numb_text{k})(:,1: numbOftarget.pressure_text{m}); 
end

% m =2 ; % pressure 40atm
% directory=[fuel_name{1},'_',pressure_text{m},'_','phi',num2str(equi),'_',date{1}];
% % for j = 1: length(range)
% for j = 1: numbOftarget.pressure_text{m}
%     for k = 1: numbOfClass
% % location_modification=[currentloc,'\',mechanism{1},'_','modify','_',date{1},'\',num2str(Temp_un(j))];
%     location_modification=[currentloc,'\',mechanism{1},'\',directory,'\',fuel_sim{1},'\',class_numb_text{k},'\',num2str(j)];
%     time_struct_modification=read_ignition_delay(location_modification,num_cases_modification);
% %     time_modification.(class_numb_text{k})(:,length(range)+j)=time_struct_modification.table.data(:,10);
% %     temp_modification.(class_numb_text{k})(:,length(range)+j)=time_struct_modification.table.data(:,6);
%     time_modification.(class_numb_text{k})(:,numbOftarget.pressure_text{m-1}+j)=time_struct_modification.table.data(:,10);
%     temp_modification.(class_numb_text{k})(:,numbOftarget.pressure_text{m-1}+j)=time_struct_modification.table.data(:,6);
%     end
%     
% end
% 
% 
% % for k = 1: numbOfClass
% %     time_modification.(class_numb_text{k})=time_modification.(class_numb_text{k})(:,length(range)+range);
% %     temp_modification.(class_numb_text{k})=temp_modification.(class_numb_text{k})(:,length(range)+range); 
% % end



%%  coefficient
for j = 1 : size(Temp,1)  
% for k = 1 : 1
% for j = 1 : 1
    Temp_current = Temp(j);
    

    for k = 1: numbOfClass
    time_current = time_modification.(class_numb_text{k})(:,j);
    A = rateParam.(class_numb_text{k})(:,1);
    E = rateParam.(class_numb_text{k})(:,2);
    M = [log(A) log(Temp_current)*ones(7,1) E log(A).*(E) log(A).*log(A) E.^2];
%     totalM = [totalM M];
    d = log(time_current);
    coefs_inv = lsqlin(M,d);
    coefs_element = coefs_inv';
    
    

    coefs.(class_numb_text{k})(j,:)=coefs_element;

    prediction.(class_numb_text{k}){:,j}=M*coefs_element'-d;
    predictionreg.(class_numb_text{k}){:,j}=M*coefs_element';
%     plotregression(d,M*coefs_element')
    end
    
    
end
%% plot regression

% for k = 1: numbOfClass
% plotregression(log(time_modification.(class_numb_text{k})(:,1:10)),predictionreg.(class_numb_text{k})(1:10))
% end




%% OPTIMIZER

% Target Temp value
% te(:,1) = Target_data(:,3);
% te(:,1) = Target_data;
numberOftempPoints = size(Target_data,1);
%% objective function

% ObjectiveFunction = @(X) find_rate_3(X,coefs,Temp,numbOfClass,class_numb_text,Target_data);
ObjectiveFunction = @(X) find_rate_weighting(X,coefs,Temp,numbOfClass,class_numb_text,Target_data);
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
if strcmp(mechanism{1},'MFC') && ismember(21,classnumb)
LB =[LB rateParam.('class21')(1,1)*0.13 0 ];
UB =[UB rateParam.('class21')(1,1)*10 rateParam.('class15')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(22,classnumb)
LB =[LB rateParam.('class22')(1,1)*0.13 0 ];
UB =[UB rateParam.('class22')(1,1)*10 rateParam.('class15')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(23,classnumb)
LB =[LB rateParam.('class23')(1,1)*0.13 0 ];
UB =[UB rateParam.('class23')(1,1)*10 rateParam.('class15')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(24,classnumb)
LB =[LB rateParam.('class24')(1,1)*0.13 0 ];
UB =[UB rateParam.('class24')(1,1)*10 rateParam.('class15')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(11,classnumb)
LB =[LB rateParam.('class11')(1,1)*0.13 0 ];
UB =[UB rateParam.('class11')(1,1)*10 rateParam.('class15')(1,2)+2000 ];
end
if strcmp(mechanism{1},'MFC') && ismember(15,classnumb)
LB =[LB rateParam.('class15')(1,1)*0.13 0 ];
UB =[UB rateParam.('class15')(1,1)*10 rateParam.('class15')(1,2)+2000 ];
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
UB =[UB rateParam.('class28')(1,1)*10 rateParam.('class27')(1,2)+2000 ];
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

save('final_result.mat','final_result')

