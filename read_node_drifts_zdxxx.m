% PERFORM 3D Binary Files Reader
% by Baris Erkus
%
% Please read the license before use.
%
% ver 0.01
%     Basic reading


% 4 Node Results, Including Drifts

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.1 Drifts

% File name = ZDxxx, where xxx = analysis number.
% File type = binary direct access.
% Record length = 12 bytes (3 REAL*4). Same for static and dynamic
% analysis.

% Item 1 = current drift value.
% Item 2 = maximum positive value of this drift to this point
% Item 3 = maximum negative value.

% The file contains NTIM+1 sets of NDRFT records, where NTIM = no.
% of time or load steps (set 1 = state at start of analysis) and NDRFT =
% no. of drifts.

% See *DRIFT : HORIZONTAL DRIFTS in ECHO.txt for drift numbers.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.2 Node Displacements

% File name = ZCxxx, where xxx = analysis number.
% File type = binary direct access.
% Record length = 24 bytes (6 REAL*4).
% Same for static and dynamic.

% Items 1-3 = H1, H2, V translations.
% Items 4-6 = H1, H2, V rotations.

% The file contains NTIM+1 sets of NNODS records, where NTIM = no.
% of time or load steps (set 1 = state at start of analysis) and NNODS =
% no. of nodes.

% See *NODE : NODE COORDINATES in ECHO.txt for node numbers.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.3 Node Velocities and Accelerations

% File name = ZLxxx, where xxx = analysis number.
% File type = binary direct access. Record length = 24 bytes (6 REAL*4).
% Dynamic analyses only

% Items 1-3 = H1, H2, V translational velocities.
% Items 4-6 = H1, H2, V translational accelerations.
% Rotational velocities and accelerations are not saved.

% The file contains NTIM+1 sets of NNODS records, where NTIM = no.
% of time steps (set 1 = state at start of analysis) and NNODS = no. of
% nodes.

% See *NODE : NODE COORDINATES in ECHO.txt for node numbers.


clear all; close all;

nanalysis = 8;
NDRFT = 88;
NNODS = 2786;

% for i = 1:nanalysis
%     file_name{i} = ['ZD', num2str(i,'%03u')];
% end
% 
% for i = 1:nanalysis
%     fileID = fopen(file_name{i});
%     eofile = 0;
%   
%     j = 1;
%     while eofile == 0;
%         for k=1:NDRFT
%             try                
%                 nodres{i,1}.timset{j,1}.drift(k,1:3) = fread(fileID, [1,3], 'real*4');               
%             catch
%                 eofile = 1;
%                 nodres{i,1}.timen = j-1;
%                 disp(['End of file reached. Time No: ', num2str(nodres{i,1}.timen)]);
%                 break;
%             end          
%         end
%         j = j+1;       
%     end
%     
%     fclose(fileID);
%     
% end
% 
% save nodedrifts.mat
% 
% 
% 
% 
% for i = 1:nanalysis
%     file_name{i} = ['ZC', num2str(i,'%03u')];
% end
% 
% for i = 2:2
%     fileID = fopen(file_name{i});
%     eofile = 0;
%   
%     j = 1;
%     while eofile == 0;
%         for k=1:NNODS
%             try                
%                 nodres{i,1}.timset{j,1}.disps(k,1:6) = fread(fileID, [1,6], 'real*4');               
%             catch
%                 eofile = 1;
%                 nodres{i,1}.timen = j-1;
%                 disp(['End of file reached. Time No: ', num2str(nodres{i,1}.timen)]);
%                 break;
%             end          
%         end
%         j = j+1;
%     end
%     fclose(fileID);    
% end


for i = 1:nanalysis
    file_name{i} = ['ZL', num2str(i,'%03u')];
end

for i = 2:2
    fileID = fopen(file_name{i});
    eofile = 0;
  
    j = 1;
    while eofile == 0;
        for k=1:NNODS
            try                
                nodres{i,1}.timset{j,1}.velacc(k,1:6) = fread(fileID, [1,6], 'real*4');               
            catch
                eofile = 1;
                nodres{i,1}.timen = j-1;
                disp(['End of file reached. Time No: ', num2str(nodres{i,1}.timen)]);
                break;
            end          
        end
        j = j+1;
    end
    fclose(fileID);    
end
