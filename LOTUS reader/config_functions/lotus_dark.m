%% LOTUS Reader Dark Mode
%  Copyright (C) (2024) Jack Fogarty

function lotus_dark(app)

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

    if app.DarkSwitch.Value == '1'

    % Set dark mode colours
    Shade1 = [0.00,0.27,0.33];
    Shade2 = [0.47,0.59,0.62];
    Shade3 = [0.79,0.89,0.91];
    Text1  = [0.94,0.94,0.94]; % General light text
    
    % Drop down and pad highlights
    app.ReadMethodDropDown.BackgroundColor  = Shade3;
    app.TimeZoneDropDown.BackgroundColor    = Shade3;
    app.StartDateDatePicker.BackgroundColor = Shade3;
    app.EndDateDatePicker.BackgroundColor   = Shade3;
    app.StartHour.BackgroundColor           = Shade3;
    app.StartMin.BackgroundColor            = Shade3;
    app.StartSec.BackgroundColor            = Shade3;
    app.EndHour.BackgroundColor             = Shade3;
    app.EndMin.BackgroundColor              = Shade3;
    app.EndSec.BackgroundColor              = Shade3;
    app.YearSpinner.BackgroundColor         = Shade3;
    app.MonthSpinner.BackgroundColor        = Shade3;
    app.DaySpinner.BackgroundColor          = Shade3;
    app.SubjectListBox.BackgroundColor      = Shade3;

    % Special textual changes
    app.AppTitle.FontColor               = [0.15,0.15,0.15];
    app.AuthorLabel.FontColor            = [0.64,0.08,0.18];
    app.DarkLabel.FontColor              = [0.00,0.00,0.00];
    app.CoolLabel.FontColor              = [0.00,0.00,0.00];
    app.SelectDataLabel.FontColor        = [0.93,0.69,0.13];
    app.InputLabel.FontColor             = [0.00,0.92,0.37];
    app.SelectSubjectsLabel.FontColor    = [0.93,0.69,0.13];
    app.SubjectListBox.FontColor         = [0.00,0.00,0.00];
    app.DateRangeInstructions.FontColor  = [0.00,0.00,0.00];
    app.TimeWindowInstructions.FontColor = [0.00,0.00,0.00];
    app.TimeSpanInstructions.FontColor   = [0.00,0.00,0.00];
    
    % Generic textual changes
    app.BrowseLabel.FontColor                 = Text1;
    app.CSVButton.FontColor                   = Text1;
    app.AvroButton.FontColor                  = Text1;
    app.EDACheck.FontColor                    = Text1;
    app.BVPCheck.FontColor                    = Text1;
    app.SystPCheck.FontColor                  = Text1;
    app.TempCheck.FontColor                   = Text1;
    app.ACCCheck.FontColor                    = Text1;
    app.GYRCheck.FontColor                    = Text1;
    app.StepsCheck.FontColor                  = Text1;
    app.OtherCheck.FontColor                  = Text1;
    app.SummaryCheck.FontColor                = Text1;
    app.TimeOverlapCheckBox.FontColor         = Text1;
    app.NaNpadCheckBox.FontColor              = Text1;
    app.NaNpadmax.FontColor                   = Text1;
    app.ReadMethodDropDownLabel.FontColor     = Text1;
    app.TimeZoneofDataDropDownLabel.FontColor = Text1;

    % Function panels
    app.AppTitle.BackgroundColor              = Shade2;
    app.FilterDateRangePanel.BackgroundColor  = Shade2;
    app.TimeWindowPanel.BackgroundColor       = Shade2;
    app.TimespanPanel.BackgroundColor         = Shade2;

    % Back panels
    app.LOTUS_readerUIFigure.Color   = Shade1;
    app.GridLayout.BackgroundColor   = Shade1;
    app.InputButton.BackgroundColor  = Shade1;
    app.DataPanel.BackgroundColor    = Shade1;

    else
    
    % Set default (light) mode colours
    Shade1 = [0.94,0.94,0.94];
    Shade2 = [0.80,0.80,0.80];
    Shade3 = [0.90,0.90,0.90];
    Shade4 = [0.96,0.96,0.96];
    Shade5 = [1.00,1.00,1.00];
    Text1  = [0.00,0.00,0.00]; % General light text

    % Drop down and pad highlights
    app.ReadMethodDropDown.BackgroundColor  = Shade4;
    app.TimeZoneDropDown.BackgroundColor    = Shade4;
    app.StartDateDatePicker.BackgroundColor = Shade5;
    app.EndDateDatePicker.BackgroundColor   = Shade5;
    app.StartHour.BackgroundColor           = Shade5;
    app.StartMin.BackgroundColor            = Shade5;
    app.StartSec.BackgroundColor            = Shade5;
    app.EndHour.BackgroundColor             = Shade5;
    app.EndMin.BackgroundColor              = Shade5;
    app.EndSec.BackgroundColor              = Shade5;
    app.YearSpinner.BackgroundColor         = Shade5;
    app.MonthSpinner.BackgroundColor        = Shade5;
    app.DaySpinner.BackgroundColor          = Shade5;
    app.SubjectListBox.BackgroundColor      = Shade5;

    % Special textual changes
    app.AppTitle.FontColor               = [0.00,0.00,1.00];
    app.AuthorLabel.FontColor            = [0.00,0.00,0.00];
    app.DarkLabel.FontColor              = [0.50,0.50,0.50];
    app.CoolLabel.FontColor              = [0.50,0.50,0.50];
    app.SelectDataLabel.FontColor        = [1.00,0.00,0.00];
    app.InputLabel.FontColor             = [0.00,0.00,0.00];
    app.SelectSubjectsLabel.FontColor    = [0.00,0.00,0.00];
    app.SubjectListBox.FontColor         = [0.64,0.08,0.18];
    app.DateRangeInstructions.FontColor  = [0.00,0.00,1.00];
    app.TimeWindowInstructions.FontColor = [0.00,0.00,1.00];
    app.TimeSpanInstructions.FontColor   = [0.00,0.00,1.00];
    
    % Generic textual changes
    app.BrowseLabel.FontColor                 = Text1;
    app.CSVButton.FontColor                   = Text1;
    app.AvroButton.FontColor                  = Text1;
    app.EDACheck.FontColor                    = Text1;
    app.BVPCheck.FontColor                    = Text1;
    app.SystPCheck.FontColor                  = Text1;
    app.TempCheck.FontColor                   = Text1;
    app.ACCCheck.FontColor                    = Text1;
    app.GYRCheck.FontColor                    = Text1;
    app.StepsCheck.FontColor                  = Text1;
    app.OtherCheck.FontColor                  = Text1;
    app.SummaryCheck.FontColor                = Text1;
    app.TimeOverlapCheckBox.FontColor         = Text1;
    app.NaNpadCheckBox.FontColor              = Text1;
    app.NaNpadmax.FontColor                   = Text1;
    app.ReadMethodDropDownLabel.FontColor     = Text1;
    app.TimeZoneofDataDropDownLabel.FontColor = Text1;

    % Function panels
    app.AppTitle.BackgroundColor              = Shade2;
    app.FilterDateRangePanel.BackgroundColor  = Shade3;
    app.TimeWindowPanel.BackgroundColor       = Shade3;
    app.TimespanPanel.BackgroundColor         = Shade3;

    % Back panels
    app.LOTUS_readerUIFigure.Color   = Shade1;
    app.GridLayout.BackgroundColor   = Shade1;
    app.InputButton.BackgroundColor  = Shade1;
    app.DataPanel.BackgroundColor    = Shade1;
    
    end
end



