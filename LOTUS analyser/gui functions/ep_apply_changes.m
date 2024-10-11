%% LOTUS: Apply Changes to Events (Tags)
%  Copyright (C) (2024) Jack Fogarty

function ep_apply_changes(app,event,updategui)

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

            
    % Remove any tags marked for deletion and update gui if needed
    
        % Store deleted tags for reference
        app.deleted_tags{app.e,1} = [app.deleted_tags{app.e,1}; app.dat.Tags{app.e}(app.rmv_tags{app.e,1},:)];
        
        % Update the current tag data
        app.dat.Tags{app.e}(app.rmv_tags{app.e,1},:) = [];
        
        % Update styles list for event table
        app.styles{app.e,1}([2:height(app.styles{app.e,1})],:) = [];
        
        % Sort new and updated tags and refresh table
        app.dat.Tags{app.e} = sortrows(app.dat.Tags{app.e},{'UTC_FileTime','TZ_TagTime'}); % Sort table order
        app.dat.Tags{app.e}.Tag = [1:height(app.dat.Tags{app.e})]'; % Update tag numbers in table
        
        % Purge temporary variable rmv_tags
        app.rmv_tags{app.e,1} = [];
        
        % Update current GUI components
        if updategui
            ep_update_gui(app,event);
        end
    
end