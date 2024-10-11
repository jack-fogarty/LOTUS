%% LOTUS: Update the Tag List Box
%  Copyright (C) (2024) Jack Fogarty

function ep_update_tag_listbox(app,event)

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

        % Get Tag numbers        
        for t = 1:height(app.dat.Tags{app.e})
            labels{t} = ['Tag ' num2str(t)];
        end
        
        % Update list. If no tags then leave the list empty.
        if isempty(t)
            app.ET_TagListBox.Items = {};
        else
            % Update listbox
            app.ET_TagListBox.Items = labels;
        end       
        
end
