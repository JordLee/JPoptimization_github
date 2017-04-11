%updated for DTIG ouput - 3/28/2014
%For MFL_2013, ignition delay prediction based on delta T of 400K is added
%to data output file. To accomodate this, code is updated. 


function A = read_ignition_delay(location,num_cases)


    if ~isempty(findstr(location,'MFL_2013')) || ~isempty(findstr(location,'MFL_2014')) || ~isempty(findstr(location,'MFC_2012'))||...
            ~isempty(findstr(location,'Ra_Reitz')) ||  ~isempty(findstr(location,'MFC'))
        % if the mechanism was wither MFL_2013, MFL_2014, or MFC_2012
        
        for i=1:num_cases
%         file_path=[location,'/id_',num2str(i),'/CKSoln_solution_point_value_vs_solution_number.csv'];
        % location of the file
%         cd([location,'/id_',num2str(i)])

%         [data{i}.num data{i}.txt data{i}.raw]=csvread('CKSoln_solution_point_value_vs_solution_number.csv',1,0);


    cd([location,'/id_',num2str(i)])
       
    num=csvread('CKSoln_solution_point_value_vs_solution_number.csv',1,0);
%     file_path=['/scratch/engin_flux/unghee/chemkin/MFC/n_dodecane_20atm_phi1_03_16_2017_5_iteration/modify_sensitivity/class11/1/id_1/','CKSoln_solution_point_value_vs_solution_number.csv'];
    file_path=[location,'/id_',num2str(i),'/','CKSoln_solution_point_value_vs_solution_number.csv'];
    formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
    delimiter = ',';
    fileID=fopen(file_path,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true,  'ReturnOnError', false);   
        for j = 1 : 12
        text{1,j} = dataArray{1,j}(1,1);
       
        rawdat{1,j} = dataArray{1,j}(2,1);
        end
        raw = [text{1,:}; rawdat{1,:}];

        data{i}.num = num;
        data{i}.txt = text;
        data{i}.raw = raw;
        % read the file
        
        fclose(fileID);
        
        
        
        
        table.data(i,1:6)=data{i}.num(1:6);
        % keep the first 6 columns
        
        [m n]=size(data{i}.num);

            if n<7 % when the data file is only 6 columns wide, igntion was not achieved (or
                   % both DT and OH peak ignition criteria were not met). 
                display(['Warning: no ID data for ',location,', case#',num2str(i)]);
                table.data(i,7:8)=0;
                % then send warning and ignition delay time is set to zero.
                
            else if n==7 && strcmp(data{i}.txt{7},' Ignition_time_1_by_ignition_T_(sec)')
                    % when the data file is 7 columns wide and the header
                    % of 7th column is as above, ignition delay time is
                    % from DTIG criteria only, and OH peak criteria is not
                    % met. 
                 display(['Warning: Only DTIG ID data for ',location,', case#',num2str(i)]);   
                            table.data(i,7)=data{i}.num(7); %delta T 
                            table.data(i,8)=data{i}.num(7); %delta T 
                    % Then, send warning and ignition delay time for OH
                    % peak is same as DTIG igintion delay time.
                else
                    
                    % For the rest of the case, 7th column is DTIG ignition
                    % delay time, 8th ~ end columns are OH peak ignition
                    % delay time. OH peak ignition delay time can be
                    % multiple, since it looks for local minimum.
                    % Typically, the last one is responsible for the real
                    % ignition delay time, while 
                    %
                table.data(i,7)=data{i}.num(7); %delta T 
                table.data(i,8)=max(data{i}.num(8:end)); %oh peak
                end
            end
        end


            table.data=sortrows(table.data,6); %sort based on 1000/T
            
            temp=table.data(:,7:8); % to rearrange the table
            
            table.data(:,7)=temp(:,2); % oh peak to 7th and 8th column
            table.data(:,8)=table.data(:,7)*1000000;
            table.data(:,9)=temp(:,1); % delta T to 9th and 10th column
            table.data(:,10)=table.data(:,9)*1000000;

            for j=1:6
            table.header{j}=data{1}.txt{j};
            end
            table.header{7}='ignition_time_oh(s)';
            table.header{8}='ignition_time_oh(micros)';
            table.header{9}='ignition_time_dt(s)';
            table.header{10}='ignition_time_dt(micros)';
                  
            
            
               
    
    else                            % for rest of the mechanisms (previous)
        
%         for i=1:num_cases
%         file_path=[location,'\id_',num2str(i),'\CKSoln_solution_point_value_vs_solution_number.csv'];
%         [data{i}.num data{i}.txt data{i}.raw]=xlsread(file_path);
%         table.data(i,1:6)=data{i}.num(1:6);
%         [m n]=size(data{i}.num);
%         if n>6
%             table.data(i,7)=max(data{i}.num(7:end));
%         else
%             table.data(i,7)=0;
% 
%             display(['Warning: no ID data for ',location,', case#',num2str(i)]);
% 
%         end
%         end
%         table.data=sortrows(table.data,6);
%         table.data(:,8)=table.data(:,7)*1000000;
%         for j=1:6
%             table.header{j}=data{1}.txt{j};
%         end
%         table.header{7}='ignition_time_(s)';
%         table.header{8}='ignition_time_(micros)';
        
    end
    
    A.raw=data;
    A.table=table;
    
end




