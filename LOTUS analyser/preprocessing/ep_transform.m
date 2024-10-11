%% LOTUS: Transform Data
%  Copyright (C) (2024) Jack Fogarty

function app = ep_transform(app,i)

%%% LOG10 disabled for now in app. Needs to be determined if it is relevant
%%% at this stage and, if so, it also needs a way to handle negative values
%%% (e.g., add constant)

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
    if app.Tra{i,1}.cfg.apa == 1
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
                
                % Apply Z scoring
                if app.ZscoreCheckBox.Value
                                       
                    % Compute the SD for each data point
                    if app.TransformWindow.Value == 0
                        tmp.data = (tmp.data - nanmean(tmp.data))/nanstd(tmp.data);
                    else
                        % Compute sample rate based on input
                        dt       = mean(diff(tmp.local_time));
                        fs       = 1/seconds(dt); % Hz
                        window   = app.TransformWindow.Value*fs; % Sliding window
                        rstd     = movstd(tmp.data,window,'omitnan');
                        ravg     = movmean(tmp.data,window,'omitnan');
                        tmp.data = (tmp.data - ravg)./rstd;
                    end

                % Apply Log10 transformation
                elseif app.Log10CheckBox.Value
                        tmp.data = log10(tmp.data);
                end
                                                
            else % For ACC

                % Collect signal data and artefact index
                tmp = eval(['app.' sigdat '{' num2str(t) ',1}']);
    
                % Apply Z scoring
                if app.ZscoreCheckBox.Value
                                       
                    % Compute the SD for each data point
                    if app.TransformWindow.Value == 0
                        tmp.data_x = (tmp.data_x - nanmean(tmp.data_x))/nanstd(tmp.data_x);
                        tmp.data_y = (tmp.data_y - nanmean(tmp.data_y))/nanstd(tmp.data_y);
                        tmp.data_z = (tmp.data_z - nanmean(tmp.data_z))/nanstd(tmp.data_z);
                    else
                        % Compute sample rate based on input
                        dt          = mean(diff(tmp.local_time));
                        fs          = 1/seconds(dt); % Hz
                        window      = app.TransformWindow.Value*fs; % Sliding window

                        rstd_x      = movstd(tmp.data_x,window,'omitnan');
                        ravg_x      = movmean(tmp.data_x,window,'omitnan');
                        tmp.data_x  = (tmp.data_x - ravg)./rstd;

                        rstd_y      = movstd(tmp.data_y,window,'omitnan');
                        ravg_y      = movmean(tmp.data_y,window,'omitnan');
                        tmp.data_y  = (tmp.data_y - ravg)./rstd;

                        rstd_z      = movstd(tmp.data_z,window,'omitnan');
                        ravg_z      = movmean(tmp.data_z,window,'omitnan');
                        tmp.data_z  = (tmp.data_z - ravg)./rstd;
                    end

                % Apply Log10 transformation
                elseif app.Log10CheckBox.Value
                        tmp.data_x = log10(tmp.data_x);
                        tmp.data_y = log10(tmp.data_y);
                        tmp.data_z = log10(tmp.data_z);
                end

            end
            
            % Add data to epoch data variable
            eval(['app.' sigdat '{' num2str(t) ',1} = tmp']);

        end

    end

end
