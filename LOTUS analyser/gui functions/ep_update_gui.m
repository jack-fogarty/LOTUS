%% LOTUS: Coordinate Updates to the Main GUI
%  Copyright (C) (2024) Jack Fogarty

function ep_update_gui(app,event)

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


    % Reset tags if flagged
    if ~isempty(event) && any(strcmp(event,{'load_new','reset'}))
        
        if isempty(app.original_dat.Tags)
            app.original_dat.Tags = ep_fix_empty_tags(app.cfg);
        end
        app.dat.Tags{app.e,1} = app.original_dat.Tags{app.e,1}; % Create copy of input tags
        app.rmv_tags{app.e,1} = [];

        % Ensure that epochs and preprocessing is cleared when loading new
        app.res      = [];
        app.det      = [];
        app.fil      = [];
        app.art      = [];
        app.rej      = [];
        app.int      = [];
        app.Tra      = [];
        app.epoch    = [];
        app.rtn      =  0;
        app.ep_list          = {'Input Data'};
        app.art_list         = {'Input Data'};
        app.PT_ListBox.Items = {'Input Data'};
        app.PT_ListBox.ValueIndex = 1;

        % Reset Tag Edits
        app.ET_NewTagH.Value  = 0;
        app.ET_NewTagM.Value  = 0;
        app.ET_NewTagS.Value  = 0;
        app.ET_NewTagms.Value = 0;

    end
    
    % Tag and table data
    ep_format_table(app,event);
    
    % Date pickers (Default value first day of recording)
    app.ET_DatePicker.Value   = app.cfg.selected_days(app.e);
    app.ETP_ep_datepick.Value = app.cfg.selected_days(app.e);
    
    % Signal options
    app.ET_SignalDropDown.Items = app.signals;  
    
    % Tag list box
    ep_update_tag_listbox(app,event);
    
    % File Field
    app.ET_filen.Value = app.e;
    
    % Plot data
    if ~isempty(app.signals)

       % Update the LOTUS plot
       ep_updateplot(app,event);

       % Enable buttons if there is signal data
       app.ET_BigStepUp.Enable      = 1;
       app.ET_BigStepDwn.Enable     = 1;
       app.ET_SmallStepUp.Enable    = 1;
       app.ET_SmallStepDwn.Enable   = 1;
       app.ET_YUp.Enable            = 1;
       app.ET_YDwn.Enable           = 1;
       app.ET_SignalDropDown.Enable = 1;

    else
       
       % Clear plot data
       delete(app.ET_UIAxes.Children);
       
       % Disable irrelevant buttons if there is no signal data
       app.ET_BigStepUp.Enable      = 0;
       app.ET_BigStepDwn.Enable     = 0;
       app.ET_SmallStepUp.Enable    = 0;
       app.ET_SmallStepDwn.Enable   = 0;
       app.ET_YUp.Enable            = 0;
       app.ET_YDwn.Enable           = 0;
       app.ET_SignalDropDown.Enable = 0;

    end
    
    % Remove event
    event = [];
    
end