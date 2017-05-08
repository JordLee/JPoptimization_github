

% pressure=[20 40]; % comment out for not using driver file/
numbOfPressure=length(pressure) ;
for k=1:length(pressure)
    pressure_text{k}=['P',num2str(pressure(k)),'atm'];
end
% classnumb=[1 2 3 4 5 6 7 8 9]; % comment out for not using driver file
numbOfClass=length(classnumb) ;
for k=1:numbOfClass
    classnumb_text{k}=['class',num2str(classnumb(k))];
end


%%%%setting%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp_markers={'ro' 'g*' 'g^'};
sim_line={'k-' 'k-s','k-d','k-^','k-x','k-o','k-p'};
marker_size=8;
line_width=2;
% developer note
% currently it is set up to check the sensitivities at one pressure
% condition. Even performing the multiple pressure sensitivity analysis, it
% assumes that at both pressure condtions the sensitivities are similar.
% However, user may want to perform sensitivity for each pressure
% condition. The code works for it, but for the optimizier this is not
% implemented(you cannot send both sensitivities info to optimizer). and
% this does not make since, because there is only one mechanism optimized even for
% multiple pressure optimization.
% m=2 ; % pressure  setting pressure for 40 atm if pressure = [20 40]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% sensitivity analysis
% mechanism={'Ra_Reitz'};
% fuel_sim={'modify_sensitivity'};
% fuel_name={'n_heptane'}
% equi = 1;
currentloc = 'C:\Users\unghee\Dropbox\post_process';
num_cases_modification= 3; % unlike 7 variations, sensitivity analysis only need 3 variations, which is base, k=2, k =0.5


for m = 1 : numbOfPressure

    for k = 1 :numbOfClass
     for j = 1: 25
        location_modification=['C:\Users\unghee\Dropbox\post_process','\',mechanism{1},'\',fuel_name{1},'_',num2str(pressure(m)),...
        'atm','_','phi',num2str(equi),'_',date{1},'\',fuel_sim{1},'\',classnumb_text{k},'\',num2str(j)];
        time_struct_modification=read_ignition_delay(location_modification,num_cases_modification); % load ignition time variation 
        sensitivity.(pressure_text{m}).(classnumb_text{k}).data(:,j)=time_struct_modification.table.data(:,10);
    
     end


    temp=700:25:1300;
    h =25;
    tbase = sensitivity.(pressure_text{m}).(classnumb_text{k}).data(1,:); % when base
    tk1 = sensitivity.(pressure_text{m}).(classnumb_text{k}).data(2,:); % when k = 2
    tk2 = sensitivity.(pressure_text{m}).(classnumb_text{k}).data(3,:); % when k = 0.5
    d_log_tk1=diff(log10(tk1)); % difference of ignition time at proximate temps when k =2
    d_log_tk2=diff(log10(tk2)); % difference of ignition time at proximate temps when k =0.5
    dh = log(h);
    k1 = 2;
    k2 = 0.5; 

    [peaks,locs] = findpeaks(tbase/1000); % find two peak temp
% yvalue=tbase/1000; % when it is milisecond
    locsValue = temp(locs);
    [peaks2,locs2] = findpeaks(-tbase/1000); % find two peak temp
% yvalue=tbase/1000; % when it is milisecond
    locsValue2 = temp(locs2);

    p_tempPoints_ig =[1, locs2, locs, length(temp)]; % find 4 temp points(2peak 2end point) for sensitivity analysis
    temp_p_tempPoints_ig=[temp(1),temp(locs2),temp(locs), temp(length(temp))];

%translational sensitivity
% for definition, refer to Ra&Reitz,2011 CNF paper
    sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig = ones(1,length(p_tempPoints_ig));
    for i = 1 : length(p_tempPoints_ig)
    sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig(i)...
        = 100*(log10(tk1(p_tempPoints_ig(i))) - log10(tk2(p_tempPoints_ig(i))))/(log10(tbase(i))*log10(k1/k2)); % translational shift
    end
 
     sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig_avg...
         = mean(abs(sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig));

 
    p_tempPoints_gr =[1, locs2, locs, length(temp)]; % added end point

    temp_p_tempPoints_gr=[temp(locs2),temp(locs), temp(length(temp))];
     sensitivity.(pressure_text{m}).(classnumb_text{k}).Sgr = ones(1,length(p_tempPoints_gr)-1);
%rotational sensitivity
    for i = 1 : length(p_tempPoints_gr)-1
     sensitivity.(pressure_text{m}).(classnumb_text{k}).Sgr(i)...
         = 100*(d_log_tk1(p_tempPoints_gr(i))/dh - d_log_tk2(p_tempPoints_gr(i))/dh)/log10(k1/k2); 
    end

    sensitivity.(pressure_text{m}).(classnumb_text{k}).Sgr_avg...
        = mean(abs(sensitivity.(pressure_text{m}).(classnumb_text{k}).Sgr));
   end

end


save('sensitivity.mat','sensitivity')

%% plotting the sensitivities. Currently it is turned off for calculation speed
% for m = 1 : numbOfPressure
% for k = 1 : numbOfClass
% h=figure('position',[20 50 1200 480]);
% subplot(1,2,1);
% set(gca,'Fontsize',13)
% semilogy(temp,sensitivity.(pressure_text{m}).(classnumb_text{k}).data(1,:)/1000,'k-','markersize',marker_size);
% hold on
% semilogy(temp,sensitivity.(pressure_text{m}).(classnumb_text{k}).data(2,:)/1000,'rs-','markersize',marker_size);
% hold on
% semilogy(temp,sensitivity.(pressure_text{m}).(classnumb_text{k}).data(3,:)/1000,'bx-','markersize',marker_size);
% 
% 
% semilogy([temp_p_tempPoints_ig(1),temp_p_tempPoints_ig(end)],...
%     [sensitivity.(pressure_text{m}).(classnumb_text{k}).data(1,1)/1000,...
%     sensitivity.(pressure_text{m}).(classnumb_text{k}).data(1,end)/1000]...
%     ,'gp','markersize',12);
% hold on
% semilogy(locsValue,peaks,'gp','markersize',12);
% hold on
% semilogy(locsValue2,-peaks2,'gp','markersize',12);
% 
% legend('baseline','k=2','k=1','extreme points')
% xlabel('1000/T (1/K)')
% ylabel('Ignition Delay Time (ms)')
% 
% 
% 
% 
% subplot(1,2,2);
% plot(temp_p_tempPoints_ig,sensitivity.(pressure_text{m}).(classnumb_text{k}).Sig,'k^-','markersize',marker_size);
% ylim([-25 25])
% hold on
% % figure
% plot(temp_p_tempPoints_gr,sensitivity.(pressure_text{m}).(classnumb_text{k}).Sgr,'ko-','markersize',marker_size);
% 
% ylim([-30 25])
% xlabel('1000/T (1/K)')
% ylabel('Ignition Delay Time (ms)')
% legend('ignition delay sensitivity','gradient sensitivity')
% 
% annotation(h,'textbox',[0.213 0.38 0.279 0.05],...
%     'String',{fuel_name{1},...
%      '/Air',classnumb_text{k}, '\phi=1',pressure_text{m}},...
%     'FontSize',13,...
%     'FontName','Arial',...
%     'FitBoxToText','off',...
%     'LineStyle','none');
% 
% % location_save=[currentloc,'\',mechanism{1},'\',directory];
% % cd(location_save)
% 
% mkdir('sensitivity');
% cd('sensitivity');
% saveas(h,classnumb_text{k},'fig')
% saveas(h,classnumb_text{k},'jpg')
% cd ../
% end
% end