%% LOTUS: Butterworth Filter Data
%  Copyright (C) (2024) Jack Fogarty

function app = ep_butterworth(app,i)

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

    % Clarify filter parameters
    if     app.fil{i,1}.cfg.low == 0 && app.fil{i,1}.cfg.high ~= 0
           ftype = 'high';
           Wn    = app.fil{i,1}.cfg.high;
    elseif app.fil{i,1}.cfg.low ~= 0 && app.fil{i,1}.cfg.high == 0
           ftype = 'low';
           Wn    = app.fil{i,1}.cfg.low;
    elseif app.fil{i,1}.cfg.low ~= 0 && app.fil{i,1}.cfg.high ~= 0 && app.fil{i,1}.cfg.notch == 0       
           ftype = 'bandpass';
           Wn    = [app.fil{i,1}.cfg.high app.fil{i,1}.cfg.low];
    elseif app.fil{i,1}.cfg.low ~= 0 && app.fil{i,1}.cfg.high ~= 0 && app.fil{i,1}.cfg.notch == 1       
           ftype = 'stop';
           Wn    = [app.fil{i,1}.cfg.high app.fil{i,1}.cfg.low];
    end
       
    % Filter order
    ord = app.fil{i,1}.cfg.ord;

    % Loop for each signal
    for sig = 1:length(signals)
                
        % The current signal
        sigdat = ['app.dat.' signals{sig,1}];
 
        % Loop for all available epochs
        for t = 1:length(eval(sigdat))
        
            if ~strcmp(signals{sig,1},'ACC')

                % Check and zero nans temporarily
                x = eval([sigdat '{' num2str(t) ',1}.data']);
                idx_nan = isnan(x); x(idx_nan) = 0;

                % Sample Rate
                dt = mean(diff(eval([sigdat '{' num2str(t) ',1}.local_time'])));
                fs = 1/seconds(dt); % Hz
                
                % Design and apply butterworth filter
                [b,a] = butter(ord,Wn/(fs/2),ftype);
                dat   = filtfilt(b,a,x);
                
                % Return nan values to data
                dat(idx_nan) = nan;
                           
                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data = dat']);

            else

                dim = {'x','y','z'};

                for d = 1:length(dim)
                    % Check and zero nans temporarily
                    x = eval([sigdat '{' num2str(t) ',1}.data_' dim{d}]);
                    idx_nan = isnan(x); x(idx_nan) = 0;
                    
                    % Design and apply butterworth filter
                    [b,a] = butter(ord,Wn/(fs/2),ftype);
                    dat   = filtfilt(b,a,x);
                    
                    % Return nan values to data
                    dat(idx_nan) = nan;
                               
                    % Replace the data for this epoch
                    eval([sigdat '{' num2str(t) ',1}.data_' dim{d} ' = dat']);
                end

            end
        
        end
        
    end
    
end
 

%   % Design the butterworth filter
%   [b,a]   = butter(ord,Wn/(fs/2),ftype);
%   [z,p,k] = butter(ord,Wn/(fs/2));
%   [sos,g] = zp2sos(z,p,k);
%   Using second order (sos) may be more robust...
    
    % Check filter
%     figure
%     freqz(sos, 2^16, fs)
%     set(subplot(2,1,1), 'XScale','log')
%     set(subplot(2,1,2), 'XScale','log')
