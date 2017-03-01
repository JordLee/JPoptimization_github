clear all
% close all


%test
classnumb=[6];
numbOfClass = length(classnumb);
class_numb_text = {};
for k=1:numbOfClass
%     classnumb_text{classnumb(k)}=['class',num2str(classnumb(k))];
    class_numb_text=[class_numb_text ['class',num2str(classnumb(k))]];
end
fuel_sim={'modify_class4_class6_success'};

%% read modification ignition delay time 
% mechanism={'MFC'};
mechanism={'Ra_Reitz'};
% currentloc = pwd;
date = {'01_30_2017'};
% fuel_name = {'n_dodecane'};
fuel_name = {'n_heptane'};
equi=1;

currentloc = 'C:\Users\unghee\Dropbox\post_process';





pressure=[20 40];
for k=1:length(pressure)
    pressure_text{k}=[num2str(pressure(k)),'atm'];

end
k = 2
directory=[fuel_name{1},'_',pressure_text{k},'_','phi',num2str(equi),'_',date{1}];
% location_rateParam = [currentloc,'\',mechanism{1},'\',fuel_name]
location_rateParam=[currentloc,'\',mechanism{1},'\',directory,'\',fuel_sim{1},'\',class_numb_text{1}];
cd(location_rateParam)
load rateParam.mat;


% load rateParam.mat;

% real_fuel_ID;
% pure_component_ID;
% Target_data = Shen_hep_40atm;
% % Target_data = Vasu_40atm;
% % Target_data = Wang_40atm;
% Temp = Target_data(:,2);
% Temp_un = Target_data(:,1);

num_cases_target=25;
location_target=[currentloc,'\',mechanism{1},'\',directory,'\','beforeoptimize'];
cd(location_target)
addpath(currentloc)
time_struct_target=read_ignition_delay(location_target,num_cases_target);
Temp=time_struct_target.table.data(:,6)/1000; % do we have to include temp?


Target_data=time_struct_target.table.data(:,10);
range = 13:20;

Temp=flip(Temp);
Target_data=flip(Target_data);
Temp = Temp(range);
Target_data = Target_data(range);

cd ../../..


pressure=[20 40];
for k=1:length(pressure)
    pressure_text{k}=[num2str(pressure(k)),'atm'];

end
equi=1;

% class_numb_text{1} = ['class6'];

    
    A = rateParam.(class_numb_text{1})(:,1);
    E = rateParam.(class_numb_text{1})(:,2);
%% read modification ignition delay time 
mechanism={'Ra_Reitz'};
currentloc = 'C:\Users\unghee\Dropbox\post_process';
num_cases_modification= size(A,1);
date = {'01_30_2017'};
fuel_name = {'n_heptane'};
directory=[fuel_name{1},'_',pressure_text{k},'_','phi',num2str(equi),'_',date{1}];
for j = range
    for k = 1: numbOfClass
% location_modification=[currentloc,'\',mechanism{1},'_','modify','_',date{1},'\',num2str(Temp_un(j))];
    location_modification=[currentloc,'\',mechanism{1},'\',directory,'\',fuel_sim{1},'\',class_numb_text{k},'\',num2str(j)];
    time_struct_modification=read_ignition_delay(location_modification,num_cases_modification);
    time_modification.(class_numb_text{k})(:,j)=time_struct_modification.table.data(:,10);
    temp_modification.(class_numb_text{k})(:,j)=time_struct_modification.table.data(:,6);
    end
    
end
for k = 1: numbOfClass
    time_modification.(class_numb_text{k})=time_modification.(class_numb_text{k})(:,range);
    temp_modification.(class_numb_text{k})=temp_modification.(class_numb_text{k})(:,range); 
end
%%  coefficient
for j = 1 : size(Temp,1)  
% for k = 1 : 1
  
    Temp_current = Temp(j);
    
%     type = fittype({'log(x)','log(Temp_current)','y','log(x)*y','(log(x))^2','y^2'}...  % linear term3     
%     ,'independent', {'x', 'y'},'dependent','z','problem','Temp_current');
%  options=fitoptions('Method','LinearLeastSquares')
%     sf = fit([A,E],log(time_current),type,options, 'problem',Temp_current);
% 
%     coefs(k,:)=coeffvalues(sf);
%     plot(sf,[A,E],log(time_current));
%     zlim([4 9]);
%     totalM = [];
    for k = 1: numbOfClass
    time_current = time_modification.(class_numb_text{k})(:,j);
    A = rateParam.(class_numb_text{k})(:,1);
    E = rateParam.(class_numb_text{k})(:,2);
    M = [log(A) log(Temp_current)*ones(7,1) E log(A).*(E) log(A).*log(A) E.^2];
%     totalM = [totalM M];
    d = log(time_current);
    coefs_inv = lsqlin(M,d);
    coefs_element = coefs_inv';
    
    
 
%     coefsTotal = [];
    
%     for n = 1: length(class_numb_text)
%     coefs.(class_numb_text{n})(k,:)=coefs_element(1,6*n-5:6*n);
    coefs.(class_numb_text{k})(j,:)=coefs_element;
%     coefsTotal =[coefsTotal coefs.(class_numb_text{k})(j,:)];
    prediction.(class_numb_text{k}){:,j}=M*coefs_element'-d;
    end
    
    
    
   
    
%     Model_igtime=@(x,y) coefs(k,1)*log(x)+coefs(k,2)*log(Temp_current)+coefs(k,3)*y...
%     + coefs(k,4)*log(x)*y + coefs(k,5)*(log(x))^2+coefs(k,6)*y^2; % linear term3
% 
%      for i= 1: size(A,1)
%          prediction{:,k}(i,1)=exp(Model_igtime(A(i),E(i)));  
%      end
%     prediction{:,k}(:,2)=time_current;
%     prediction{:,k}(:,3)= prediction{:,k}(:,1)-prediction{:,k}(:,2);
%     prediction{:,k}(:,4)= mean(abs(prediction{:,k}(:,3)));
    
end

% coefs=coefs.class4;

%% OPTIMIZER

% Target Temp value

% te(:,1) = Target_data(:,3);

te(:,1) = Target_data;
numberOftempPoints = size(te(:,1),1);
%% objective function
% ObjectiveFunction=ObjectiveFunction_array5(numberOftempPoints,numbOfClass,te,Temp,coefs);
% ObjectiveFunction=ObjectiveFunction_array6(numberOftempPoints,numbOfClass,te,Temp,coefs,class_numb_text);
ObjectiveFunction = @(X) find_rate_3(X,coefs,Temp,numbOfClass,class_numb_text,Target_data);

LB =[];
UB =[];

% class4
if strcmp(mechanism{1},'Ra_Reitz') && ismember(4,classnumb)
% LB =[0.706e+14*0.13 37904-2000 ];
% LB =[0.706e+14*0.13 0 ];
% UB =[0.706e+14*10 37904+2000];
LB =[42360000000000*0.13 0 ];
UB =[42360000000000*10 35904+2000];
end

% class6
if strcmp(mechanism{1},'Ra_Reitz') && ismember(6,classnumb)
LB =[LB 19955000000000*0.13 0];
UB =[UB 19955000000000*10 16232.712+2000];
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
%% read final ignition delay time after optimization   plug into plot part.
% mechanism={'Ra_Reitz'};
% fuel_sim={'afteroptimize_class6_temp_all_shen' };
% pressure = 40;
% num_cases=25;
% currentloc = pwd;
% location=[currentloc,'\',mechanism{i},'\',fuel_sim{1},'_',num2str(pressure(1)),'atm_phi1'];
% 
% %         
%         time_struct=read_ignition_delay(location,num_cases);
%         time=time_struct.table.data(:,10)/1000;
