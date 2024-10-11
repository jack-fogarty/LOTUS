%% LOTUS: Detrend Data
%  Copyright (C) (2024) Jack Fogarty

function app = ep_detrend(app,i)

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
    if app.det{i,1}.apa == 1
        signals = app.signals;
    else
        signals = {app.ET_SignalDropDown.Value};
    end
    
    % Store parameters in filter variable (det)
    app.det{i,1}.type    = app.DET_TypeDropDown.Value;
    app.det{i,1}.sig     = app.ET_SignalDropDown.Value;
    app.det{i,1}.ord     = app.DET_PolynomialDegree.Value;
    app.det{i,1}.nanflag = app.DET_nanflag.Value;

    
    % Loop for each signal
    for sig = 1:length(signals)
                
        % The current signal
        sigdat = ['app.dat.' signals{sig,1}];
 
        % Loop for all available epochs
        for t = 1:length(eval(sigdat))
        
            if ~strcmp(signals{sig,1},'ACC')

                % Detrend the data
                dat = detrend(eval([sigdat '{' num2str(t) ',1}.data']),app.det{i,1}.ord,app.det{i,1}.nanflag);
                           
                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data = dat']);

            else

                % Detrend the data
                datx = detrend(eval([sigdat '{' num2str(t) ',1}.data_x']),app.det{i,1}.ord,app.det{i,1}.nanflag);
                daty = detrend(eval([sigdat '{' num2str(t) ',1}.data_y']),app.det{i,1}.ord,app.det{i,1}.nanflag);
                datz = detrend(eval([sigdat '{' num2str(t) ',1}.data_z']),app.det{i,1}.ord,app.det{i,1}.nanflag);
                           
                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data_x = datx']);
                eval([sigdat '{' num2str(t) ',1}.data_y = daty']);
                eval([sigdat '{' num2str(t) ',1}.data_z = datz']);

            end
        
        end
        
    end
    
end