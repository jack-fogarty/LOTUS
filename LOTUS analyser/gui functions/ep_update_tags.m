%% LOTUS: Update Plot Tags
%  Copyright (C) (2024) Jack Fogarty

function ep_update_tags(app)

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


    % Plot any events
    if ~isempty(app.dat.Tags{app.e})
        
        % Clear any possible event markers
        delete(findobj(app.ET_UIAxes, 'type', 'ConstantLine'));
        labels = num2cell(app.dat.Tags{app.e}.Tag);
        xline(app.ET_UIAxes, app.dat.Tags{app.e}.TZ_TagTime,'red',labels,'LabelHorizontalAlignment','center','LabelOrientation','horizontal');
        
        % Check that tags marked for removal are deleted from the plot
        delete(app.ET_UIAxes.Children(find(ismember(get(findobj(app.ET_UIAxes,'type','ConstantLine'),'Label'),string(app.rmv_tags{app.e,1})))));

    end

end