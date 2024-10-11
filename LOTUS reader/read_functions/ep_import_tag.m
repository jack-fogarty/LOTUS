%% EmbracePlus Toolkit: Read and collate TAG data
%  Copyright (C) (2024) Jack Fogarty

function [cfg,dat] = ep_import_tag(cfg,d,s,subs,span)

%  This file is part of the EmbracePlus Toolkit.
% 
%  The EmbracePlus Toolkit is free software: you can redistribute it and/or
%  modify it under the terms of the GNU General Public License as published
%  by the Free Software Foundation, either version 3 of the License, or (at
%  your option) any later version.
% 
%  The EmbracePlus Toolkit is distributed in the hope that it will be
%  useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
%  Public License for more details.
% 
%  You should have received a copy of the GNU General Public License along
%  with the EmbracePlus Toolkit. If not, see https://www.gnu.org/licenses/.


% Set modality specific parameters

    % POSIX modifier
    PSX = 10^6;

% Identify the method used to collate output
    switch cfg.ReadMethod
        
        % Default method: stitch selected data together according to each UTC day folder
        case 'Default'
    
            % Read in all relevant files for this modality
            files  = dir(fullfile([cfg.parent_folder filesep cfg.day_folders(d).name filesep subs{s} filesep 'tags*']));

            % Read and check all tags
            data = [];
            for t = 1:length(files)
                tmp = readmatrix([cfg.parent_folder filesep cfg.day_folders(d).name filesep subs{s} filesep files(t).name]);
                if ~isnan(tmp)
                   utime = [table(cellstr(repmat(files(t).name(6:15),size(tmp))),'VariableNames',{'UTC_FileTime'})]; % File times in UTC
                   rtime = [table(repmat(datetime(str2double(files(t).name(6:15)), 'convertfrom', 'posixtime', 'Format', 'MM/dd/yy HH:mm:ss.SSS','TimeZone',cfg.TimeZone),size(tmp)),'VariableNames',{'TZ_FileTime'}) table(datetime(tmp/PSX, 'convertfrom', 'posixtime', 'Format', 'MM/dd/yy HH:mm:ss.SSS','TimeZone',cfg.TimeZone),'VariableNames',{'TZ_TagTime'})];  % File and tag times in Timezone
                   data  = [data; utime,rtime];
                end
                clear tmp
            end

            % Format file and tag times
            if ~isempty(data)
                data = [array2table([1:height(data)]','VariableNames',{'Tag'}) data cell2table(repmat({''},height(data),1),'VariableNames',{'Annotation'})];
                data.TZ_FileTime.Format = 'MM/dd/yy';
                data.TZ_TagTime.Format  = 'hh:mm:ss.SSS';
            end
                       
            % Place into cell for consistency with custom method
            dat{1,1} = data;
            clear t rtime utime data
            
        % Custom method: stitch selected data together according to custom epoch
        case 'Custom'
            
            % Identify the files across days with or without possible dates filtered
            tmp   = [];
            files = [];           
            for d = 1:length(cfg.day_folders)
                tmp = dir(fullfile([cfg.day_folders(d).folder filesep cfg.day_folders(d).name filesep cfg.selected_subjects{s} filesep 'tag*']));
                if isempty(files)
                   files = tmp;
                else
                   files = [files; tmp];
                end
                clear tmp
            end
            
            % Read and check all tags
            dat = [];
            for t = 1:length(files)
                tmp = readmatrix([files(t).folder filesep files(t).name]);
                if ~isnan(tmp)
                   utime = [table(cellstr(repmat(files(t).name(6:15),size(tmp))),'VariableNames',{'UTC_FileTime'})]; % File and tag times in UTC
                   rtime = [table(repmat(datetime(str2double(files(t).name(6:15)), 'convertfrom', 'posixtime', 'Format', 'MM/dd/yy HH:mm:ss.SSS','TimeZone',cfg.TimeZone),size(tmp)),'VariableNames',{'TZ_FileTime'}) table(datetime(tmp/PSX, 'convertfrom', 'posixtime', 'Format', 'MM/dd/yy HH:mm:ss.SSS','TimeZone',cfg.TimeZone),'VariableNames',{'TZ_TagTime'})];  % File and tag times in Timezone
                   dat   = [dat; utime,rtime];
                end
                clear tmp
            end
            
            % Format file and tag times
            if ~isempty(dat)
                dat.TZ_FileTime.Format = 'MM/dd/yy';
                dat.TZ_TagTime.Format  = 'hh:mm:ss.SSS';

                % Shift dat to temporary variable to enable loop into cell
                tmp = dat;

                clear t rtime utime dat  

                % Remove any events outside the desired time windows
                day_idx = unique(dateshift(tmp.TZ_FileTime,'start','day'));

                for e = 1:length(day_idx) % For each possible day (i.e., epoch/beginning points)
                    bgn_epoch = day_idx(e) + duration(cfg.Stime.H,cfg.Stime.M,cfg.Stime.S); bgn_epoch.Format = 'MM/dd/yy HH:mm:ss'; % Desired epoch start time point
                    end_epoch = bgn_epoch + span; % Desired epoch end point

                    % Select relevant data for this epoch
                    dat{e,1} = tmp(tmp.TZ_FileTime >= bgn_epoch & tmp.TZ_FileTime < end_epoch,:);
                    dat{e,1} = [array2table([1:height(dat{e,1})]','VariableNames',{'Tag'}) dat{e,1} cell2table(repmat({''},height(dat{e,1}),1),'VariableNames',{'Annotation'})];
                    
                end
                clear e bgn_epoch end_epoch

                % Remove any empty epochs and mark selected day for removal
                dat(cellfun(@isempty,dat)) = [];
                
            else
                dat = {[]};
            end

    end
    
    
end
