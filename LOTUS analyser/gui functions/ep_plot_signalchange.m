%% LOTUS: Update GUI Plot to Display Selected Signal Modality
%  Copyright (C) (2024) Jack Fogarty

function ep_plot_signalchange(app)

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

    % Remove previous lines
    delete(findobj(app.ET_UIAxes.Children, 'type', 'Line'));

    % Modifiable buffer for signal data plotting
    buffer = app.big*m;

    % Selected data for evaluation
    app.osigdat = ['app.original_dat.' app.ET_SignalDropDown.Value '{app.e,1}'];
    app.sigdat  = ['app.dat.' app.ET_SignalDropDown.Value '{app.e,1}'];

    % Plot original data
    if app.OverlayOriginal.Value && ~isempty(findobj(app.ET_UIAxes,'tag','original'))
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
    if ~isempty(app.signals)
        valid  = eval([app.sigdat '.local_time']) >= app.ET_UIAxes.XLim(1)-buffer & eval([app.sigdat '.local_time']) <= app.ET_UIAxes.XLim(2)+buffer;
        if ~strcmp(app.ET_SignalDropDown.Value,'ACC')
            line(app.ET_UIAxes,eval([app.sigdat '.local_time(valid)']),eval([app.sigdat '.data(valid)']),  'Color','#0072BD','Tag','working_x');
        else
            line(app.ET_UIAxes,eval([app.sigdat '.local_time(valid)']),eval([app.sigdat '.data_x(valid)']),'Color','#0A9DFF','Tag','working_x');
            line(app.ET_UIAxes,eval([app.sigdat '.local_time(valid)']),eval([app.sigdat '.data_y(valid)']),'Color','#66BCE1','Tag','working_y');
            line(app.ET_UIAxes,eval([app.sigdat '.local_time(valid)']),eval([app.sigdat '.data_z(valid)']),'Color','#0072BD','Tag','working_z');
        end
        % uistack(findobj(app.ET_UIAxes,'tag','original'),"bottom");
    end
    
    % Check and plot epochs
    ep_plot_epoch(app);

    % Check overlay
    ep_plot_overlay(app);

    % Ensure tags are on top
    uistack(findobj(app.ET_UIAxes,'type','ConstantLine'),"top");

end
