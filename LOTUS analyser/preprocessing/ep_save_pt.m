%% LOTUS: Save Preprocessed Data
%  Copyright (C) (2024) Jack Fogarty

function app = ep_save_pt(app)

%%% In future it will be ideal if the structures are generated in a more
%%% organised manner so that it does not need to be reorganised here....

%  This file is part of the LOTUS Toolkit.
% 
%  The LOTUS Toolkit is free software: you can redistribute it and/or
%  modify it under the terms of the GNU General Public License as published
%  by the Free Software Foundation, either version 3 of the License, or (at
%  your option) any later version.
% 
%  The LOTUS Toolkit is distributed in the hope that it will be
%  useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
%  Public License for more details.
% 
%  You should have received a copy of the GNU General Public License along
%  with the LOTUS Toolkit. If not, see https://www.gnu.org/licenses/.


    % Select output location and format data
    if ~strcmp(app.PT_ListBox.Value,'Input Data')
        
        % Identify the epoch
        idx = str2double(extractBetween(app.PT_ListBox.Value,'_','_'));

        % Select the required epoch data
        dat = app.epoch{idx,1}.dat;
        cfg = app.epoch{idx,1}.cfg;

        % Finalise output structure
        cfg.TimeZone      = app.cfg.TimeZone;
        cfg.selected_days = app.cfg.selected_days;
        cfg.previous      = app.cfg;

        % Select output folder
        [savfile,savpath,~] = uiputfile({'*.*';'*.xslx';'*.mat'},'Save data as',[app.file{1,app.f}(1:end-4) '_EP' num2str(idx)]);

    else

        % Select the required input data
        dat = app.dat;
        cfg = app.cfg;

        % Select output folder
        [savfile,savpath,~] = uiputfile({'*.*';'*.xslx';'*.mat'},'Save data as',[app.file{1,app.f}(1:end-4) '_PROC']);

    end
        

    % Output mat file data
    if app.matCheckBox.Value
                                    
        % Output the epoch mat file for this subject
        save([savpath savfile '.mat'],'dat','cfg');

    end

    % Output excel data
    if app.xlsxCheckBox.Value
                                    
        % For each possible signal type
        sig = fieldnames(dat);
        sig = sig(~structfun(@isempty,dat) & ~strcmp(sig,'Tags') & ~strcmp(sig,'Summary'));

        % Most data can be output as a table
        if strcmp(app.PT_ListBox.Value,'Input Data') | any(strcmp(cfg.type,{'Event-Related','Event A to B','Timepoint'}))

            for t = 1:length(sig)
                
                % Output to Excel
                eval(['writetable(dat.' sig{t} '{1,1},[savpath savfile ''.xlsx''],''Sheet'',''' sig{t} ''')']); % Each modality to a separate sheet

            end

        % Sequential epochs need to be formatted into a matrix for excel output
        else

            if ~strcmp(sig,'ACC')

                % Concatenate into matrix (Row = Time, Column = Sequential Epoch)
                for i = eval(['1:length(dat.' sig{t} '{1,1})'])

                    % NaN pad epochs to same length [set by max] and add to matrix
                    m = max(cellfun(@height,eval(['dat.' sig{t} '{1,1};'])));

                    if eval(['height(dat.' sig{t} '{1,1}{i,1}.data) < m'])
                        p = NaN(eval(['m-height(dat.' sig{t} '{1,1}{i,1}.data)']),1);
                        d(:,i) = eval(['[dat.' sig{t} '{1,1}{i,1}.data; p];']);
                    else
                        d(:,i) = eval(['dat.' sig{t} '{1,1}{i,1}.data;']);
                    end
                    
                end

                % Output to Excel
                eval(['writetable(d,[savpath savfile ''.xlsx''],''Sheet'',''' sig{t} ''')']); % Each modality to a separate sheet

            else

                % Concatenate into matrix (Row = Time, Column = Sequential Epoch)
                for i = eval(['1:length(dat.' sig{t} '{1,1})'])

                    % NaN pad epochs to same length [set by max] and add to matrix
                    m = max(cellfun(@height,eval(['dat.' sig{t} '{1,1};'])));

                    if eval(['height(dat.' sig{t} '{1,1}{i,1}.data) < m'])
                        p = NaN(eval(['m-height(dat.' sig{t} '{1,1}{i,1}.data)']),3); % Three columns for data_x, data_y, data_z
                        d(:,i,1) = eval(['[dat.' sig{t} '{1,1}{i,1}.data_x; p];']);
                        d(:,i,2) = eval(['[dat.' sig{t} '{1,1}{i,1}.data_y; p];']);
                        d(:,i,3) = eval(['[dat.' sig{t} '{1,1}{i,1}.data_z; p];']);
                    else
                        d(:,i,1) = eval(['dat.' sig{t} '{1,1}{i,1}.data_x;']);
                        d(:,i,2) = eval(['dat.' sig{t} '{1,1}{i,1}.data_y;']);
                        d(:,i,3) = eval(['dat.' sig{t} '{1,1}{i,1}.data_z;']);
                    end
                    
                end

                % Output to Excel
                eval(['writetable(d(:,:,1),[savpath savfile ''.xlsx''],''Sheet'',''' sig{t} '_X'')']); % Each modality to a separate sheet
                eval(['writetable(d(:,:,2),[savpath savfile ''.xlsx''],''Sheet'',''' sig{t} '_Y'')']); % Each modality to a separate sheet
                eval(['writetable(d(:,:,3),[savpath savfile ''.xlsx''],''Sheet'',''' sig{t} '_Z'')']); % Each modality to a separate sheet

            end

        end

    end

end

