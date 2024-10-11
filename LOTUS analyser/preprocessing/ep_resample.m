%% LOTUS: Resample Data
%  Copyright (C) (2024) Jack Fogarty

function app = ep_resample(app,i)

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
    if app.res{i,1}.apa == 1
        signals = app.signals;
    else
        signals = {app.ET_SignalDropDown.Value};
    end
    
    % Store parameters in resample variable (res)
    app.res{i,1}.int = app.RES_Interp.Value;
    app.res{i,1}.sig = app.ET_SignalDropDown.Value;
    app.res{i,1}.rHz = app.RES_HzEdit.Value;

    % Loop for each signal
    for sig = 1:length(signals)
                
        % The current signal
        sigdat = ['app.dat.' signals{sig,1}];
        
        % Current Posix modifier
        PSX = 10^6;
                
        % Loop for all available epochs
        for t = 1:length(eval(sigdat))
            
            % Convert to timetable
            TT1 = table2timetable(eval([sigdat '{' num2str(t) ',1}']));
            
            % Resample to chosen sample rate with selected interpolation
            TT2 = retime(TT1,'regular',app.res{i,1}.int,'SampleRate',app.res{i,1}.rHz,"EndValues",NaN);

            if ~strcmp(signals{sig,1},'ACC')

                % Interpolate amplitude data using linear interp1 to translate any pre-existing NaN values to the resampled dataseries
                nanIDX = interp1(TT1.local_time,TT1.data,TT2.local_time,'linear');
                nanIDX = isnan(nanIDX);
    
                % Replace NaNs back into resampled timeseries
                TT2.data(nanIDX) = nan;

            else

            end
            
            % Reset table format and configuration
            TT2 = timetable2table(TT2); % Return as Table
            TT2 = movevars(TT2,'local_time','After','unix_time'); % Restore variable order
            TT2.unix_time = posixtime(TT2.local_time)*PSX; % Ensure all UTC times are updated
            
            % Replace the data for this epoch
            eval([sigdat '{' num2str(t) ',1} = TT2']);
            
        end
        
    end
                
end
