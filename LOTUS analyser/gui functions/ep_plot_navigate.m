%% LOTUS: Scroll plot
%  Copyright (C) (2024) Jack Fogarty

function ep_plot_navigate(app)

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

    % Modifiable buffer for signal data plotting
    buffer = app.big*m;

    % Selected data for evaluation
    app.osigdat = ['app.original_dat.' app.ET_SignalDropDown.Value '{app.e,1}'];
    app.sigdat  = ['app.dat.' app.ET_SignalDropDown.Value '{app.e,1}'];

    % Plot original data
    if app.OverlayOriginal.Value && ~isempty(findobj(app.ET_UIAxes,'tag','original'))
        valid  = eval([app.osigdat '.local_time']) >= app.ET_UIAxes.XLim(1)-buffer & eval([app.osigdat '.local_time']) <= app.ET_UIAxes.XLim(2)+buffer;
        if ~strcmp(app.ET_SignalDropDown.Value,'ACC')
            set(findobj(app.ET_UIAxes,'tag','original'),'XData',eval([app.osigdat '.local_time(valid)']),'YData',eval([app.osigdat '.data(valid)']));
        else
            set(findobj(app.ET_UIAxes,'tag','original_x'),'XData',eval([app.osigdat '.local_time(valid)']),'YData',eval([app.osigdat '.data_x(valid)']));
            set(findobj(app.ET_UIAxes,'tag','original_y'),'XData',eval([app.osigdat '.local_time(valid)']),'YData',eval([app.osigdat '.data_y(valid)']));
            set(findobj(app.ET_UIAxes,'tag','original_z'),'XData',eval([app.osigdat '.local_time(valid)']),'YData',eval([app.osigdat '.data_z(valid)']));
        end
        % uistack(findobj(app.ET_UIAxes,'tag','original'),"bottom");
    end

    % Plot working data
    if ~isempty(findobj(app.ET_UIAxes,'tag','working_x'))
        valid  = eval([app.sigdat '.local_time']) >= app.ET_UIAxes.XLim(1)-buffer & eval([app.sigdat '.local_time']) <= app.ET_UIAxes.XLim(2)+buffer;
        if ~strcmp(app.ET_SignalDropDown.Value,'ACC')
            set(findobj(app.ET_UIAxes,'tag','working_x'),'XData',eval([app.sigdat '.local_time(valid)']),'YData',eval([app.sigdat '.data(valid)']));
        else
            set(findobj(app.ET_UIAxes,'tag','working_x'),'XData',eval([app.sigdat '.local_time(valid)']),'YData',eval([app.sigdat '.data_x(valid)']));
            set(findobj(app.ET_UIAxes,'tag','working_y'),'XData',eval([app.sigdat '.local_time(valid)']),'YData',eval([app.sigdat '.data_y(valid)']));
            set(findobj(app.ET_UIAxes,'tag','working_z'),'XData',eval([app.sigdat '.local_time(valid)']),'YData',eval([app.sigdat '.data_z(valid)']));
        end
        % uistack(findobj(app.ET_UIAxes,'tag','original'),"bottom");
    end
    
    % Check and plot epochs
    ep_plot_epoch(app);

    % Ensure tags are on top
    uistack(findobj(app.ET_UIAxes,'type','ConstantLine'),"top");

end

