
clear all;
%% Import data from text file.
% Script for importing data from the following text file:
%
%    /home/jordan/Documents/Research/matlabfolder/mech.dat
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/08/24 17:10:49

%% Initialize variables.
% filename = '/scratch/engin_flux/unghee/chemkin/mechanisms/mech_ERC-MultiChem+Bio_Brakora2012.inp';
currentFolder = pwd;
cd(pwd);
% cd mechanisms/;

%% Settings %%%%%%%%%%%%%%%%%%%%%%%%%%%
fuel_name='n_dodecane';
mechanism='MFC';
% class_numb =6;
class_numb = [15];
numbOfClass = length(class_numb);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%filename = [mechanism,'_',fuel_name,'_','class6.inp'];
filename = [mechanism,'_','base.inp'];
delimiter = ' ';


%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));


%% Split data into numeric and cell columns.
rawNumericColumns = {};
rawCellColumns = raw(:, [1,2,3,4,5,6,7,8,9]);


 %% Replace non-numeric cells with NaN

[A,B]= find(ismember(rawCellColumns,'ELEMENTS'));

locationClass = [A B];

[rowCellNumber,] = size(rawCellColumns);




for k = 1 : numbOfClass

    rawCellColumns2=rawCellColumns;
    class_numb_text{k} = ['class' num2str(class_numb(k))];

    for variation_numb = 1:7;
    ModStart = 0;    
        for i=1 : rowCellNumber
        [ ~, columnCellNumber] = size(rawCellColumns(i,:));
%     for j= 1 : cellfun('length',rawCellColumns{i,:})
             for j= 1 : 1: columnCellNumber
        
                    if (strcmp('REACTIONS',rawCellColumns{i,j}) == 1 || strcmp('reactions',rawCellColumns{i,j})==1);
                    ModStart = 1;    
                    end  

             %% classes modification   
%                 if   class_numb == 1 & (strfind(rawCellColumns{i,j},'nc7h16+h=') == 1)... % n heptane erc
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1)...
%                      |(class_numb == 2 & (strfind(rawCellColumns{i,j},'nc7h16+oh=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...
%                      |(class_numb == 3 & (strfind(rawCellColumns{i,j},'nc7h16+ho2=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...
%                      |(class_numb == 4 & (strfind(rawCellColumns{i,j},'nc7h16+o2=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...
%                      |(class_numb == 5 & (strfind(rawCellColumns{i,j},'c7h15-2+o2=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...
%                      | class_numb == 6 & (strfind(rawCellColumns{i,j},'c7h15o2+o2=') == 1)... % n heptane erc
%                      & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1)...
%                      |(class_numb == 7 & (strfind(rawCellColumns{i,j},'c7ket12=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...                     
%                      |(class_numb == 8 & (strfind(rawCellColumns{i,j},'c5h11co=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...    
%                      |(class_numb == 9 & (strfind(rawCellColumns{i,j},'c7h15-2=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...    
                         
                 if  class_numb(k) == 27 & (strfind(rawCellColumns{i,j},'C12OOH') ~= 0)... % n dodecane ske_361
                         & (isempty(strfind(rawCellColumns{i,j},'O2=C12KET')) == 0)...
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...   
                      |class_numb(k) == 21 & (strfind(rawCellColumns{i,j},'NC12H26+H=C12H25') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'NC12H26+H=C12H25')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)... 
                      |class_numb(k) == 22 & (strfind(rawCellColumns{i,j},'NC12H26+OH=C12H25') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'NC12H26+OH=C12H25')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)... 
                      |class_numb(k) == 23 & (strfind(rawCellColumns{i,j},'NC12H26+O=C12H25') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'NC12H26+O=C12H25')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...                          
                      |class_numb(k) == 24 & (strfind(rawCellColumns{i,j},'NC12H26+HO2=C12H25') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'NC12H26+HO2=C12H25')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...                       
                     |class_numb(k) == 11 & (strfind(rawCellColumns{i,j},'C12H25') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'+O2=C12H25O2')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)... 
                     |class_numb(k) == 28 & (strfind(rawCellColumns{i,j},'C12KET') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'=OH+')) == 0)...
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...                      
                     |class_numb(k) == 26 & (strfind(rawCellColumns{i,j},'C12OOH') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'O2=C12OOH')) == 0)...
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...
                     |class_numb(k) == 15 & (strfind(rawCellColumns{i,j},'C12H25O2') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'=C12OOH')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i,j},'C12OOH6-3')) == 1)...
                         & (isempty(strfind(rawCellColumns{i,j},'C12OOH6-9')) == 1)...
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...                                           
                      
%%
                      if variation_numb == 1 
                             rawCellColumns2{i,9} =  ['!***ClASS',num2str(class_numb(k)),'***','v_',num2str(variation_numb)];
                             rawCellColumns2{i,2} = str2num(rawCellColumns{i,2});  % same
                             lsqfit(variation_numb,1) = str2num(rawCellColumns{i,2});
                             lsqfit(variation_numb,2) = str2num(rawCellColumns{i,4});
%                              lsqfit(variation_numb+1,1) = str2num(rawCellColumns{i,2});
%                              lsqfit(variation_numb+1,2) = str2num(rawCellColumns{i,4});
                      elseif variation_numb == 2 
                             rawCellColumns2{i,9} =  ['!***ClASS',num2str(class_numb(k)),'***','v_',num2str(variation_numb)];
                             rawCellColumns2{i,2} = str2num(rawCellColumns{i,2})*2;  % A*2
                             lsqfit(variation_numb,1) = str2num(rawCellColumns{i,2})*2;
                             lsqfit(variation_numb,2) = str2num(rawCellColumns{i,4});
%                              lsqfit(variation_numb+1,1) = str2num(rawCellColumns{i,2})*2;
%                              lsqfit(variation_numb+1,2) = str2num(rawCellColumns{i,4});
                      elseif variation_numb == 3
                             rawCellColumns2{i,9} =  ['!***ClASS',num2str(class_numb(k)),'***','v_',num2str(variation_numb)];
                             rawCellColumns2{i,2} = str2num(rawCellColumns{i,2})*0.5; % A*0.5
                             lsqfit(variation_numb,1) = str2num(rawCellColumns{i,2})*0.5;
                             lsqfit(variation_numb,2) = str2num(rawCellColumns{i,4});
                      elseif variation_numb == 4
                             rawCellColumns2{i,9} =  ['!***ClASS',num2str(class_numb(k)),'***','v_',num2str(variation_numb)];
                             rawCellColumns2{i,2} = str2num(rawCellColumns{i,2})*7.5; % A>>1, A*7.5
                             rawCellColumns2{i,4} = str2num(rawCellColumns{i,4})+2000; % E+2000 
                             lsqfit(variation_numb,1) = str2num(rawCellColumns{i,2})*7.5;
                             lsqfit(variation_numb,2) = str2num(rawCellColumns{i,4})+2000;
                      elseif variation_numb == 5
                             rawCellColumns2{i,9} =  ['!***ClASS',num2str(class_numb(k)),'***','v_',num2str(variation_numb)];
                             rawCellColumns2{i,2} = str2num(rawCellColumns{i,2})*1.6;% A>1 
                             rawCellColumns2{i,4} = str2num(rawCellColumns{i,4})+2000; % E+2000
                             lsqfit(variation_numb,1) = str2num(rawCellColumns{i,2})*1.6;% A>1 
                             lsqfit(variation_numb,2) = str2num(rawCellColumns{i,4})+2000; % E+2000                          
                      elseif variation_numb == 6
                             rawCellColumns2{i,9} =  ['!***ClASS',num2str(class_numb(k)),'***','v_',num2str(variation_numb)];
                             rawCellColumns2{i,2} = str2num(rawCellColumns{i,2})*0.6; % A<1  
                             lsqfit(variation_numb,1) = str2num(rawCellColumns{i,2})*0.6;
                             if str2num(rawCellColumns{i,4})-2000>0;
                                rawCellColumns2{i,4} = str2num(rawCellColumns{i,4})-2000; % E-2000 
                                lsqfit(variation_numb,2) = str2num(rawCellColumns{i,4})-2000;
                             else
                                rawCellColumns2{i,4} = 0;
                                lsqfit(variation_numb,2) = 0;
                             end           
                      elseif variation_numb == 7
                             rawCellColumns2{i,9} =  ['!***ClASS',num2str(class_numb(k)),'***','v_',num2str(variation_numb)];
                             rawCellColumns2{i,2} = str2num(rawCellColumns{i,2})*0.13; % A<<1  
                             lsqfit(variation_numb,1) = str2num(rawCellColumns{i,2})*0.13; 
                             if str2num(rawCellColumns{i,4})-2000>0;
                                rawCellColumns2{i,4} = str2num(rawCellColumns{i,4})-2000; % E-2000 
                                lsqfit(variation_numb,2) = str2num(rawCellColumns{i,4})-2000;
                             else
                                rawCellColumns2{i,4} = 0;
                                lsqfit(variation_numb,2) = 0;
                             end
                             
                      end
                      
%%saving files
                      % save mech_ERC-MultiChem+Bio_Brakora2012_v1_test.mat rawCellColumns2
                      % file_name=[mechanism,'_',fuel_name,'_','class',class_numb,'_','v_',num2str(variation_numb),'.inp'];
                        file_name=[mechanism,'_',fuel_name,'_','class',num2str(class_numb(k)),'_','v_',num2str(variation_numb),'.inp'];
                        % fileID = fopen('mech_ERC-MultiChem+Bio_Brakora2012_v1_test.inp','w');
                        fileID = fopen(file_name,'w');
                        output = cell(size(rawCellColumns2,1),size(rawCellColumns2,2));
                       clear i j; 
                       for i = 1:size(rawCellColumns2,1)
                        for j = 1:size(rawCellColumns2,2)
                             if numel(rawCellColumns2{i,j}) == 0
                               output{i,j} = '';
                            % Check whether the content of cell i,j is
                               % numeric and convert numbers to strings.
                             elseif isnumeric(rawCellColumns2{i,j}) || islogical(rawCellColumns2{i,j})
                                output{i,j} = num2str(rawCellColumns2{i,j}(1,1));
            
                             % If the cell already contains a string, nothing has to be done.
                              elseif ischar(rawCellColumns2{i,j})
                              output{i,j} = rawCellColumns2{i,j};
                              end;
        
                          % Cell i,j is written to the output file. A delimiter is appended for
                              % all but the last element of each row. At the end of a row, a newline
                           % is written to the output file.
                           if j < size(rawCellColumns2,2)
                           fprintf(fileID,['%s',delimiter],output{i,j});
                           else
                           fprintf(fileID,'%s\r\n',output{i,j});
                           end
                        end;
                       end;
                      
                      
                end

            end
        end 
        
        
    
%% for future class determination
%                  if  (strfind(rawCellColumns{i,j},'nc7h16+oh=') == 1) & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1);
% %                  rawCellColumns2{i,2} = str2num(rawCellColumns{i,2})*2;
%                 rawCellColumns2{i,2} = '***ClASS1****';;
            
%                  end
%                  elseif (strfind(rawCellColumns{i,j},'IC8H18')==1 ) & (isempty(strfind(rawCellColumns{i,j},'C8H17'))==0) & (ModStart == 1);
% %                  rawCellColumns2{i,2} = '***ClASS2****';               
%                  end
 
    
    end
%     clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawCellColumns2 rawNumericColumns R;
    rateParam.(class_numb_text{k})=lsqfit;
    save('rateParam.mat','rateParam'); 
    clear rawCellColumns2;
end

% save('lsqfit.mat','lsqfit'); 
% field = 'class';
% rateParam=struct(field);

fclose(fileID);
% exit
%type mech_ERC-MultiChem+Bio_Brakora2012_v1_test.inp

%% Clear temporary variables
% clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawCellColumns rawNumericColumns R;