%% LOTUS: Overlay Original Signal Data
%  Copyright (C) (2024) Jack Fogarty

function ep_plot_overlay(app)

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
    if app.OverlayOriginal.Value
        valid  = eval([app.osigdat '.local_time']) >= app.ET_UIAxes.XLim(1)-buffer & eval([app.osigdat '.local_time']) <= app.ET_UIAxes.XLim(2)+buffer;
        if ~strcmp(app.ET_SignalDropDown.Value,'ACC')
            line(app.ET_UIAxes,eval([app.osigdat '.local_time(valid)']),eval([app.osigdat '.data(valid)']),'Color','#D6D6D6','Tag','original');
        else
            line(app.ET_UIAxes,eval([app.osigdat '.local_time(valid)']),eval([app.osigdat '.data_x(valid)']),'Color','#D6D6D6','Tag','original_x');
            line(app.ET_UIAxes,eval([app.osigdat '.local_time(valid)']),eval([app.osigdat '.data_y(valid)']),'Color','#A3A9AA','Tag','original_y');
            line(app.ET_UIAxes,eval([app.osigdat '.local_time(valid)']),eval([app.osigdat '.data_z(valid)']),'Color','#BBBBBF','Tag','original_z');
        end
        uistack(findobj(app.ET_UIAxes,'tag','original'),"bottom");
        uistack(findobj(app.ET_UIAxes,'tag','original_x'),"bottom");
        uistack(findobj(app.ET_UIAxes,'tag','original_y'),"bottom");
        uistack(findobj(app.ET_UIAxes,'tag','original_z'),"bottom");
    else
        delete(findobj(app.ET_UIAxes,'tag','original'));
        delete(findobj(app.ET_UIAxes,'tag','original_x'));
        delete(findobj(app.ET_UIAxes,'tag','original_y'));
        delete(findobj(app.ET_UIAxes,'tag','original_z'));
    end

    % Update patches to match any limit changes
    ep_plot_epochpatch(app);

end