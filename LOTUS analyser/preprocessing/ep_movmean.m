%% LOTUS: Movmean Filter Data
%  Copyright (C) (2024) Jack Fogarty

function app = ep_movmean(app,i)

%  This file is part of the EmbracePlus Toolkit.
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

    % Get selected signals
    if app.fil{i,1}.cfg.apa == 1
        signals = app.signals;
    else
        signals = {app.ET_SignalDropDown.Value};
    end

    % Store parameters in filter variable (fil)
    app.fil{i,1}.cfg.type   = app.FIL_FilterTypeDD.Value;
    app.fil{i,1}.cfg.sig    = app.ET_SignalDropDown.Value;
    app.fil{i,1}.cfg.winpts = app.FIL_FilterWindowPts.Value;
    app.fil{i,1}.cfg.low    = app.FIL_Lowpasscutoff.Value;
    app.fil{i,1}.cfg.high   = app.FIL_Highpasscutoff.Value;
    app.fil{i,1}.cfg.ord    = app.FIL_FilterOrder.Value;
    app.fil{i,1}.cfg.notch  = app.FIL_Notch.Value;
    
    % Loop for each signal
    for sig = 1:length(signals)
                
        % The current signal
        sigdat = ['app.dat.' signals{sig,1}];
 
        % Loop for all available epochs
        for t = 1:length(eval(sigdat))
        
            if ~strcmp(signals{sig,1},'ACC')

                % Apply movmean filter
                dat = movmean(eval([sigdat '{' num2str(t) ',1}.data']),app.fil{i,1}.cfg.winpts,'omitnan');
                
                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data = dat']);
        
            else

                % Apply movmean filter
                datx = movmean(eval([sigdat '{' num2str(t) ',1}.data_x']),app.fil{i,1}.cfg.winpts,'omitnan');
                daty = movmean(eval([sigdat '{' num2str(t) ',1}.data_y']),app.fil{i,1}.cfg.winpts,'omitnan');
                datz = movmean(eval([sigdat '{' num2str(t) ',1}.data_z']),app.fil{i,1}.cfg.winpts,'omitnan');
                           
                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data_x = datx']);
                eval([sigdat '{' num2str(t) ',1}.data_y = daty']);
                eval([sigdat '{' num2str(t) ',1}.data_z = datz']);

            end
        end
        
    end
    
end
            
