%% LOTUS: Read and collate Systolic Peak data
%  Copyright (C) (2024) Jack Fogarty

%%% Consider adding signal check in terms of 'NaN' at edge of discontinuities to get
%%% rid of huge difference values in the RR (although this could be done later in artefact correction)

function [cfg,dat,summary] = ep_import_systp_avro(cfg,d,s,subs,span)

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


% Set modality specific parameters

    % Sample rate for Systolic Peaks
    Fs  = [];
    
    % POSIX modifier
    PSX = 10^9;

    % File time pattern
    pat = digitsPattern(10);

% Identify the method used to collate output
    switch cfg.ReadMethod
        
        % Default method: stitch selected data together according to each UTC day folder
        case 'Default'
    
            % Read in all relevant files for this modality
            files  = dir(fullfile([cfg.parent_folder filesep cfg.day_folders(d).name filesep subs{s} filesep 'raw_data' filesep 'v6' filesep '*.avro']));

            tmp = [];
            for t = 1:length(files)
                
                % Construct the path strings for external calling of the python script and selected avro file
                fname    = ['''' cfg.parent_folder filesep cfg.day_folders(d).name filesep subs{s} filesep 'raw_data' filesep 'v6' filesep files(t).name ''''];
                fname    = insertAfter(fname,filesep,filesep);
                dtype    = '''systp''';
                script_p = mfilename('fullpath');
                script_p = script_p(1:end-length(mfilename));
                script   = ['pyrunfile("' script_p 'ep_read_avro.py ' fname ' ' dtype '"'];
                
                % Run the actual code now the function is built
                [data,fs,timept] = eval([script ', ["data", "fs", "timept"])' ]);
                
                % Stitch the relevant data together
                data = [double(timept)' double(data)'];
                if isempty(tmp)
                   tmp = data;
                   clear data timestamp fname dtype script fs timept
                else
                   tmp = [tmp; data];
                   clear data timestamp fname dtype script fs timept
                end

            end
            
            if ~isempty(tmp)
                % Create standard time vector (Check accuracy of UNIX division and conversion)
                rtime = datetime(tmp(:,1)/PSX, 'convertfrom', 'posixtime', 'Format', 'MM/dd/yy HH:mm:ss.SSS','TimeZone',cfg.TimeZone);
                
                % Create vector of RR intervals in seconds
                RR = [nan; seconds(diff(rtime))]; % Add nan at start to ensure equal matrix lengths
        
                % Add time vector to data table
                tmp = [array2table(tmp(:,1),'VariableNames',{'unix_time'}) table(rtime,'VariableNames',{'local_time'}) array2table(RR,'VariableNames',{'data'})];
                
                % Check for discontinuities in the signal (apply padding if selected)
                % This seems unnecessary for systolic peaks tachogram
                % However it may be useful to nan pad out for epoch size still...
    %           [cfg,data] = ep_check_signal(cfg,tmp,Fs,PSX,[],[],[]);
                                    
                % Record summary: duration and padding stats based on NaNs
                %%% Currently the fraction of data does not represent cases where padding is not selected
                dur  = tmp.local_time(end)-tmp.local_time(1); dur.Format = 'dd:hh:mm:ss.SSS'; % Full length of recording
                pts  = length(tmp.data);
                Pnan = sum(isnan(tmp.data))/length(tmp.data)*100; % Percent of selected period missing (nan)
                summary{1,1} = [array2table(dur,"VariableNames","SystP duration") array2table(pts,"VariableNames","SystP pts") array2table(Pnan,"VariableNames","SystP % Missing")];
                clear dur pts Pnan
            else
                tmp = [];
                summary{1,1} = {};
            end
            
            % Place into cell for consistency with custom method
            dat{1,1} = tmp; % skip data and use tmp
            clear t rtime utime data

            
        % Custom method: stitch selected data together according to custom epoch
        case 'Custom'
            
            % Identify the files across days with or without possible dates filtered
            tmp   = [];
            files = [];           
            for d = 1:length(cfg.day_folders)
                tmp = dir(fullfile([cfg.parent_folder filesep cfg.day_folders(d).name filesep cfg.selected_subjects{s} filesep 'raw_data' filesep 'v6' filesep '*.avro']));
                if isempty(files)
                   files = tmp;
                else
                   files = [files; tmp];
                end
                clear tmp
            end
            
            % Stitch data together
            tmp = [];
            for t = 1:length(files)
                
                % Construct the path strings for external calling of the python script and selected avro file
                fname   = ['''' files(t).folder filesep files(t).name ''''];
                fname   = insertAfter(fname,filesep,filesep);
                dtype   = '''systp''';
                script_p = mfilename('fullpath');
                script_p = script_p(1:end-length(mfilename));
                script   = ['pyrunfile("' script_p 'ep_read_avro.py ' fname ' ' dtype '"'];
                
                % Run the actual code now the function is built
                [data,fs,timept] = eval([script ', ["data", "fs", "timept"])' ]);

                % Stitch the relevant data together
                data = [double(timept)' double(data)'];
                if isempty(tmp)
                   tmp = data;
                   clear data timestamp fname dtype script fs timept
                else
                   tmp = [tmp; data];
                   clear data timestamp fname dtype script fs timept
                end

            end
            tmp(find(isnan(tmp(:,1))),:) = []; % remove NaN values
            clear i d files

            if ~isempty(tmp)
                % Create standard time vector (Check accuracy of UNIX division and conversion)
                rtime = datetime(tmp(:,1)/PSX, 'convertfrom', 'posixtime', 'Format', 'MM/dd/yy HH:mm:ss.SSSS','TimeZone',cfg.TimeZone);
                
                % Create vector of RR intervals in seconds
                RR = [nan; seconds(diff(rtime))]; % Add nan at start to ensure equal matrix lengths
                
                % Add time vector to data table
                tmp = [array2table(tmp(:,1),'VariableNames',{'unix_time'}) table(rtime,'VariableNames',{'local_time'}) array2table(RR,'VariableNames',{'data'})];
    
                % Identify potential epochs and extract the relevant data
                rtime.Format = 'MM/dd/yy';
                day_idx      = unique(dateshift(rtime,'start','day')); % Each possible day  (perhaps this can be moderated by span to reduce overlap?)
                rtime.Format = 'MM/dd/yy HH:mm:ss.SSS';
                
                % Epoch data (rephrase day/d variables into generic epoch/i)
                for e = 1:length(day_idx) % For each possible day (i.e., epoch/beginning points)
                    bgn_epoch = day_idx(e) + duration(cfg.Stime.H,cfg.Stime.M,cfg.Stime.S); bgn_epoch.Format = 'MM/dd/yy HH:mm:ss'; % Desired epoch start time point
                    end_epoch = bgn_epoch + span; % Desired epoch end point
                    
                    % Select relevant data for this epoch
                    dat{e,1} = tmp(rtime >= bgn_epoch & rtime < end_epoch,:);
                    
                    % % Check signal data
                    % if isempty(dat{e,1})
                    %    dat{e,1} = {};
                    % else
                    %    % Check for discontinuities in the signal (apply padding if selected)
                    %    [cfg,dat{e,1}] = ep_check_signal(cfg,dat{e,1},Fs,PSX,span,day_idx,e);
                    % end
                    
                    % Record summary: duration and padding stats based on NaNs
                    %%% Currently the fraction of data does not represent cases where padding is not selected
                    if ~isempty(dat{e,1})
                        dur  = dat{e,1}.local_time(end)-dat{e,1}.local_time(1); dur.Format = 'dd:hh:mm:ss.SSS'; % Full length of recording
                        pts  = length(dat{e,1}.data);
                        Pnan = sum(isnan(dat{e,1}.data))/length(dat{e,1}.data)*100; % Percent of selected period missing (nan)
                        summary{e,1} = [array2table(dur,"VariableNames","SystP duration") array2table(pts,"VariableNames","SystP pts") array2table(Pnan,"VariableNames","SystP % Missing")];
                        clear dur pts Pnan
                    else
                        summary{e,1} = {};
                    end
    
                end
                clear e bgn_epoch end_epoch
            else
                dat = {[]};
                summary{1,1} = {};
            end
            
            % Remove any empty epochs
            summary(cellfun(@isempty,dat)) = [];
            dat(cellfun(@isempty,dat))     = [];

    end
    
    
end
