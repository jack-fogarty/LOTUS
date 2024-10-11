%% LOTUS: Coordinate Updates to Main PLot
%  Copyright (C) (2024) Jack Fogarty

function ep_updateplot(app,event)

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

switch event

    case 'load_new'
        ep_plot_newdata(app)

    case 'NAV'
        ep_plot_navigate(app)
            
    case 'PROC'
        ep_plot_navigate(app)

    case 'SIG'
        ep_plot_signalchange(app)

    case 'OVR'
        ep_plot_overlay(app)

    case 'EPO'
        ep_plot_epoch(app)

    case 'ART'
        ep_plot_epochpatch(app)
    
    case 'Tag'
        ep_update_tags(app)

end
