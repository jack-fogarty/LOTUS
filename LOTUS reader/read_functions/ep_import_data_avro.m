%% LOTUS: Collate selected EmbracePlus ouput data
%  Copyright (C) (2024) Jack Fogarty

function ep_import_data_avro(app)

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
    
    % Extract relevant data
    cfg = app.cfg;

    % Select output folder
    cfg.output_folder = uigetdir(cfg.parent_folder,'Select output folder');

    % Start 'app busy' symbol
    app.loadus.ImageSource = ['images' filesep 'loadus_black.gif'];
    drawnow;
    figure(app.LOTUS_readerUIFigure)

    % Prime data structure
    pdat.EDA     = []; % Electrodermal data
    pdat.BVP     = []; % Blood volume pulse
    pdat.SystP   = []; % Systolic peaks
    pdat.Temp    = []; % Temperature (skin)
    pdat.ACC     = []; % Accelerometer
    pdat.GYR     = []; % Gyroscope
    pdat.Steps   = []; % Steps
    pdat.Other   = []; % Other data
    pdat.Tags    = []; % Tags (event markers)
    pdat.Summary = []; % Summary of dataset
    
    % Actual dat bin
    dat = pdat;
    
    % Identify the method used to collate output
    switch cfg.ReadMethod
        
        % Default method: stitch selected data together according to each UTC day folder
        case 'Default'

            % For each day folder in range
            for d = 1:length({cfg.day_folders.name})

                % Identify the selected subjects for this day (for loop efficiency)
                idx  = dir([cfg.parent_folder filesep cfg.day_folders(d).name]);
                idx  = idx(~ismember({idx.name},{'.','..'}));
                subs = cfg.selected_subjects(ismember(cfg.selected_subjects, {idx.name}));
                clear idx
                
                % Process subject data
                for s = 1:length(subs)
                    
                    if isempty(subs)
                        continue
                    end
                    
                    % Add selected day to cfg
                    cfg.selected_days = datetime(cfg.day_folders(d).name,'TimeZone',cfg.TimeZone);
                    
                    % Collate the Tags data for this subject
                    [cfg,dat.Tags] = ep_import_tag_avro(cfg,d,s,subs);
                    
                    % Read in and collate the required EmbracePlus data
                    if cfg.DataType.EDA
                        % Collate the EDA data for this subject
                        [cfg,dat.EDA,summary] = ep_import_eda_avro(cfg,d,s,subs);
                        
                        % Erase empty cells
                        if isempty(dat.EDA{:})
                            dat.EDA = [];
                        end

                        % Add summary
                        if ~isempty(summary)
                            if isempty(dat.Summary)
                                dat.Summary = summary;
                            else
                                dat.Summary{1,1} = horzcat(dat.Summary{1,:},summary{1,:});
                            end
                        end
                        clear summary
                    end
                    
                    if cfg.DataType.BVP
                        % Collate the BVP data for this subject
                        [cfg,dat.BVP,summary] = ep_import_bvp_avro(cfg,d,s,subs);
                              
                        % Erase empty cells
                        if isempty(dat.BVP{:})
                            dat.BVP = [];
                        end

                        % Add summary
                        if ~isempty(summary)
                            if isempty(dat.Summary)
                                dat.Summary = summary;
                            else
                                dat.Summary{1,1} = horzcat(dat.Summary{1,:},summary{1,:});
                            end
                        end
                        clear summary
                    end
                    
                    if cfg.DataType.SystP
                        % Collate the Systolic Peak data for this subject
                        [cfg,dat.SystP,summary] = ep_import_systp_avro(cfg,d,s,subs);
                        
                        % Erase empty cells
                        if isempty(dat.SystP{:})
                            dat.SystP = [];
                        end

                        % Add summary
                        if ~isempty(summary)
                            if isempty(dat.Summary)
                                dat.Summary = summary;
                            else
                                dat.Summary{1,1} = horzcat(dat.Summary{1,:},summary{1,:});
                            end
                        end
                        clear summary
                    end
                    
                    if cfg.DataType.Temp
                        % Collate the Temperature data for this subject
                        [cfg,dat.Temp,summary] = ep_import_temp_avro(cfg,d,s,subs);
                                                
                        % Erase empty cells
                        if isempty(dat.Temp{:})
                            dat.Temp = [];
                        end

                        % Add summary
                        if ~isempty(summary)
                            if isempty(dat.Summary)
                                dat.Summary = summary;
                            else
                                dat.Summary{1,1} = horzcat(dat.Summary{1,:},summary{1,:});
                            end
                        end
                        clear summary
                    end
                    
                    if cfg.DataType.ACC
                        % Collate the Accelerometer data for this subject
                        [cfg,dat.ACC,summary] = ep_import_acc_avro(cfg,d,s,subs);
                                                
                        % Erase empty cells
                        if isempty(dat.ACC{:})
                            dat.ACC = [];
                        end

                        % Add summary
                        if ~isempty(summary)
                            if isempty(dat.Summary)
                                dat.Summary = summary;
                            else
                                dat.Summary{1,1} = horzcat(dat.Summary{1,:},summary{1,:});
                            end
                        end
                        clear summary
                    end
                    
%                     if cfg.DataType.GYR
%                         % Collate the Gyroscope data for this subject
%                         [cfg,dat.GYR] = ep_import_gyr_avro(cfg,d,s,subs); 
%                     end
%                     
%                     if cfg.DataType.Steps
%                         % Collate the Steps data for this subject
%                         [cfg,dat.Steps] = ep_import_steps_avro(cfg,d,s,subs); 
%                     end
%                     
%                     if cfg.DataType.Other
%                         % Collate the Other data for this subject
%                         [cfg,dat.Other] = ep_import_other(cfg,d,s,subs); 
%                     end
%                     
%                     if cfg.DataType.Summary
%                         % Collate the Summary data for this subject
%                         [cfg,dat.Summary] = ep_import_sum(cfg,d,s,subs); 
%                     end                   
                      
                    % Return if dat structute is completely empty
                    if isempty(dat.Tags{:}) + sum(structfun(@isempty,dat)) == 10
                        % Reset dat
                        dat = pdat;
                        continue
                    end

                    % Create empty tags table if empty but there is other data
                    if all(cellfun(@isempty,dat.Tags))
                        % dat.Tags = [];
                        tags = table({[]},NaT,NaT,NaT,{''},'VariableNames',{'Tag','UTC_FileTime','TZ_FileTime','TZ_TagTime','Annotation'});
                        tags.UTC_FileTime.TimeZone = cfg.TimeZone;
                        tags.TZ_FileTime.TimeZone  = cfg.TimeZone;
                        tags.TZ_TagTime.TimeZone   = cfg.TimeZone;
                        tags(:,:) = [];
                        dat.Tags = {tags};
                    end

                    % Export the epoched raw data
                    ep_export_data(app,cfg,dat,d,s,subs)
                    
                    % Reset dat
                    dat = pdat;

                end
            end
                
        % Custom method: stitch selected data together according to custom epoch
        case 'Custom'
            
                % Dummy reference date
                t = datetime(cfg.day_folders(1).name);
                
                % If start time is larger then epoch will cross over midnight (shift 'end date' over for complete epoching)
                if duration(cfg.Stime.H,cfg.Stime.M,cfg.Stime.S) > duration(cfg.Etime.H,cfg.Etime.M,cfg.Etime.S)
                   a    = t + calendarDuration(0,0,0,cfg.Stime.H,cfg.Stime.M,cfg.Stime.S); % Dummy start time
                   b    = t + calendarDuration(cfg.Tspan.Y,cfg.Tspan.M,cfg.Tspan.D+1,cfg.Etime.H,cfg.Etime.M,cfg.Etime.S); % Dummy end time
                   span = between(a,b);
                else
                   a    = t + calendarDuration(0,0,0,cfg.Stime.H,cfg.Stime.M,cfg.Stime.S); % Dummy start time
                   b    = t + calendarDuration(cfg.Tspan.Y,cfg.Tspan.M,cfg.Tspan.D,cfg.Etime.H,cfg.Etime.M,cfg.Etime.S); % Dummy end time
                   span = between(a,b);
                   
                   %%% WARNING HERE %%% If span == 0 then user has not set Time Window
                   
                end
                clear t a b

                % For each selected subject
                for s = 1:length(cfg.selected_subjects)

                    % Collate the Tags data for this subject
                    [cfg,dat.Tags] = ep_import_tag_avro(cfg,[],s,[],span);
                    
                    % Read in and collate the required EmbracePlus data
                    if cfg.DataType.EDA
                        % Collate the EDA data for this subject
                        [cfg,dat.EDA,summary] = ep_import_eda_avro(cfg,[],s,[],span);
                        
                        % Erase empty cells
                        if isempty(dat.EDA)
                            dat.EDA = [];
                        end

                        % Add summary
                        if ~isempty(summary)
                            if isempty(dat.Summary)
                                dat.Summary = summary;
                            else
                                % Match dimensions
                                if height(dat.Summary) > height(summary)
                                    idx = height(dat.Summary)-height(summary);
                                    summary = [summary; repmat({table()},idx,1)];
                                elseif height(dat.Summary) < height(summary)
                                    idx = height(summary)-height(dat.Summary);
                                    dat.Summary = [dat.Summary; repmat({table()},idx,1)];                                    
                                end

                                dat.Summary = cellfun(@horzcat,dat.Summary,summary,UniformOutput=false);
                            end
                        end
                        clear summary
                    end

                    if cfg.DataType.BVP
                        % Collate the BVP data for this subject
                        [cfg,dat.BVP,summary] = ep_import_bvp_avro(cfg,[],s,[],span);

                        % Erase empty cells
                        if isempty(dat.BVP)
                            dat.BVP = [];
                        end

                        % Add summary
                        if ~isempty(summary)
                            if isempty(dat.Summary)
                                dat.Summary = summary;
                            else
                                % Match dimensions
                                if height(dat.Summary) > height(summary)
                                    idx = height(dat.Summary)-height(summary);
                                    summary = [summary; repmat({table()},idx,1)];
                                elseif height(dat.Summary) < height(summary)
                                    idx = height(summary)-height(dat.Summary);
                                    dat.Summary = [dat.Summary; repmat({table()},idx,1)];                                    
                                end

                                dat.Summary = cellfun(@horzcat,dat.Summary,summary,UniformOutput=false);
                            end
                        end
                        clear summary
                    end
                    
                    if cfg.DataType.SystP
                        % Collate the Systolic Peak data for this subject
                        [cfg,dat.SystP,summary] = ep_import_systp_avro(cfg,[],s,[],span);

                        % Erase empty cells
                        if isempty(dat.SystP)
                            dat.SystP = [];
                        end

                        % Add summary
                        if ~isempty(summary)
                            if isempty(dat.Summary)
                                dat.Summary = summary;
                            else
                                % Match dimensions
                                if height(dat.Summary) > height(summary)
                                    idx = height(dat.Summary)-height(summary);
                                    summary = [summary; repmat({table()},idx,1)];
                                elseif height(dat.Summary) < height(summary)
                                    idx = height(summary)-height(dat.Summary);
                                    dat.Summary = [dat.Summary; repmat({table()},idx,1)];                                    
                                end

                                dat.Summary = cellfun(@horzcat,dat.Summary,summary,UniformOutput=false);
                            end
                        end
                        clear summary
                    end
                    
                    if cfg.DataType.Temp
                        % Collate the Temperature data for this subject
                        [cfg,dat.Temp,summary] = ep_import_temp_avro(cfg,[],s,[],span);

                        % Erase empty cells
                        if isempty(dat.Temp)
                            dat.Temp = [];
                        end

                        % Add summary
                        if ~isempty(summary)
                            if isempty(dat.Summary)
                                dat.Summary = summary;
                            else
                                % Match dimensions
                                if height(dat.Summary) > height(summary)
                                    idx = height(dat.Summary)-height(summary);
                                    summary = [summary; repmat({table()},idx,1)];
                                elseif height(dat.Summary) < height(summary)
                                    idx = height(summary)-height(dat.Summary);
                                    dat.Summary = [dat.Summary; repmat({table()},idx,1)];                                    
                                end

                                dat.Summary = cellfun(@horzcat,dat.Summary,summary,UniformOutput=false);
                            end
                        end
                        clear summary
                    end
                    
                    if cfg.DataType.ACC
                        % Collate the Accelerometer data for this subject
                        [cfg,dat.ACC,summary] = ep_import_acc_avro(cfg,[],s,[],span);

                        % Erase empty cells
                        if isempty(dat.ACC)
                            dat.ACC = [];
                        end

                        % Add summary
                        if ~isempty(summary)
                            if isempty(dat.Summary)
                                dat.Summary = summary;
                            else
                                % Match dimensions
                                if height(dat.Summary) > height(summary)
                                    idx = height(dat.Summary)-height(summary);
                                    summary = [summary; repmat({table()},idx,1)];
                                elseif height(dat.Summary) < height(summary)
                                    idx = height(summary)-height(dat.Summary);
                                    dat.Summary = [dat.Summary; repmat({table()},idx,1)];                                    
                                end

                                dat.Summary = cellfun(@horzcat,dat.Summary,summary,UniformOutput=false);
                            end
                        end
                        clear summary
                    end
                    
%                     if cfg.DataType.GYR
%                         % Collate the Gyroscope data for this subject
%                         [cfg,dat.GYR] = ep_import_gyr(cfg,[],s,[],span); 
%                     end
%                     
%                     if cfg.DataType.Steps
%                         % Collate the Steps data for this subject
%                         [cfg,dat.Steps] = ep_import_steps(cfg,[],s,[],span); 
%                     end
%                     
%                     if cfg.DataType.Other
%                         % Collate the Other data for this subject
%                         [cfg,dat.Other] = ep_import_other(cfg,[],s,[],span); 
%                     end
%                     
%                     if cfg.DataType.Summary
%                         % Collate the Summary data for this subject
%                         [cfg,dat.Summary] = ep_import_sum(cfg,[],s,[],span); 
%                     end

                    % Return if dat structute is completely empty
                    if all(cellfun(@isempty,dat.Tags)) + sum(structfun(@isempty,dat)) == 10 % Using isempty(dat.Tags) instead of isempty(dat.Tags{:})
                        % Reset dat
                        dat = pdat;
                        continue
                    end

                    % Check the custom epochs are in sequential order
                    [cfg, dat] = ep_check_custom(cfg,dat);

                    % Add empty tag tables where needed
                    if isempty(dat.Tags)
                        dat.Tags = cell(3,1);
                    end
                    idx = find(cellfun(@isempty,dat.Tags));
                    if ~isempty(idx)
                        tags = table({0},NaT,NaT,NaT,{''},'VariableNames',{'Tag','UTC_FileTime','TZ_FileTime','TZ_TagTime','Annotation'});
                        tags.UTC_FileTime.TimeZone = cfg.TimeZone;
                        tags.TZ_FileTime.TimeZone  = cfg.TimeZone;
                        tags.TZ_TagTime.TimeZone   = cfg.TimeZone;
                        tags(:,:) = [];
                        for t = 1:length(idx)
                            dat.Tags(idx(t)) = {tags};
                        end
                    end

                    % Export the epoched raw data
                    ep_export_data(app,cfg,dat,[],s,[]);

                    % Reset dat
                    dat = pdat;

                end
               
    end

    % Update app loading symbol
    app.loadus.ImageSource = ['images' filesep 'Static.png'];
    drawnow;

end