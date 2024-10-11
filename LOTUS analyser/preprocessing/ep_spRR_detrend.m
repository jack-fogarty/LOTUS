%% LOTUS: Smoothness Priors "Time Varying" Detrend for RR based on Kubios, established in Tarvainen et al. (2002)
%  Copyright (C) (2024) Jack Fogarty

%%% UNSURE IF THIS WILL ACTUALLY BE USEFUL FOR ANYTHING OTHER THAN RR???
%%% Useful to also have a status icon (busy) as it can take several minutes
%%% to chunk through a long signal...

function app = ep_spRR_detrend(app,i)

%  This script is based on the time varying detrending in Kubios
%  usually conducted for RR after artefact correction: Tarvainen et al. (2002)
%
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
    if app.det{i,1}.cfg.apa == 1
        signals = app.signals;
    else
        signals = {app.ET_SignalDropDown.Value};
    end

    % Store parameters in detrend variable (det)
    app.det{i,1}.cfg.type    = app.DET_TypeDropDown.Value;
    app.det{i,1}.cfg.sig     = app.ET_SignalDropDown.Value;
    app.det{i,1}.cfg.lambda  = app.DET_PolynomialDegree.Value;

    % Loop for each signal
    for sig = 1:length(signals)
                
        % The current signal
        sigdat = ['app.dat.' signals{sig,1}];
 
        % Loop for all available epochs
        for t = 1:length(eval(sigdat))
        
            if ~strcmp(signals{sig,1},'ACC')

                % Detrend the data
                dat = sp_tarvainen(eval([sigdat '{' num2str(t) ',1}.data']),app.det{i,1}.cfg.lambda);
                          
                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data = dat']);

            else

                % Detrend the data
                datx = sp_tarvainen(eval([sigdat '{' num2str(t) ',1}.data_x']),app.det{i,1}.cfg.lambda);
                daty = sp_tarvainen(eval([sigdat '{' num2str(t) ',1}.data_y']),app.det{i,1}.cfg.lambda);
                datz = sp_tarvainen(eval([sigdat '{' num2str(t) ',1}.data_z']),app.det{i,1}.cfg.lambda);
                           
                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data_x = datx']);
                eval([sigdat '{' num2str(t) ',1}.data_y = daty']);
                eval([sigdat '{' num2str(t) ',1}.data_z = datz']);

            end
        
        end
        
    end
    
end
