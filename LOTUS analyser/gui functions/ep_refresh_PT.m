%% LOTUS: Refresh Low-Level Tab Groups in Preprocessing Tab
%  Copyright (C) (2024) Jack Fogarty

function ep_refresh_PT(app)

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


    % Update the epoch tabs
    if ~isempty(app.dat)

        % Update the sample rate label
        app.RES_Hz_label.Text = [num2str(round(1/seconds(mean(diff(eval([app.sigdat '.local_time'])))))) ' Hz']; % Hz

        % Event-Related
        if  app.EVR_TagButton.Value 
            app.EVR_ListBox.Items = cellstr(num2str(app.dat.Tags{app.e}.Tag));
        else
            app.EVR_ListBox.Items = app.dat.Tags{app.e}.Annotation;
        end
        
        % Sequential Epoching
        if  app.SEQ_TagButton.Value
            app.SEQ_event_dropdown.Items = cellstr(num2str(app.dat.Tags{app.e}.Tag));
        else
            app.SEQ_event_dropdown.Items = app.dat.Tags{app.e}.Annotation;
        end
        
        % Enable Timepoint Selection
    if  app.ETP_TimeButton.Value
        app.ETP_ep_datepick.Enable = 1;
        app.ETP_ep_datetime.Enable = 1;
        app.ETP_ep_point.Enable    = 0;
    else
        app.ETP_ep_datepick.Enable = 0;
        app.ETP_ep_datetime.Enable = 0;
        app.ETP_ep_point.Enable    = 1;
    end

        % Event A
        if  app.EA_TagButton.Value
            app.EA_event_dropdown.Items = cellstr(num2str(app.dat.Tags{app.e}.Tag));
        else
            app.EA_event_dropdown.Items = app.dat.Tags{app.e}.Annotation;
        end

        % Event B
        if  app.EB_TagButton.Value
            app.EB_event_dropdown.Items = cellstr(num2str(app.dat.Tags{app.e}.Tag));
        else
            app.EB_event_dropdown.Items = app.dat.Tags{app.e}.Annotation;
        end            
    end

end