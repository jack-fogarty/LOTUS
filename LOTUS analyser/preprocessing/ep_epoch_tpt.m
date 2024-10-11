%% LOTUS: Epoch around Timepoint
%  Copyright (C) (2024) Jack Fogarty

function app = ep_epoch_tpt(app,i)

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
    

    % Generate epoch configuration and data structure
    app.epoch{i,1}.dat.EDA     = []; % Electrodermal data
    app.epoch{i,1}.dat.BVP     = []; % Blood volume pulse
    app.epoch{i,1}.dat.SystP   = []; % Systolic peaks
    app.epoch{i,1}.dat.Temp    = []; % Temperature (skin)
    app.epoch{i,1}.dat.ACC     = []; % Accelerometer
    app.epoch{i,1}.dat.GYR     = []; % Gyroscope
    app.epoch{i,1}.dat.Steps   = []; % Steps
    app.epoch{i,1}.dat.Other   = []; % Other data
    app.epoch{i,1}.dat.Tags    = []; % Tags (event markers)
    app.epoch{i,1}.dat.Summary = []; % Summary of dataset
    
    % Store parameters in epoch variable (epoch)
    app.epoch{i,1}.cfg.apa     = app.EPO_ApplytoAll.Value;
    app.epoch{i,1}.cfg.type    = app.EPO_ModeListBox.Value;

    % Get selected signals
    if app.epoch{i,1}.cfg.apa == 1
        signals = app.signals;
    else
        signals = {app.ET_SignalDropDown.Value};
    end
    
    %%% NEED TO ALLOW CONDITION FOR SETTING TIME OR POINT
    % Event time/point and parameters
    if app.ETP_TimeButton.Value
        % Work with time and duration
        app.epoch{i,1}.cfg.EVA  = datetime(app.ETP_ep_datepick.Value) + app.ETP_ep_datetime.Value; app.epoch{i,1}.cfg.EVA.Format = 'dd/MM/yyyy hh:mm:ss.SSS';
        app.epoch{i,1}.cfg.pre  = app.ETP_PreEditField.Value;
        app.epoch{i,1}.cfg.pst  = app.ETP_PostEditField.Value; 
    else
        % Work with relative points
        app.epoch{i,1}.cfg.EVA  = [];
        app.epoch{i,1}.cfg.pre  = [];
        app.epoch{i,1}.cfg.pst  = []; 
    end

    % Epoch limits
    pre = seconds(app.epoch{i,1}.cfg.pre);
    pst = seconds(app.epoch{i,1}.cfg.pst);
    
    % Shoot warning and cut process if limits are not set
    if isempty(app.epoch{i,1}.cfg.pre) | isempty(app.epoch{i,1}.cfg.pst)

        % Find app figure
        allfigs = findall(0,'Type', 'figure'); 
        app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');
        
        % No epoch limits are specified. User needs to define limits
        figure(app2Handle)
        uialert(app2Handle,'No epoch limits set. User needs to define "Pre" and "Post" event limits to epoch data.','Warning');
        app.rtn = 1;
                            
        % Return to Main GUI
        return      

    end

    % Loop for each signal
    for sig = 1:length(signals)
                
        % The current signal
        sigdat = ['dat.' signals{sig,1}];
 
        % Loop for all available epochs
        for t = 1:length(eval(['app.' sigdat]))
        
            % Apply epoching to signal
            tmp = eval(['app.' sigdat '{' num2str(t) ',1}']);
            
            % Set epoch points
            pre = app.epoch{i,1}.cfg.EVA - pre; % Replace second part with pre secs
            pst = app.epoch{i,1}.cfg.EVA + pst; % Replace second part with post secs
            pre.TimeZone = tmp.local_time.TimeZone;
            pst.TimeZone = tmp.local_time.TimeZone;

            % Index the events in the continuous data (change to find nearest?)
            [~,ind1] = min(abs(tmp.local_time-pre));
            [~,ind2] = min(abs(tmp.local_time-pst));
                    
            % Epoch the data between the event times
            ep_dat = [tmp(ind1:ind2,:)];

            % Add data to epoch data variable
            eval(['app.epoch{i,1}.' sigdat '{' num2str(t) ',1} = ep_dat']);
        
        end
        
    end
    
end
            
