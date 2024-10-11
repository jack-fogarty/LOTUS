%% LOTUS: Nan pad to epoch length in EmbracePlus signal data
%  Copyright (C) (2024) Jack Fogarty

function [dat] = ep_pad_to_epoch(cfg,dat,Fs,PSX,span,day_idx,e)

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

    % Initialise variables
    cols = size(dat,2)-2; % Number of columns of data
    
    if cols > 1 % Then it is accelerometer data and requires additional table var names
       vars = {'data_x','data_y','data_z'};
    else
       vars = {'data'};
    end
    
        % For Default method the epochs are days in UTC time
        if strcmp(cfg.ReadMethod,'Default')

                % Set Epoch Start
                % Find the start of the day in UTC to match Empatica roll over
                bgn_epoch = dat.local_time(1); bgn_epoch.TimeZone = 'UTC';
                bgn_epoch = dateshift(bgn_epoch,'start','day');

                % Convert back to working timezone for integration
                bgn_epoch.TimeZone = cfg.TimeZone;

                % Set Epoch End
                % Find the end of the day in UTC to match Empatica roll over and subtract a ms so as not to overlap with next day start
                end_epoch = dat.local_time(1); end_epoch.TimeZone = 'UTC';
                end_epoch = dateshift(end_epoch,'end','day')-milliseconds(1);

                % Convert back to working timezone for integration
                end_epoch.TimeZone = cfg.TimeZone;
        
        % Identify epoch limits for Custom method set by the user
        elseif strcmp(cfg.ReadMethod,'Custom')
                   
                % If all custom time parameters were zero then prompt user to fix their settings in the GUI
                if cfg.Stime.H == 0 && cfg.Stime.M == 0 && cfg.Stime.S == 0 ...
                        && cfg.Etime.H == 0 && cfg.Etime.M == 0 && cfg.Etime.S == 0 ...
                        && cfg.Tspan.Y == 0 && cfg.Tspan.M == 0 && cfg.Tspan.D == 0
                    
                    % Find app figure
                    % Get handles to *all* figures
                    allfigs = findall(0,'Type', 'figure'); 
                    % Isolate the app's handle based on the App's name and unique tag
                    app2Handle = findall(allfigs, 'Name', 'LOTUS_reader', 'Tag', 'LOTUS_reader');
                    
                    
                    % No path is specified. User needs to browse to parent folder
                    figure(app2Handle)
                    uialert(app2Handle,'Timewindow and/or timespan parameters not set. User needs to define the custom epoch in the main GUI.','Warning')
                    
                    % Return to Main GUI
                    return                   
                end
                
                % Set epoch limits
                bgn_epoch = day_idx(e) + duration(cfg.Stime.H,cfg.Stime.M,cfg.Stime.S); bgn_epoch.Format = 'MM/dd/yy HH:mm:ss'; % Desired epoch start time point
                end_epoch = bgn_epoch + span; % Desired epoch end point
        end

        % NaN pad the signal to the maximum epoch length
    
        % Check and pad the beginning of the epoch (to the "~nearest~" second. may need greater precision here?)
        if dateshift(dat.local_time(1),'start','second') > bgn_epoch

           % Add NaN pad to start
           x = (dat.local_time(1)-bgn_epoch)/milliseconds(1000/Fs); % How many n points
           y = linspace(bgn_epoch,dat.local_time(1),x)'; y.Format = 'MM/dd/yy HH:mm:ss.SSS';
           pad_rtime = y(1:end-1,:);
           pad_utime = posixtime(pad_rtime)*PSX;
           pad_data  = nan(length(pad_rtime),cols);
           padding   = [array2table(pad_utime,'VariableNames',{'unix_time'}) table(pad_rtime,'VariableNames',{'local_time'}) array2table(pad_data,'VariableNames',vars)];
           dat       = [padding; dat];
           clear pad_rtime pad_utime pad_data padding x y                   
        end

        % Check and pad the end of the epoch (to the "~nearest~" second. may need greater precision here?)
        if dateshift(dat.local_time(end),'end','second') < end_epoch

           % Add NaN pad to end
           x = (end_epoch-(dat.local_time(end)+milliseconds(1000/Fs)))/milliseconds(1000/Fs); % How many n points
           y = linspace((dat.local_time(end)+milliseconds(1000/Fs)),end_epoch,x)'; y.Format = 'MM/dd/yy HH:mm:ss.SSS';
           pad_rtime = y(1:end,:);
           pad_utime = posixtime(pad_rtime)*PSX;
           pad_data  = nan(length(pad_rtime),cols);
           padding   = [array2table(pad_utime,'VariableNames',{'unix_time'}) table(pad_rtime,'VariableNames',{'local_time'}) array2table(pad_data,'VariableNames',vars)];
           dat       = [dat; padding];
           clear pad_rtime pad_utime pad_data padding
        end
        
end