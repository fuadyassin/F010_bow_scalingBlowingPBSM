%<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
%  The purpose of this code is to re-order gru of drainage database
%<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
close all; clear all;clc;
%% 1 read directory and read drainage database 
dirs = 'D:\C_models\F010_bow_scaling';                                      %! needs input  
fid_dr = fopen('D:\C_models\F010_bow_scaling\MESH_drainage_database_org.r2c','r');
tline = fgetl(fid_dr);
 while strcmp(tline(1:10),':EndHeader')== 0 
     tline = fgetl(fid_dr);
     if length(tline) < 33; tline = [tline blanks(33-length(tline))]; end   % may need to modified depending on the tline length you want to access
     if strcmp(tline(1:16),':TotalNumOfGrids')==1
         num_grids=str2num(tline(17:end)); end                              % num_grids is NO. of grids in the shd file
     if strcmp(tline(1:11),':ClassCount')== 1          
         num_GRU=str2num(tline(12:end)); end                                % num_GRU is NO. of GRUs in the shd file
     if strcmp(tline(1:7),':xCount')==1                
         num_Col=str2num(tline(8:end)); end                                 % num_Col is NO. of rows in the shd file
     if strcmp(tline(1:7),':yCount')==1                
         num_Row=str2num(tline(8:end)); end                                 % num_Row is NO. of columns in the shd file
     if strcmp(tline(1:8),':xOrigin')==1
         x0_r2c=str2num(tline(9:end)); end                                  % x0_r2c is x origin
     if strcmp(tline(1:8),':yOrigin')==1         
         y0_r2c=str2num(tline(9:end)); end                                  % y0_r2c is y origin
     if strcmp(tline(1:7),':xDelta')==1
         dx_r2c=str2num(tline(8:end)); end                                  % xDelta grid size
     if strcmp(tline(1:7),':yDelta')==1
         dy_r2c=str2num(tline(8:end)); end                                  % yDelta grid size
     if strcmp(tline(18:21),'Rank')==1 
         rank_att=str2num(tline(16:17)); end                                % Rank attribute numb
     if strcmp(tline(19:26),'GridArea')==1 
         grida_att=str2num(tline(16:17)); end                               % Grid area attribute numb
     if strcmp(tline(19:28),'NeedleLF 1')==1                             
         NeedleLF_att=str2num(tline(16:17)); end                            % NeedleLF attribute numb
     if strcmp(tline(19:27),'BroadLF 5')==1
         BroadLF_att=str2num(tline(16:17)); end                             % BroadLF attribute numb           
     if strcmp(tline(19:25),'Shrub 8')==1
         Shrub_att=str2num(tline(16:17)); end                               % Shrub attribute numb
     if strcmp(tline(19:26),'Grass 10')==1
         Grass_att=str2num(tline(16:17)); end                               % Grass attribute numb
     if strcmp(tline(19:27),'GrassL 12')==1
         GrassL_att=str2num(tline(16:17)); end                              % GrassL attribute numb
     if strcmp(tline(19:28),'BarrenL 13')==1
         BarrenL_att=str2num(tline(16:17)); end                             % BarrenL attribute numb
     if strcmp(tline(19:27),'Barren 16')==1
         Barren_att=str2num(tline(16:17)); end                              % Barren attribute numb
     if strcmp(tline(19:26),'Urban 17')==1
         Urban_att=str2num(tline(16:17)); end                               % Urban attribute numb 
     if strcmp(tline(19:26),'Water 18')==1
         Water_att=str2num(tline(16:17)); end                               % Water attribute numb
     if strcmp(tline(19:28),'Glacier 19')==1
         Glacier_att=str2num(tline(16:17)); end                             % Glacier attribute numb
     if strcmp(tline(19:27),'Class 128')==1
         Null_att=str2num(tline(16:17)); end                                % Null matrix attribute numb  
     if strcmp(tline(1:15),':AttributeUnits')==1 
         Tnum_att=str2num(tline(16:19)); end                                % total number of attributes
 end
% Reads all attributs in the drainage database 
dd_r2c = transpose(fscanf(fid_dr,'%f',[num_Col num_Row*Tnum_att]));   
%fclose(fid_dr);                                                            % Stop reading drainage database

% dd_char is drainage database charactersitics matrix from dd_r2c
% grida_att is last matrix before GRU starts
% Always check the last charactersitics matix before GRU matrix
dd_char = dd_r2c(1:num_Row*grida_att,1:num_Col);     
% GRU matrix (Tnum_att-grida_att) deducts the total attribute & drainage char
% dd_gru is all gru matrix including the null gru
dd_gru   = dd_r2c((num_Row*grida_att+1):(num_Row*Tnum_att),1:num_Col);          % Reads GRUS from ddatabase 

rnk      = dd_r2c(((rank_att-1)*num_Row+1):rank_att*num_Row,1:num_Col);         % rank matrix
grid_ar  = dd_r2c(((grida_att-1)*num_Row+1):grida_att*num_Row,1:num_Col);       % grid area 
NeedleLF = dd_r2c(((NeedleLF_att-1)*num_Row+1):NeedleLF_att*num_Row,1:num_Col); % NeedleLF
BroadLF  = dd_r2c(((BroadLF_att-1)*num_Row+1):BroadLF_att*num_Row,1:num_Col);   % BroadLF
Shrub    = dd_r2c(((Shrub_att-1)*num_Row+1):Shrub_att*num_Row,1:num_Col);       % Shrub
Grass    = dd_r2c(((Grass_att-1)*num_Row+1):Grass_att*num_Row,1:num_Col);       % Grass
GrassL   = dd_r2c(((GrassL_att-1)*num_Row+1):GrassL_att*num_Row,1:num_Col);     % GrassL
BarrenL  = dd_r2c(((BarrenL_att-1)*num_Row+1):BarrenL_att*num_Row,1:num_Col);   % BarrenL
Barren   = dd_r2c(((Barren_att-1)*num_Row+1):Barren_att*num_Row,1:num_Col);     % Barren
Urban    = dd_r2c(((Urban_att-1)*num_Row+1):Urban_att*num_Row,1:num_Col);       % Urban
Water    = dd_r2c(((Water_att-1)*num_Row+1):Water_att*num_Row,1:num_Col);       % Water 
Glacier  = dd_r2c(((Glacier_att-1)*num_Row+1):Glacier_att*num_Row,1:num_Col);   % Glacier area
Null_mat = dd_r2c(((Null_att-1)*num_Row+1):Null_att*num_Row,1:num_Col);         % Null matrix  area

tot_glc_area = sum(sum(Glacier.*grid_ar));                                      % total glacire area

% order GRU based on blowing snow order
% 1. Urban 2. Glacier 3. Barren 4. BarrenL 5. GrassL 6. Grass 
% 7. Shrub. 8 BroadLF 9. NeedleLF 10. Water
dd_r2cnew = [dd_char; Urban; Glacier; Barren; BarrenL; GrassL; Grass;...
                Shrub; BroadLF; NeedleLF; Water; Null_mat];

%% create the new drainage database file and write header upto 
% AttributeUnits 12 m^2 because the remaining header depends on gru order
dirs_save = 'D:\C_models\F010_bow_scaling';                                 % Directory to save the new drainage databse
ordered_dd = fullfile(dirs_save, 'MESH_drainage_database_pbsm_order.txt');  % file name for the new drainage database
fileID = fopen(ordered_dd,'wt+');
frewind(fid_dr)                                                             % Move file position indicator to beginning of open file
tline = 'This is just to start the while loop';                             % Just to start the while loop
while strcmp(tline(1:22),':AttributeUnits 12 m^2')== 0 
     tline = fgetl(fid_dr); 
      if length(tline) < 25
          tline = [tline blanks(25-length(tline))];                             
      end 
     fprintf(fileID,'%s\n',tline);
end

% Here you need to modify the gru order and naming based on blowing snow
% order as listed in 'dd_r2cnew' above
gru_header = {':AttributeName 13 Urban 17'; ':AttributeUnits 13 0-1'; ...
        ':AttributeName 14 Glacier 19';     ':AttributeUnits 14 0-1'; ...
        ':AttributeName 15 Barren 16';      ':AttributeUnits 15 0-1'; ...
        ':AttributeName 16 BarrenL 13';     ':AttributeUnits 16 0-1'; ...
        ':AttributeName 17 GrassL 12';      ':AttributeUnits 17 0-1'; ...
        ':AttributeName 18 Grass 10';       ':AttributeUnits 18 0-1'; ...
        ':AttributeName 19 Shrub 8';        ':AttributeUnits 19 0-1'; ...
        ':AttributeName 20 BroadLF 5';      ':AttributeUnits 20 0-1'; ...
        ':AttributeName 21 NeedleLF 1';     ':AttributeUnits 21 0-1'; ...
        ':AttributeName 22 Water 18';       ':AttributeUnits 22 0-1'; ...
        ':AttributeName 23 Class 128';      ':AttributeUnits 23 0-1'; ...
        '#';... 
        [':xCount ' num2str(num_Col)];...  
        [':yCount ' num2str(num_Row)];...
        [':xDelta ' num2str(dx_r2c)];...
        [':yDelta ' num2str(dy_r2c)];...
        '#';...
        ':EndHeader'};

% write gru and remaining header from 'gru_header' variable
for ii = 1:size(gru_header,1)
    fprintf(fileID,'%s\n',gru_header{ii});
end

% write drainage database characterstics and gru matrix. includes null
% matrix as a last one
for ii = 1:size(dd_r2cnew,1)
    fprintf(fileID,'%g\t',dd_r2cnew(ii,:));
    fprintf(fileID,'\n');
end
% fclose(fileID);
fclose('all');                    % close all opened files


% copy paste text file to r2c
finalr2c_dd = fullfile(dirs_save, 'MESH_drainage_database_pbsm_order.r2c');
copyfile(ordered_dd,finalr2c_dd);

% delete the text file
delete(ordered_dd);

