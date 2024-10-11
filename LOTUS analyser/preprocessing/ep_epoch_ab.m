%% LOTUS: Event A and B Epoching
%  Copyright (C) (2024) Jack Fogarty

function app = ep_epoch_ab(app,i)

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
    
    % Identify the selected events
    app.epoch{i,1}.cfg.EVA = app.EA_event_dropdown.Value;
    app.epoch{i,1}.cfg.EVB = app.EB_event_dropdown.Value;

    % Index the selected events
    A_idx = ismember(app.dat.Tags{app.e,1}.Tag,str2num(app.epoch{i,1}.cfg.EVA)) | ismember(app.dat.Tags{app.e,1}.Annotation,app.epoch{i,1}.cfg.EVA);
    B_idx = ismember(app.dat.Tags{app.e,1}.Tag,str2num(app.epoch{i,1}.cfg.EVB)) | ismember(app.dat.Tags{app.e,1}.Annotation,app.epoch{i,1}.cfg.EVB);
    
    % Get the event times
    A_tmp = app.dat.Tags{app.e,1}.TZ_TagTime(A_idx);
    B_tmp = app.dat.Tags{app.e,1}.TZ_TagTime(B_idx);
    A_tmp.Format = 'MM/dd/yy HH:mm:ss.SSS';
    B_tmp.Format = 'MM/dd/yy HH:mm:ss.SSS';
    
    % Shoot warning and cut process if Event A and B are the same
    if A_tmp == B_tmp

        % Find app figure
        allfigs = findall(0,'Type', 'figure'); 
        app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');
        
        % No epoch limits are specified. User needs to define limits
        figure(app2Handle)
        uialert(app2Handle,'Event A and B are the same. Epoch window must be defined by two separate events.','Warning');
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

            % Index the events in the continuous data (change to find nearest?)
            [~,ind1] = min(abs(tmp.local_time-A_tmp));
            [~,ind2] = min(abs(tmp.local_time-B_tmp));

            % Epoch the data between the event times
            ep_dat = [tmp(ind1:ind2,:)];

            % Add data to epoch data variable
            eval(['app.epoch{i,1}.' sigdat '{' num2str(t) ',1} = ep_dat']);

        end

    end

end
            