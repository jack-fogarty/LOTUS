%% LOTUS: Update and Format Event Table
%  Copyright (C) (2024) Jack Fogarty

function ep_format_table(app,event)

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

            
    if isempty(event) || strcmp(event,{'reset'})
        
        % Format table based on input data
        app.ET_UITable.Data = app.dat.Tags{app.e,1};
        app.ET_TotalTagsLabel.Text = ['Total Tags: ' num2str(height(app.ET_UITable.Data))];
        
        % Table styles
        removeStyle(app.ET_UITable);
        s = uistyle('HorizontalAlignment','center');
        addStyle(app.ET_UITable,s);
        app.styles{app.e,1} =  app.ET_UITable.StyleConfigurations;
        
    else
        
        % Format table based on tag history when stepping between files
        app.ET_UITable.Data = app.dat.Tags{app.e,1};
        app.ET_TotalTagsLabel.Text = ['Total Tags: ' num2str(height(app.ET_UITable.Data))];
        
        % Remove all styles first
        removeStyle(app.ET_UITable);
        s = uistyle('HorizontalAlignment','center');
        addStyle(app.ET_UITable,s);
        
        % Add historic styles marking deletion
        try
            for i = 2:height(app.styles{app.e,1})
                addStyle(app.ET_UITable,app.styles{app.e,1}.Style(i),"row",app.styles{app.e,1}.TargetIndex{i});
            end
        end
        
    end
    
end