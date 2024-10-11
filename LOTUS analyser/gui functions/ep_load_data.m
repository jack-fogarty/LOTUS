%% LOTUS: Load Data into Analyser
%  Copyright (C) (2024) Jack Fogarty

function ep_load_data(app)

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


    % Load data into app variables
    load([app.filepath app.file{1,app.f}]);
    app.original_cfg  = cfg;
    app.original_dat  = dat;
    app.cfg           = cfg;
    app.dat           = dat;
                
    % Identify file/epoch list size
    tmp = fieldnames(app.dat);
    app.signals = tmp(~structfun(@isempty,app.dat) & ~strcmp(tmp,'Tags') & ~strcmp(tmp,'Summary') & ~strcmp(tmp,'deleted_Tags'));
    
    if ~isempty(app.signals)
        app.fav          = eval(['size(app.dat.' app.signals{1} ',1)']);
        app.rmv_tags     = cell(app.fav,1);
        app.deleted_tags = cell(app.fav,1);
    else
        app.fav = size(app.dat.Tags,1);
        app.rmv_tags     = cell(app.fav,1);
        app.deleted_tags = cell(app.fav,1);
    end
    clear cfg dat
    
    % Create basic style for tables
    s = uistyle('HorizontalAlignment','center');
    addStyle(app.ET_UITable,s);
    app.styles = repmat({app.ET_UITable.StyleConfigurations},app.fav,1);
    
end