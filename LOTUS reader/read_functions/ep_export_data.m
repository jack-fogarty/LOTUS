%% LOTUS: Export EmbracePlus data
%  Copyright (C) (2024) Jack Fogarty

%%% Create an "output file name builder"
%%% Adaptive way to get sample rates and store them alongside for preprocessing

function ep_export_data(app,cfg,dat,d,s,subs)

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

    % Clean up the cfg
    tmp.parent_folder = cfg.parent_folder;
    tmp.input_type    = cfg.InputType;
    tmp.data_type     = cfg.DataType;
    tmp.read_method   = cfg.ReadMethod;
    tmp.TimeZone      = cfg.TimeZone;
    tmp.selected_days = cfg.selected_days;
    tmp.selected_subjects = cfg.selected_subjects;
    tmp.temporality.sdate = cfg.Sdate;
    tmp.temporality.edate = cfg.Edate;
    tmp.temporality.stime = cfg.Stime;
    tmp.temporality.etime = cfg.Etime;
    tmp.temporality.tspan = cfg.Tspan;
    tmp.temporality.overlap = cfg.overlap;
    tmp.temporality.padding = cfg.padding;
    tmp.temporality.padmax  = cfg.padmax;
    tmp.output_folder = cfg.output_folder;
    
    day_folders = cfg.day_folders;
    cfg = tmp;

    % Identify the method used to collate output
    switch cfg.read_method
        
        % Default method: stitch selected data together according to each UTC day folder
        case 'Default'
                
            % Output the mat file
            save([cfg.output_folder filesep subs{s} '_' day_folders(d).name],'dat','cfg');

            % Output data to excel files
%             writetable(dat,[cfg.output_folder '\' subs(s).name '-' cfg.day_folders(d).name '-' 'Data' '.xlsx']);

        case 'Custom'
                       
            % Output recordings as separate files

            % Make copy of data for referential store
            tmp_dat = dat;

            for t = 1:size(tmp_dat.Summary,1)
                
                % Collate data by day
                        
                    % Identify available non-empty fields
                    fld = fieldnames(dat); 
                    fld = fld(~structfun(@isempty,dat));

                    % Loop and add relevant data to dat
                    for f = 1:length(fld)
                        eval(['dat.' fld{f} ' = tmp_dat.' fld{f} '(t,1);']);
                    end
                    
                % Output the mat file
                save([cfg.output_folder filesep cfg.selected_subjects{s} '_' replace(char(cfg.selected_days(t)),'/','-')],'dat','cfg');

            % Output data to excel files
            % writetable(dat,[cfg.output_folder '\' subs(s).name '-Epoch-Data' '.xlsx']); 

            end

    end

end
