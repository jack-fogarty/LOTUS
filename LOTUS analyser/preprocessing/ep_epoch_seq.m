%% LOTUS: Sequential Epoching
%  Copyright (C) (2024) Jack Fogarty

function app = ep_epoch_seq(app,i)

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
    app.epoch{i,1}.cfg.dir     = app.SEQ_ForwardsButton.Text;

    % Get selected signals
    if app.epoch{i,1}.cfg.apa == 1
        signals = app.signals;
    else
        signals = {app.ET_SignalDropDown.Value};
    end
    
    % Epoch parameters
    app.epoch{i,1}.cfg.EVA    = app.dat.Tags{1,1}.TZ_TagTime(str2num(app.SEQ_event_dropdown.Value));
    app.epoch{i,1}.cfg.epN    = app.SEQ_N_epochs.Value;
    app.epoch{i,1}.cfg.win    = app.SEQ_window_length.Value;
    app.epoch{i,1}.cfg.ovl    = app.SEQ_epoch_overlap.Value; 

    % Event time
    evt = app.epoch{i,1}.cfg.EVA; evt.Format = 'dd/MM/yyyy hh:mm:ss.SSS';
    
    % Shoot warning and cut process if limits are not set
    if isempty(app.epoch{i,1}.cfg.epN) | isempty(app.epoch{i,1}.cfg.win)

        % Find app figure
        allfigs = findall(0,'Type', 'figure'); 
        app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');
        
        % No epoch limits are specified. User needs to define limits
        figure(app2Handle)
        uialert(app2Handle,'Error. User needs to define number of epochs and window to epoch data.','Warning');
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
            
            % Generate epochs from parameters
            for e = 1:app.epoch{i,1}.cfg.epN

                % Index the events in the continuous data
                if strcmp(app.epoch{i,1}.cfg.dir,'Forwards')
                    [~,ind1]  = min(abs(tmp.local_time-(evt+((e-1)*seconds(app.epoch{i,1}.cfg.win)))));
                    [~,ind2]  = min(abs(tmp.local_time-(evt+((e-0)*seconds(app.epoch{i,1}.cfg.win)))));

                    % Epoch data
                    ep_dat{e,1} = [tmp(ind1:ind2,:)];
                else
                    [~,ind1]  = min(abs(tmp.local_time-(evt-((e-1)*seconds(app.epoch{i,1}.cfg.win)))));
                    [~,ind2]  = min(abs(tmp.local_time-(evt-((e-0)*seconds(app.epoch{i,1}.cfg.win)))));
                                        
                    % Epoch data
                    ep_dat{e,1} = [tmp(ind2:ind1,:)];
                end

            end

            % Add data to epoch data variable
            eval(['app.epoch{i,1}.' sigdat '{' num2str(t) ',1} = ep_dat']);
        
        end
        
    end
    
end
            
