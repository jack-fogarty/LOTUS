%% LOTUS: Artefact Rejection
%  Copyright (C) (2024) Jack Fogarty

function app = ep_art_reject(app,i)

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


    % Get selected signals
    if app.art{i,1}.cfg.apa == 1
        signals = app.signals;
    else
        signals = {app.ET_SignalDropDown.Value};
    end

    % Loop for each signal
    for sig = 1:length(signals)

        % The current signal
        sigdat = ['dat.' signals{sig,1}];

        % Loop for all available epochs
        for t = 1:length(eval(['app.' sigdat]))

            if ~strcmp(signals{sig,1},'ACC')

                % Collect signal data and artefact index
                tmp = eval(['app.' sigdat '{' num2str(t) ',1}']);
                art = eval(['app.art{i,1}.' sigdat '{' num2str(t) ',1}']);
    
                % Reject [NaN] artefacts
                for p = 1:length(art)
                    tmp.data(art(p,1):art(p,2)) = nan;
                end
                                
            else

                % Collect signal data and artefact index
                tmp = eval(['app.' sigdat '{' num2str(t) ',1}']);
                art = eval(['app.art{i,1}.' sigdat '{' num2str(t) ',1}']);
    
                % Reject [NaN] artefacts
                for p = 1:length(art)
                    tmp.data_x(art(p,1):art(p,2)) = nan;
                    tmp.data_y(art(p,1):art(p,2)) = nan;
                    tmp.data_z(art(p,1):art(p,2)) = nan;
                end

            end

            % Store applied artefact rejection
            if isempty(app.rej)
                app.rej = app.art(i,1);
            else
                app.rej = [app.rej; app.art(i,1)];
            end
            
            % Add data to epoch data variable
            eval(['app.' sigdat '{' num2str(t) ',1} = tmp']);

        end

    end

end
