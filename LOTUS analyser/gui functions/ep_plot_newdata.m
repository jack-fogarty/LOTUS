%% LOTUS: Update GUI Plot with New Data
%  Copyright (C) (2024) Jack Fogarty

function ep_plot_newdata(app)

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

    % Prelim
    m = 2; % Multiplier for big step buffer for plotting large signal data

    % Selected data for evaluation
    app.osigdat = ['app.original_dat.' app.ET_SignalDropDown.Value '{app.e,1}'];
    app.sigdat  = ['app.dat.' app.ET_SignalDropDown.Value '{app.e,1}'];

    % Plot empty datetime to preset limits and data type
    N = datetime('now','TimeZone',app.cfg.TimeZone);
    plot(app.ET_UIAxes,N,NaN);

    % Update X axis time range parameters to fit original data
    tmp = eval([app.osigdat '.local_time(round(length(' app.osigdat '.local_time)*0.1)) - min(' app.osigdat '.local_time);']);
    if tmp > hours(1)
       tmp = round(hours(tmp));
       app.timerange = hours(tmp);
    else
       tmp = eval(['max(' app.osigdat '.local_time) - min(' app.osigdat '.local_time)']);
       app.timerange = tmp;
    end

    % Default big and small steps for X axis navigation
    app.big   = app.timerange*0.50; % Big step   = zero
    app.small = app.timerange*0.05; % Small step = zero
    clear tmp
    
    % Apply X and Y parameters
    app.ET_UIAxes.XLim = [min(eval([app.osigdat '.local_time'])) min(eval([app.osigdat '.local_time']))+app.timerange];
    app.ET_UIAxes.YLimMode = 'auto';

    % Modifiable buffer for signal data plotting
    buffer = app.big*m;

    % Plot original data
    if app.OverlayOriginal.Value
        valid  = eval([app.osigdat '.local_time']) >= app.ET_UIAxes.XLim(1)-buffer & eval([app.osigdat '.local_time']) <= app.ET_UIAxes.XLim(2)+buffer;
        if ~strcmp(app.ET_SignalDropDown.Value,'ACC')
            line(app.ET_UIAxes,eval([app.osigdat '.local_time(valid)']),eval([app.osigdat '.data(valid)']),'Color','#D6D6D6','Tag','original');
        else
            line(app.ET_UIAxes,eval([app.osigdat '.local_time(valid)']),eval([app.osigdat '.data_x(valid)']),'Color','#D6D6D6','Tag','original_x');
            line(app.ET_UIAxes,eval([app.osigdat '.local_time(valid)']),eval([app.osigdat '.data_y(valid)']),'Color','#A3A9AA','Tag','original_y');
            line(app.ET_UIAxes,eval([app.osigdat '.local_time(valid)']),eval([app.osigdat '.data_z(valid)']),'Color','#BBBBBF','Tag','original_z');
        end
        % uistack(findobj(app.ET_UIAxes,'tag','original'),"bottom");
    end

    % Plot working data
    valid  = eval([app.sigdat '.local_time']) >= app.ET_UIAxes.XLim(1)-buffer & eval([app.sigdat '.local_time']) <= app.ET_UIAxes.XLim(2)+buffer;
    if ~strcmp(app.ET_SignalDropDown.Value,'ACC')
        line(app.ET_UIAxes,eval([app.sigdat '.local_time(valid)']),eval([app.sigdat '.data(valid)']),  'Color','#0072BD','Tag','working_x');
    else
        line(app.ET_UIAxes,eval([app.sigdat '.local_time(valid)']),eval([app.sigdat '.data_x(valid)']),'Color','#0A9DFF','Tag','working_x');
        line(app.ET_UIAxes,eval([app.sigdat '.local_time(valid)']),eval([app.sigdat '.data_y(valid)']),'Color','#66BCE1','Tag','working_y');
        line(app.ET_UIAxes,eval([app.sigdat '.local_time(valid)']),eval([app.sigdat '.data_z(valid)']),'Color','#0072BD','Tag','working_z');
    end
    % uistack(findobj(app.ET_UIAxes,'tag','working_x'),"down");

    % Plot any events
    ep_update_tags(app);

    % Ensure tags are on top
    uistack(findobj(app.ET_UIAxes,'type','ConstantLine'),"top");

end
