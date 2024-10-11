%% LOTUS: Artefact Thresholding
%  Copyright (C) (2024) Jack Fogarty

function app = ep_art_thresh(app,i)

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

       
    % Generate artefact storage configuration and data structure
    app.art{i,1}.dat.EDA     = []; % Electrodermal data
    app.art{i,1}.dat.BVP     = []; % Blood volume pulse
    app.art{i,1}.dat.SystP   = []; % Systolic peaks
    app.art{i,1}.dat.Temp    = []; % Temperature (skin)
    app.art{i,1}.dat.ACC     = []; % Accelerometer
    app.art{i,1}.dat.GYR     = []; % Gyroscope
    app.art{i,1}.dat.Steps   = []; % Steps
    app.art{i,1}.dat.Other   = []; % Other data


    % Get selected signals and record parameters
    app.art{i,1}.cfg.apa    = app.ART_ApplytoAll.Value;
    if app.art{i,1}.cfg.apa == 1
        signals = app.signals;
        app.art{i,1}.cfg.signal = 'All';
    else
        signals = {app.ET_SignalDropDown.Value};
        app.art{i,1}.cfg.signal = app.ET_SignalDropDown.Value;
    end

    % Record criteria
    app.art{i,1}.cfg.criteria  = app.ARD_Criteria.Value;

    % Check and set enabled thresholds
    if app.ARD_maxThreshold.Enable
        maxThresh = app.ARD_maxThreshold.Value;
        app.art{i,1}.cfg.maxThresh = app.ARD_maxThreshold.Value;
    else
        maxThresh = nan;
        app.art{i,1}.cfg.maxThresh = nan;
    end

    if app.ARD_minThreshold.Enable
        minThresh = app.ARD_minThreshold.Value;
        app.art{i,1}.cfg.minThresh = app.ARD_minThreshold.Value;
    else
        minThresh = nan;
        app.art{i,1}.cfg.minThresh = nan;
    end

    % Record basic parameters
    app.art{i,1}.cfg.window    = app.ARD_ArtefactWindow.Value;
    app.art{i,1}.cfg.padding   = app.ARD_ArtefactPadding.Value;

    % Loop artefact identification for each signal
    for sig = 1:length(signals)

        % The current signal
        sigdat = ['dat.' signals{sig,1}];

        % Loop for all available epochs
        for t = 1:length(eval(['app.' sigdat]))

            if ~strcmp(signals{sig,1},'ACC')

                % Apply transformation or obtain statistic for thresholding
                tmp = eval(['app.' sigdat '{' num2str(t) ',1}']);
    
                % Compute sample rate based on input
                dt = mean(diff(tmp.local_time));
                fs = 1/seconds(dt); % Hz
    
                % Amplitude
                if strcmp(app.ARD_Criteria.Value,'amplitude')
    
                    % Threshold based on raw amplitude and give value
                    art = tmp.data < minThresh | tmp.data > maxThresh;
                    idx = find(art);
    
                    % Adjust for padding
                    pad   = app.ARD_ArtefactPadding.Value*fs;
                    for p = 1:length(idx)
    
                        % Add padding around artefacts
                        art(idx(p)-pad:idx(p)+pad) = 1;
    
                    end
                    
                    % Identify change points for artefact boundaries
                    x = diff([0; art; 0]);
                    y = [find(x > 0) find(x < 0)-1];
                    clear idx p dt

                    % Identify in terms of time [designed to help reassert
                    % artefact ID following resampling]
                    % y = tmp.local_time(y);
                    % clear idx p dt
    
                elseif strcmp(app.ARD_Criteria.Value,'Zscore')
    
                    % Compute the SD for each data point
                    if isempty(app.ARD_ArtefactWindow.Value) | app.ARD_ArtefactWindow.Value == 0
                        zdat = (tmp.data - nanmean(tmp.data))/nanstd(tmp.data);
                    else
                        window  = app.ARD_ArtefactWindow.Value*fs; % Sliding window
                        rstd    = movstd(tmp.data,window,'omitnan');
                        ravg    = movmean(tmp.data,window,'omitnan');
                        zdat    = (tmp.data - ravg)./rstd;
                    end
    
                    % Threshold based on raw amplitude and give value
                    art = zdat < minThresh | zdat > maxThresh;
                    idx = find(art);
    
                    % Adjust for padding
                    pad   = app.ARD_ArtefactPadding.Value*fs;
                    for p = 1:length(idx)
    
                        % Add padding around artefacts
                        art(idx(p)-pad:idx(p)+pad) = 1;
    
                    end
                    
                    % Identify change points for artefact boundaries
                    x = diff([0; art; 0]);
                    y = [find(x > 0) find(x < 0)-1];
                    clear idx p
    
                elseif strcmp(app.ARD_Criteria.Value,'Variance')
    
                    % Compute the variance for each data point
                    if isempty(app.ARD_ArtefactWindow.Value) | app.ARD_ArtefactWindow.Value == 0
                       
                        % Find app figure
                        allfigs = findall(0,'Type', 'figure'); 
                        app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');

                        % No epoch limits are specified. User needs to define limits
                        figure(app2Handle);
                        uialert(app2Handle,'Window length needs to be defined for this criteria.','Warning');
                        app.rtn = 1;
                                            
                        % Return to Main GUI
                        return      
                    else
                        window  = app.ARD_ArtefactWindow.Value*fs; % five seconds of data
                        rvar    = movvar(tmp.data,window,'omitnan');
                    end
    
                    % Threshold based on raw amplitude and give value
                    art = rvar < minThresh | rvar > maxThresh;
                    idx = find(art);
    
                    % Adjust for padding
                    pad   = app.ARD_ArtefactPadding.Value*fs;
                    for p = 1:length(idx)
    
                        % Add padding around artefacts
                        art(idx(p)-pad:idx(p)+pad) = 1;
    
                    end
                    
                    % Identify change points for artefact boundaries
                    x = diff([0; art; 0]);
                    y = [find(x > 0) find(x < 0)-1];
                    clear idx p
    
                elseif strcmp(app.ARD_Criteria.Value,'SD')
    
                    % Compute the SD for each data point
                    if isempty(app.ARD_ArtefactWindow.Value) | app.ARD_ArtefactWindow.Value == 0
                                                
                        % Find app figure
                        allfigs = findall(0,'Type', 'figure'); 
                        app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');
                        
                        % No epoch limits are specified. User needs to define limits
                        figure(app2Handle);
                        uialert(app2Handle,'Window length needs to be defined for this criteria.','Warning');
                        app.rtn = 1;
                                            
                        % Return to Main GUI
                        return      
                    else
                        window  = app.ARD_ArtefactWindow.Value*fs; % five seconds of data
                        rstd    = movstd(tmp.data,window,'omitnan');
                    end
    
                    % Threshold based on raw amplitude and give value
                    art = rstd < minThresh | rstd > maxThresh;
                    idx = find(art);
    
                    % Adjust for padding
                    pad   = app.ARD_ArtefactPadding.Value*fs;
                    for p = 1:length(idx)
    
                        % Add padding around artefacts
                        art(idx(p)-pad:idx(p)+pad) = 1;
    
                    end
                    
                    % Identify change points for artefact boundaries
                    x = diff([0; art; 0]);
                    y = [find(x > 0) find(x < 0)-1];
                    clear idx p

                elseif strcmp(app.ARD_Criteria.Value,'Slope')
                    
                    % Compute the slope for each data point
                    if isempty(app.ARD_ArtefactWindow.Value) | app.ARD_ArtefactWindow.Value == 0
                                                
                        % Find app figure
                        allfigs = findall(0,'Type', 'figure'); 
                        app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');
                        
                        % No epoch limits are specified. User needs to define limits
                        figure(app2Handle);
                        uialert(app2Handle,'Window length needs to be defined for this criteria.','Warning');
                        app.rtn = 1;
                                            
                        % Return to Main GUI
                        return      
                    else
                        window = app.ARD_ArtefactWindow.Value*fs; % Set the window in points
                        slopes = NaN(height(tmp),1);
                        
                        % Calculate the slope for each window
                        for s = 1:height(tmp)

                            % Determine the start and end indices of the window
                            startIndex = max(1, s - floor(window/2));
                            endIndex = min(height(tmp), s + floor(window/2));
                            
                            % Extract the current window
                            windowData = tmp.data(startIndex:endIndex);
                            
                            % Create the time indices for the window
                            timeIndices = (startIndex:endIndex)';
                            
                            % Perform linear regression to find the slope
                            p = polyfit(timeIndices, windowData, 1); % p(1) is the slope
                            
                            % Store the slope
                            slopes(s) = p(1);

                        end
                        clear s p timeIndices windowData endIndex startIndex
                                                
                    end
                        
                    % Threshold based on raw amplitude and give value
                    art = slopes < minThresh | slopes > maxThresh;
                    idx = find(art);
    
                    % Adjust for padding
                    pad   = app.ARD_ArtefactPadding.Value*fs;
                    for p = 1:length(idx)
    
                        % Add padding around artefacts
                        art(idx(p)-pad:idx(p)+pad) = 1;
    
                    end
                    
                    % Identify change points for artefact boundaries
                    x = diff([0; art; 0]);
                    y = [find(x > 0) find(x < 0)-1];
                    clear idx p
    
                end
                        
                % Add identified artefacts to structure
                eval(['app.art{i,1}.' sigdat '{' num2str(t) ',1} = y']);
    
                clear x y

            else % Run for ACC

                % Apply transformation or obtain statistic for thresholding
                tmp = eval(['app.' sigdat '{' num2str(t) ',1}']);
    
                % Compute sample rate based on input
                dt = mean(diff(tmp.local_time));
                fs = 1/seconds(dt); % Hz
    
                % Amplitude
                if strcmp(app.ARD_Criteria.Value,'amplitude')
    
                    % Threshold based on raw amplitude and give value
                    art_x = tmp.data_x < minThresh | tmp.data_x > maxThresh;
                    art_y = tmp.data_y < minThresh | tmp.data_y > maxThresh;
                    art_z = tmp.data_z < minThresh | tmp.data_z > maxThresh;

                    % Consolidate artefact
                    art = or(art_x,art_y,art_z);
                    idx = find(art);
    
                    % Adjust for padding
                    pad   = app.ARD_ArtefactPadding.Value*fs;
                    for p = 1:length(idx)
    
                        % Add padding around artefacts
                        art(idx(p)-pad:idx(p)+pad) = 1;
    
                    end
                    
                    % Identify change points for artefact boundaries
                    x = diff([0; art; 0]);
                    y = [find(x > 0) find(x < 0)-1];
                    clear idx p dt
    
                elseif strcmp(app.ARD_Criteria.Value,'Zscore')
    
                    % Compute the Zscore for each data point
                    if isempty(app.ARD_ArtefactWindow.Value) | app.ARD_ArtefactWindow.Value == 0
                        zdat_x  = (tmp.data_x - nanmean(tmp.data_x))/nanstd(tmp.data_x);
                        zdat_y  = (tmp.data_y - nanmean(tmp.data_y))/nanstd(tmp.data_y);
                        zdat_z  = (tmp.data_z - nanmean(tmp.data_z))/nanstd(tmp.data_z);
                    else
                        window  = app.ARD_ArtefactWindow.Value*fs; % Sliding window
                        rstd_x  = movstd(tmp.data_x,window,'omitnan');
                        ravg_x  = movmean(tmp.data_x,window,'omitnan');
                        zdat_x  = (tmp.data_x - ravg)./rstd;

                        rstd_y  = movstd(tmp.data_y,window,'omitnan');
                        ravg_y  = movmean(tmp.data_y,window,'omitnan');
                        zdat_y  = (tmp.data_y - ravg)./rstd;

                        rstd_z  = movstd(tmp.data_z,window,'omitnan');
                        ravg_z  = movmean(tmp.data_z,window,'omitnan');
                        zdat_z  = (tmp.data_z - ravg)./rstd;
                    end
    
                    % Threshold based on raw amplitude and give value
                    art_x = zdat_x < minThresh | zdat_x > maxThresh;
                    art_y = zdat_y < minThresh | zdat_y > maxThresh;
                    art_z = zdat_z < minThresh | zdat_z > maxThresh;

                    % Consolidate artefact
                    art = or(art_x,art_y,art_z);
                    idx = find(art);
    
                    % Adjust for padding
                    pad   = app.ARD_ArtefactPadding.Value*fs;
                    for p = 1:length(idx)
    
                        % Add padding around artefacts
                        art(idx(p)-pad:idx(p)+pad) = 1;
    
                    end
                    
                    % Identify change points for artefact boundaries
                    x = diff([0; art; 0]);
                    y = [find(x > 0) find(x < 0)-1];
                    clear idx p
    
                elseif strcmp(app.ARD_Criteria.Value,'Variance')
    
                    % Compute the variance for each data point
                    if isempty(app.ARD_ArtefactWindow.Value) | app.ARD_ArtefactWindow.Value == 0
                        
                        % Find app figure
                        allfigs = findall(0,'Type', 'figure'); 
                        app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');
                        
                        % No epoch limits are specified. User needs to define limits
                        figure(app2Handle);
                        uialert(app2Handle,'Window length needs to be defined for this criteria.','Warning');
                        app.rtn = 1;
                                            
                        % Return to Main GUI
                        return      
                    else
                        window  = app.ARD_ArtefactWindow.Value*fs; % five seconds of data
                        rvar_x  = movvar(tmp.data_x,window,'omitnan');
                        rvar_y  = movvar(tmp.data_y,window,'omitnan');
                        rvar_z  = movvar(tmp.data_z,window,'omitnan');
                    end
    
                    % Threshold based on raw amplitude and give value
                    art_x = rvar_x < minThresh | rvar_x > maxThresh;
                    art_y = rvar_y < minThresh | rvar_y > maxThresh;
                    art_z = rvar_z < minThresh | rvar_z > maxThresh;

                    % Consolidate artefact
                    art = or(art_x,art_y,art_z);
                    idx = find(art);
    
                    % Adjust for padding
                    pad   = app.ARD_ArtefactPadding.Value*fs;
                    for p = 1:length(idx)
    
                        % Add padding around artefacts
                        art(idx(p)-pad:idx(p)+pad) = 1;
    
                    end
                    
                    % Identify change points for artefact boundaries
                    x = diff([0; art; 0]);
                    y = [find(x > 0) find(x < 0)-1];
                    clear idx p
    
                elseif strcmp(app.ARD_Criteria.Value,'SD')
    
                    % Compute the SD for each data point
                    if isempty(app.ARD_ArtefactWindow.Value) | app.ARD_ArtefactWindow.Value == 0
                        
                        % Find app figure
                        allfigs = findall(0,'Type', 'figure'); 
                        app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');
                        
                        % No epoch limits are specified. User needs to define limits
                        figure(app2Handle);
                        uialert(app2Handle,'Window length needs to be defined for this criteria.','Warning');
                        app.rtn = 1;
                                            
                        % Return to Main GUI
                        return      
                    else
                        window  = app.ARD_ArtefactWindow.Value*fs; % Moving window
                        rstd_x  = movstd(tmp.data_x,window,'omitnan');
                        rstd_y  = movstd(tmp.data_y,window,'omitnan');
                        rstd_z  = movstd(tmp.data_z,window,'omitnan');
                    end
    
                    % Threshold based on raw amplitude and give value
                    art_x = rstd_x < minThresh | rstd_x > maxThresh;
                    art_y = rstd_y < minThresh | rstd_y > maxThresh;
                    art_z = rstd_z < minThresh | rstd_z > maxThresh;

                    % Consolidate artefact
                    art = or(art_x,art_y,art_z);
                    idx = find(art);
    
                    % Adjust for padding
                    pad   = app.ARD_ArtefactPadding.Value*fs;
                    for p = 1:length(idx)
    
                        % Add padding around artefacts
                        art(idx(p)-pad:idx(p)+pad) = 1;
    
                    end
                    
                    % Identify change points for artefact boundaries
                    x = diff([0; art; 0]);
                    y = [find(x > 0) find(x < 0)-1];
                    clear idx p
    
                elseif strcmp(app.ARD_Criteria.Value,'Slope')
                                                                   
                    % Find app figure
                    allfigs = findall(0,'Type', 'figure'); 
                    app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');
                    
                    % No epoch limits are specified. User needs to define limits
                    figure(app2Handle);
                    uialert(app2Handle,'Slope criteria will not be computed for ACC.','Warning');
                    app.rtn = 1;
                                                                                            
                end
                        
                % Add identified artefact timepoints to structure
                eval(['app.art{i,1}.' sigdat '{' num2str(t) ',1} = y']);
    
                clear x y

            end

        end

    end




