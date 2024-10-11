classdef LOTUS_reader < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        LOTUS_readerUIFigure         matlab.ui.Figure
        loadus                       matlab.ui.control.Image
        AuthorLabel                  matlab.ui.control.Label
        DateRangeInstructions        matlab.ui.control.Label
        SubjectListBox               matlab.ui.control.ListBox
        CoolLabel                    matlab.ui.control.Label
        DarkLabel                    matlab.ui.control.Label
        CoolSwitch                   matlab.ui.control.Switch
        InputLabel                   matlab.ui.control.Label
        InputButton                  matlab.ui.container.ButtonGroup
        CSVButton                    matlab.ui.control.RadioButton
        AvroButton                   matlab.ui.control.RadioButton
        SelectDataLabel              matlab.ui.control.Label
        SelectSubjectsLabel          matlab.ui.control.Label
        DarkSwitch                   matlab.ui.control.Switch
        AnalyserButton               matlab.ui.control.Button
        FilterDateRangePanel         matlab.ui.container.Panel
        EndDateDatePicker            matlab.ui.control.DatePicker
        EndDateDatePickerLabel       matlab.ui.control.Label
        StartDateDatePicker          matlab.ui.control.DatePicker
        StartDateDatePickerLabel     matlab.ui.control.Label
        TimeZoneofDataDropDownLabel  matlab.ui.control.Label
        TimeZoneDropDown             matlab.ui.control.DropDown
        TimeOverlapCheckBox          matlab.ui.control.CheckBox
        NaNpadCheckBox               matlab.ui.control.CheckBox
        NaNpadmax                    matlab.ui.control.CheckBox
        TimespanPanel                matlab.ui.container.Panel
        TimeSpanInstructions         matlab.ui.control.Label
        TimespanLabel                matlab.ui.control.Label
        DaysLabel                    matlab.ui.control.Label
        DaySpinner                   matlab.ui.control.Spinner
        MonthsLabel                  matlab.ui.control.Label
        MonthSpinner                 matlab.ui.control.Spinner
        YearsLabel                   matlab.ui.control.Label
        YearSpinner                  matlab.ui.control.Spinner
        TimeWindowInstructions       matlab.ui.control.Label
        BrowseLabel_3                matlab.ui.control.Label
        ReadMethodDropDownLabel      matlab.ui.control.Label
        ReadMethodDropDown           matlab.ui.control.DropDown
        AppTitle                     matlab.ui.control.Label
        SaveButton                   matlab.ui.control.Button
        BrowseButton                 matlab.ui.control.Button
        ReadButton                   matlab.ui.control.Button
        BrowseLabel                  matlab.ui.control.Label
        DataPanel                    matlab.ui.container.Panel
        GridLayout                   matlab.ui.container.GridLayout
        SummaryCheck                 matlab.ui.control.CheckBox
        OtherCheck                   matlab.ui.control.CheckBox
        EDACheck                     matlab.ui.control.CheckBox
        BVPCheck                     matlab.ui.control.CheckBox
        SystPCheck                   matlab.ui.control.CheckBox
        TempCheck                    matlab.ui.control.CheckBox
        ACCCheck                     matlab.ui.control.CheckBox
        GYRCheck                     matlab.ui.control.CheckBox
        StepsCheck                   matlab.ui.control.CheckBox
        TimeWindowPanel              matlab.ui.container.Panel
        Label_1                      matlab.ui.control.Label
        Label_2                      matlab.ui.control.Label
        Label_3                      matlab.ui.control.Label
        Label_4                      matlab.ui.control.Label
        StartHour                    matlab.ui.control.Spinner
        StartMin                     matlab.ui.control.Spinner
        StartSec                     matlab.ui.control.Spinner
        EndHour                      matlab.ui.control.Spinner
        EndMin                       matlab.ui.control.Spinner
        EndSec                       matlab.ui.control.Spinner
        StartTimeLabel               matlab.ui.control.Label
        EndTimeLabel                 matlab.ui.control.Label
        HourLabel                    matlab.ui.control.Label
        MinLabel                     matlab.ui.control.Label
        SecLabel                     matlab.ui.control.Label
        JBYEAH                       matlab.ui.control.Image
        SBYEAH                       matlab.ui.control.Image
        FIRE                         matlab.ui.control.Image
    end

    
    properties (Access = private)
        stop          % Marker to help 'break' GUI operation
        y             % Music
        Fs            % Music Fs
        lpath         % Path to LOTUS app
    end
    
    properties (Access = public)
        cfg % Configuration variable holding key parameter values
    end
           
    methods (Access = private)
        
        
        function update_cfg(app)
                       
            % Input type
            if app.CSVButton.Value
               app.cfg.InputType = '.csv';
            else
               app.cfg.InputType = '.avro';
            end
            
            % Selected data types for importation and processing
            app.cfg.DataType.EDA     = app.EDACheck.Value;
            app.cfg.DataType.BVP     = app.BVPCheck.Value;
            app.cfg.DataType.SystP   = app.SystPCheck.Value;
            app.cfg.DataType.Temp    = app.TempCheck.Value;
            app.cfg.DataType.ACC     = app.ACCCheck.Value;
            app.cfg.DataType.GYR     = app.GYRCheck.Value;
            app.cfg.DataType.Steps   = app.StepsCheck.Value;
            app.cfg.DataType.Other   = app.OtherCheck.Value;
            app.cfg.DataType.Summary = app.SummaryCheck.Value;
            
            % Read data method
            app.cfg.ReadMethod = app.ReadMethodDropDown.Value;
            
            % Time zone of data
            app.cfg.TimeZone   = app.TimeZoneDropDown.Value;
            
            % Selected date range
            app.cfg.Sdate = app.StartDateDatePicker.Value; % Selected start date
            app.cfg.Edate = app.EndDateDatePicker.Value;   % Selected end date
            
            % Start time parameters
            app.cfg.Stime.H  = app.StartHour.Value; % Start time (Hour)
            app.cfg.Stime.M  = app.StartMin.Value;  % Start time (Minute)
            app.cfg.Stime.S  = app.StartSec.Value;  % Start time (Second)
            
            % End time parameters
            app.cfg.Etime.H  = app.EndHour.Value; % End time (Hour)
            app.cfg.Etime.M  = app.EndMin.Value;  % End time (Minute)
            app.cfg.Etime.S  = app.EndSec.Value;  % End time (Second)
            
            % Timespan
            app.cfg.Tspan.Y  = app.YearSpinner.Value;  % Span between start and end time (in Years)
            app.cfg.Tspan.M  = app.MonthSpinner.Value; % Span between start and end time (in Months)
            app.cfg.Tspan.D  = app.DaySpinner.Value;   % Span between start and end time (in Days)
            
            % Selected subjects and days for output
            app.cfg.selected_days = datetime(NaT,'TimeZone',app.cfg.TimeZone);
            if strcmp(app.SubjectListBox.Value,'Select All')
                 app.cfg.selected_subjects = app.cfg.subjects;  
            else
                 app.cfg.selected_subjects = app.SubjectListBox.Value; 
            end
            
            % Allow epochs to overlap?
            app.cfg.overlap  = app.TimeOverlapCheckBox.Value;
            
            % NaN pad discontinuities (missing pts) when generating epochs?
            app.cfg.padding  = app.NaNpadCheckBox.Value;
            
            % NaN pad to max window length?
            app.cfg.padmax   = app.NaNpadmax.Value;
            
        end
        
    end
        

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
            % Position GUI in center screen
            movegui(app.LOTUS_readerUIFigure,'center')
            
            % Load possible timezones (clean this list for greater ease of selection)
            t = timezones('All');
            app.TimeZoneDropDown.Items = sort(t.Name);
            app.TimeZoneDropDown.Value = 'Asia/Singapore'; % Default
            
            % Load cool times
            [app.y, app.Fs] = audioread('Working Class man.mp3');

        end

        % Value changed function: DarkSwitch
        function DarkSwitchValueChanged(app, event)
            
            % Call external function for color mapping 
            lotus_dark(app);
            
        end

        % Value changed function: CoolSwitch
        function CoolSwitchValueChanged(app, event)
            
            if str2double(app.CoolSwitch.Value) == 1
               app.FIRE.Visible   = 1;
               app.JBYEAH.Visible = 1;
               app.SBYEAH.Visible = 1;
               
               % You're a working class man, man
               sound(app.y, app.Fs);

            else
               app.FIRE.Visible   = 0;
               app.JBYEAH.Visible = 0;
               app.SBYEAH.Visible = 0;
               clear sound
            end
            
        end

        % Value changed function: SubjectListBox
        function SubjectListBoxValueChanged(app, event)
            
            if strcmp(app.SubjectListBox.Value,'Select All')
                 app.cfg.selected_subjects = app.cfg.subjects;  
            else
                 app.cfg.selected_subjects = app.SubjectListBox.Value; 
            end
            
        end

        % Button pushed function: BrowseButton
        function BrowseButtonPushed(app, event)
            
            % Browse to parent folder (subfolders should be dates)
            app.cfg.parent_folder = uigetdir;
            figure(app.LOTUS_readerUIFigure)
            
        end

        % Button pushed function: ReadButton
        function ReadButtonPushed(app, event)
            
            if ~isempty(app.cfg.parent_folder) || app.cfg.parent_folder ~= 0
               
               % Update GUI configurations
               update_cfg(app)
                
               % Read and prime data for output
               app.cfg = ep_read_data(app.cfg);
               
               % Update the subject list for the selected date range (add option 'all')
               if isempty(app.cfg.subjects)
                   app.SubjectListBox.Items = {'-no subjects-'};
               else
                   app.SubjectListBox.Items  = [{'Select All'}; app.cfg.subjects];
                   app.SubjectListBox.Value  = 'Select All';
                   app.cfg.selected_subjects = app.cfg.subjects;
               end
               
            else
               % No path is specified. User needs to browse to parent folder
               uialert(app.LOTUS_readerUIFigure,'No path is specified. User needs to first browse to the parent folder that contains the raw avro or csv data sorted by date.','Warning')
            end
            figure(app.LOTUS_readerUIFigure)
            
        end

        % Button pushed function: SaveButton
        function SaveButtonPushed(app, event)
            
            % If you're a working class man, man
            % clear sound
            
            % Update GUI configurations
            update_cfg(app)
            
            % Epoch and output the data
            if      app.AvroButton.Value
                    ep_import_data_avro(app);
            elseif  app.CSVButton.Value
                    ep_import_data(app);      
            end
            
        end

        % Button pushed function: AnalyserButton
        function AnalyserButtonPushed(app, event)
            
            LOTUS_analyser;

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create LOTUS_readerUIFigure and hide until all components are created
            app.LOTUS_readerUIFigure = uifigure('Visible', 'off');
            app.LOTUS_readerUIFigure.Color = [0.9412 0.9412 0.9412];
            app.LOTUS_readerUIFigure.Position = [100 100 614 513];
            app.LOTUS_readerUIFigure.Name = 'LOTUS_reader';
            app.LOTUS_readerUIFigure.Resize = 'off';
            app.LOTUS_readerUIFigure.Tag = 'LOTUS_reader';

            % Create FIRE
            app.FIRE = uiimage(app.LOTUS_readerUIFigure);
            app.FIRE.Visible = 'off';
            app.FIRE.Position = [1 -2 614 64];
            app.FIRE.ImageSource = fullfile(pathToMLAPP, 'images', 'long_fire.png');

            % Create SBYEAH
            app.SBYEAH = uiimage(app.LOTUS_readerUIFigure);
            app.SBYEAH.ScaleMethod = 'fill';
            app.SBYEAH.Visible = 'off';
            app.SBYEAH.Position = [119 -11 112 97];
            app.SBYEAH.ImageSource = fullfile(pathToMLAPP, 'images', 'spbobrock_reverse.png');

            % Create JBYEAH
            app.JBYEAH = uiimage(app.LOTUS_readerUIFigure);
            app.JBYEAH.Visible = 'off';
            app.JBYEAH.Position = [-2 1 70 71];
            app.JBYEAH.ImageSource = fullfile(pathToMLAPP, 'images', 'screaming_cowboy.png');

            % Create TimeWindowPanel
            app.TimeWindowPanel = uipanel(app.LOTUS_readerUIFigure);
            app.TimeWindowPanel.Title = 'Time Window';
            app.TimeWindowPanel.BackgroundColor = [0.902 0.902 0.902];
            app.TimeWindowPanel.FontWeight = 'bold';
            app.TimeWindowPanel.Position = [223 157 279 138];

            % Create SecLabel
            app.SecLabel = uilabel(app.TimeWindowPanel);
            app.SecLabel.HorizontalAlignment = 'center';
            app.SecLabel.FontAngle = 'italic';
            app.SecLabel.Position = [222 67 26 22];
            app.SecLabel.Text = 'Sec';

            % Create MinLabel
            app.MinLabel = uilabel(app.TimeWindowPanel);
            app.MinLabel.HorizontalAlignment = 'center';
            app.MinLabel.FontAngle = 'italic';
            app.MinLabel.Position = [158 67 25 22];
            app.MinLabel.Text = 'Min';

            % Create HourLabel
            app.HourLabel = uilabel(app.TimeWindowPanel);
            app.HourLabel.HorizontalAlignment = 'center';
            app.HourLabel.FontAngle = 'italic';
            app.HourLabel.Position = [93 67 32 22];
            app.HourLabel.Text = 'Hour';

            % Create EndTimeLabel
            app.EndTimeLabel = uilabel(app.TimeWindowPanel);
            app.EndTimeLabel.Position = [27 11 56 22];
            app.EndTimeLabel.Text = 'End Time';

            % Create StartTimeLabel
            app.StartTimeLabel = uilabel(app.TimeWindowPanel);
            app.StartTimeLabel.Position = [23 45 60 22];
            app.StartTimeLabel.Text = 'Start Time';

            % Create EndSec
            app.EndSec = uispinner(app.TimeWindowPanel);
            app.EndSec.Position = [211 9 49 27];

            % Create EndMin
            app.EndMin = uispinner(app.TimeWindowPanel);
            app.EndMin.Position = [146 9 49 27];

            % Create EndHour
            app.EndHour = uispinner(app.TimeWindowPanel);
            app.EndHour.Position = [84 9 49 27];

            % Create StartSec
            app.StartSec = uispinner(app.TimeWindowPanel);
            app.StartSec.Position = [211 42 49 27];

            % Create StartMin
            app.StartMin = uispinner(app.TimeWindowPanel);
            app.StartMin.Position = [146 42 49 27];

            % Create StartHour
            app.StartHour = uispinner(app.TimeWindowPanel);
            app.StartHour.Position = [84 42 49 27];

            % Create Label_4
            app.Label_4 = uilabel(app.TimeWindowPanel);
            app.Label_4.HorizontalAlignment = 'center';
            app.Label_4.FontWeight = 'bold';
            app.Label_4.Position = [190 44 25 22];
            app.Label_4.Text = ':';

            % Create Label_3
            app.Label_3 = uilabel(app.TimeWindowPanel);
            app.Label_3.HorizontalAlignment = 'center';
            app.Label_3.FontWeight = 'bold';
            app.Label_3.Position = [190 10 25 22];
            app.Label_3.Text = ':';

            % Create Label_2
            app.Label_2 = uilabel(app.TimeWindowPanel);
            app.Label_2.HorizontalAlignment = 'center';
            app.Label_2.FontWeight = 'bold';
            app.Label_2.Position = [126 11 25 22];
            app.Label_2.Text = ':';

            % Create Label_1
            app.Label_1 = uilabel(app.TimeWindowPanel);
            app.Label_1.HorizontalAlignment = 'center';
            app.Label_1.FontWeight = 'bold';
            app.Label_1.Position = [126 45 25 22];
            app.Label_1.Text = ':';

            % Create DataPanel
            app.DataPanel = uipanel(app.LOTUS_readerUIFigure);
            app.DataPanel.ForegroundColor = [1 0 0];
            app.DataPanel.BorderType = 'none';
            app.DataPanel.Title = ' ';
            app.DataPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.DataPanel.Position = [7 342 601 64];

            % Create GridLayout
            app.GridLayout = uigridlayout(app.DataPanel);
            app.GridLayout.ColumnWidth = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', 'fit'};
            app.GridLayout.RowHeight = {31.98};
            app.GridLayout.Padding = [10 7.20416259765625 10 7.20416259765625];

            % Create StepsCheck
            app.StepsCheck = uicheckbox(app.GridLayout);
            app.StepsCheck.Text = 'Steps';
            app.StepsCheck.Layout.Row = 1;
            app.StepsCheck.Layout.Column = 7;

            % Create GYRCheck
            app.GYRCheck = uicheckbox(app.GridLayout);
            app.GYRCheck.Text = 'GYR';
            app.GYRCheck.Layout.Row = 1;
            app.GYRCheck.Layout.Column = 6;

            % Create ACCCheck
            app.ACCCheck = uicheckbox(app.GridLayout);
            app.ACCCheck.Text = 'ACC';
            app.ACCCheck.Layout.Row = 1;
            app.ACCCheck.Layout.Column = 5;

            % Create TempCheck
            app.TempCheck = uicheckbox(app.GridLayout);
            app.TempCheck.Text = 'Temp';
            app.TempCheck.Layout.Row = 1;
            app.TempCheck.Layout.Column = 4;

            % Create SystPCheck
            app.SystPCheck = uicheckbox(app.GridLayout);
            app.SystPCheck.Text = 'SystP';
            app.SystPCheck.Layout.Row = 1;
            app.SystPCheck.Layout.Column = 3;

            % Create BVPCheck
            app.BVPCheck = uicheckbox(app.GridLayout);
            app.BVPCheck.Text = 'BVP';
            app.BVPCheck.Layout.Row = 1;
            app.BVPCheck.Layout.Column = 2;

            % Create EDACheck
            app.EDACheck = uicheckbox(app.GridLayout);
            app.EDACheck.Text = 'EDA';
            app.EDACheck.Layout.Row = 1;
            app.EDACheck.Layout.Column = 1;

            % Create OtherCheck
            app.OtherCheck = uicheckbox(app.GridLayout);
            app.OtherCheck.Text = 'Other';
            app.OtherCheck.Layout.Row = 1;
            app.OtherCheck.Layout.Column = 8;

            % Create SummaryCheck
            app.SummaryCheck = uicheckbox(app.GridLayout);
            app.SummaryCheck.Text = 'Summary';
            app.SummaryCheck.Layout.Row = 1;
            app.SummaryCheck.Layout.Column = 9;

            % Create BrowseLabel
            app.BrowseLabel = uilabel(app.LOTUS_readerUIFigure);
            app.BrowseLabel.Position = [9 416 551 22];
            app.BrowseLabel.Text = 'Browse, select, load, and compile EmbracePlus or other timeseries data for processing and analysis.';

            % Create ReadButton
            app.ReadButton = uibutton(app.LOTUS_readerUIFigure, 'push');
            app.ReadButton.ButtonPushedFcn = createCallbackFcn(app, @ReadButtonPushed, true);
            app.ReadButton.BackgroundColor = [0 1 1];
            app.ReadButton.Position = [518 80 80 22];
            app.ReadButton.Text = 'Read';

            % Create BrowseButton
            app.BrowseButton = uibutton(app.LOTUS_readerUIFigure, 'push');
            app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseButtonPushed, true);
            app.BrowseButton.BackgroundColor = [1 1 1];
            app.BrowseButton.Position = [518 110 80 22];
            app.BrowseButton.Text = 'Browse';

            % Create SaveButton
            app.SaveButton = uibutton(app.LOTUS_readerUIFigure, 'push');
            app.SaveButton.ButtonPushedFcn = createCallbackFcn(app, @SaveButtonPushed, true);
            app.SaveButton.BackgroundColor = [0 1 0];
            app.SaveButton.Position = [518 49 80 22];
            app.SaveButton.Text = 'Save';

            % Create AppTitle
            app.AppTitle = uilabel(app.LOTUS_readerUIFigure);
            app.AppTitle.BackgroundColor = [0.8 0.8 0.8];
            app.AppTitle.FontSize = 22;
            app.AppTitle.FontWeight = 'bold';
            app.AppTitle.FontColor = [0 0 1];
            app.AppTitle.Position = [9 450 599 58];
            app.AppTitle.Text = {' LOTUS Reader'; ' '};

            % Create ReadMethodDropDown
            app.ReadMethodDropDown = uidropdown(app.LOTUS_readerUIFigure);
            app.ReadMethodDropDown.Items = {'Default', 'Custom', 'Event-based'};
            app.ReadMethodDropDown.Position = [107 307 103 22];
            app.ReadMethodDropDown.Value = 'Default';

            % Create ReadMethodDropDownLabel
            app.ReadMethodDropDownLabel = uilabel(app.LOTUS_readerUIFigure);
            app.ReadMethodDropDownLabel.HorizontalAlignment = 'right';
            app.ReadMethodDropDownLabel.FontWeight = 'bold';
            app.ReadMethodDropDownLabel.Position = [21 307 81 22];
            app.ReadMethodDropDownLabel.Text = 'Read Method';

            % Create BrowseLabel_3
            app.BrowseLabel_3 = uilabel(app.LOTUS_readerUIFigure);
            app.BrowseLabel_3.WordWrap = 'on';
            app.BrowseLabel_3.FontAngle = 'italic';
            app.BrowseLabel_3.FontColor = [0 0 1];
            app.BrowseLabel_3.Position = [20 233 177 38];
            app.BrowseLabel_3.Text = 'Start and end dates are included in data importation.';

            % Create TimeWindowInstructions
            app.TimeWindowInstructions = uilabel(app.LOTUS_readerUIFigure);
            app.TimeWindowInstructions.FontAngle = 'italic';
            app.TimeWindowInstructions.FontColor = [0 0 1];
            app.TimeWindowInstructions.Position = [234 248 268 22];
            app.TimeWindowInstructions.Text = 'Select epoch times in 24h format (e.g., 13:35:00)';

            % Create TimespanPanel
            app.TimespanPanel = uipanel(app.LOTUS_readerUIFigure);
            app.TimespanPanel.Title = 'Timespan';
            app.TimespanPanel.BackgroundColor = [0.902 0.902 0.902];
            app.TimespanPanel.FontWeight = 'bold';
            app.TimespanPanel.Position = [223 17 279 126];

            % Create YearSpinner
            app.YearSpinner = uispinner(app.TimespanPanel);
            app.YearSpinner.Position = [84 15 49 27];

            % Create YearsLabel
            app.YearsLabel = uilabel(app.TimespanPanel);
            app.YearsLabel.HorizontalAlignment = 'center';
            app.YearsLabel.FontAngle = 'italic';
            app.YearsLabel.Position = [89 40 36 22];
            app.YearsLabel.Text = 'Years';

            % Create MonthSpinner
            app.MonthSpinner = uispinner(app.TimespanPanel);
            app.MonthSpinner.Position = [146 15 49 27];

            % Create MonthsLabel
            app.MonthsLabel = uilabel(app.TimespanPanel);
            app.MonthsLabel.HorizontalAlignment = 'center';
            app.MonthsLabel.FontAngle = 'italic';
            app.MonthsLabel.Position = [148 40 45 22];
            app.MonthsLabel.Text = 'Months';

            % Create DaySpinner
            app.DaySpinner = uispinner(app.TimespanPanel);
            app.DaySpinner.Position = [211 15 49 27];

            % Create DaysLabel
            app.DaysLabel = uilabel(app.TimespanPanel);
            app.DaysLabel.HorizontalAlignment = 'center';
            app.DaysLabel.FontAngle = 'italic';
            app.DaysLabel.Position = [218 40 33 22];
            app.DaysLabel.Text = 'Days';

            % Create TimespanLabel
            app.TimespanLabel = uilabel(app.TimespanPanel);
            app.TimespanLabel.HorizontalAlignment = 'right';
            app.TimespanLabel.Position = [19 17 58 22];
            app.TimespanLabel.Text = 'Timespan';

            % Create TimeSpanInstructions
            app.TimeSpanInstructions = uilabel(app.TimespanPanel);
            app.TimeSpanInstructions.WordWrap = 'on';
            app.TimeSpanInstructions.FontAngle = 'italic';
            app.TimeSpanInstructions.FontColor = [0 0 1];
            app.TimeSpanInstructions.Position = [9 66 267 31];
            app.TimeSpanInstructions.Text = 'Set the period between start and end timepoints (for day, 0 < 24h)';

            % Create NaNpadmax
            app.NaNpadmax = uicheckbox(app.LOTUS_readerUIFigure);
            app.NaNpadmax.Text = 'NaN pad to max window length';
            app.NaNpadmax.Position = [13 74 188 22];

            % Create NaNpadCheckBox
            app.NaNpadCheckBox = uicheckbox(app.LOTUS_readerUIFigure);
            app.NaNpadCheckBox.Text = 'NaN pad discontinuities';
            app.NaNpadCheckBox.Position = [13 98 148 22];
            app.NaNpadCheckBox.Value = true;

            % Create TimeOverlapCheckBox
            app.TimeOverlapCheckBox = uicheckbox(app.LOTUS_readerUIFigure);
            app.TimeOverlapCheckBox.Text = 'Allow time windows to overlap';
            app.TimeOverlapCheckBox.Position = [13 122 182 22];
            app.TimeOverlapCheckBox.Value = true;

            % Create TimeZoneDropDown
            app.TimeZoneDropDown = uidropdown(app.LOTUS_readerUIFigure);
            app.TimeZoneDropDown.Items = {'Option1', 'Option 2', 'Option 3'};
            app.TimeZoneDropDown.Position = [361 307 141 22];
            app.TimeZoneDropDown.Value = 'Option1';

            % Create TimeZoneofDataDropDownLabel
            app.TimeZoneofDataDropDownLabel = uilabel(app.LOTUS_readerUIFigure);
            app.TimeZoneofDataDropDownLabel.HorizontalAlignment = 'right';
            app.TimeZoneofDataDropDownLabel.FontWeight = 'bold';
            app.TimeZoneofDataDropDownLabel.Position = [247 307 109 22];
            app.TimeZoneofDataDropDownLabel.Text = 'Time Zone of Data';

            % Create FilterDateRangePanel
            app.FilterDateRangePanel = uipanel(app.LOTUS_readerUIFigure);
            app.FilterDateRangePanel.Title = 'Filter Date Range';
            app.FilterDateRangePanel.BackgroundColor = [0.902 0.902 0.902];
            app.FilterDateRangePanel.FontWeight = 'bold';
            app.FilterDateRangePanel.Position = [13 157 197 138];

            % Create StartDateDatePickerLabel
            app.StartDateDatePickerLabel = uilabel(app.FilterDateRangePanel);
            app.StartDateDatePickerLabel.HorizontalAlignment = 'right';
            app.StartDateDatePickerLabel.Position = [9 45 60 22];
            app.StartDateDatePickerLabel.Text = 'Start Date';

            % Create StartDateDatePicker
            app.StartDateDatePicker = uidatepicker(app.FilterDateRangePanel);
            app.StartDateDatePicker.DisplayFormat = 'dd/MMM/uuuu';
            app.StartDateDatePicker.Position = [76 42 106 27];

            % Create EndDateDatePickerLabel
            app.EndDateDatePickerLabel = uilabel(app.FilterDateRangePanel);
            app.EndDateDatePickerLabel.HorizontalAlignment = 'right';
            app.EndDateDatePickerLabel.Position = [12 12 56 22];
            app.EndDateDatePickerLabel.Text = 'End Date';

            % Create EndDateDatePicker
            app.EndDateDatePicker = uidatepicker(app.FilterDateRangePanel);
            app.EndDateDatePicker.DisplayFormat = 'dd/MMM/uuuu';
            app.EndDateDatePicker.Position = [76 9 106 27];

            % Create AnalyserButton
            app.AnalyserButton = uibutton(app.LOTUS_readerUIFigure, 'push');
            app.AnalyserButton.ButtonPushedFcn = createCallbackFcn(app, @AnalyserButtonPushed, true);
            app.AnalyserButton.BackgroundColor = [0 0 0];
            app.AnalyserButton.FontWeight = 'bold';
            app.AnalyserButton.FontColor = [1 0.4118 0.1608];
            app.AnalyserButton.Position = [518 19 80 22];
            app.AnalyserButton.Text = 'Analyser';

            % Create DarkSwitch
            app.DarkSwitch = uiswitch(app.LOTUS_readerUIFigure, 'slider');
            app.DarkSwitch.Items = {'0', '1'};
            app.DarkSwitch.ValueChangedFcn = createCallbackFcn(app, @DarkSwitchValueChanged, true);
            app.DarkSwitch.FontSize = 0.01;
            app.DarkSwitch.Position = [575 483 23 10];
            app.DarkSwitch.Value = '0';

            % Create SelectSubjectsLabel
            app.SelectSubjectsLabel = uilabel(app.LOTUS_readerUIFigure);
            app.SelectSubjectsLabel.HorizontalAlignment = 'center';
            app.SelectSubjectsLabel.FontWeight = 'bold';
            app.SelectSubjectsLabel.Position = [512 274 94 22];
            app.SelectSubjectsLabel.Text = 'Select Subjects';

            % Create SelectDataLabel
            app.SelectDataLabel = uilabel(app.LOTUS_readerUIFigure);
            app.SelectDataLabel.FontWeight = 'bold';
            app.SelectDataLabel.FontColor = [1 0 0];
            app.SelectDataLabel.Position = [9 387 100 22];
            app.SelectDataLabel.Text = 'Select Data Type';

            % Create InputButton
            app.InputButton = uibuttongroup(app.LOTUS_readerUIFigure);
            app.InputButton.BorderType = 'none';
            app.InputButton.Position = [411 391 195 15];

            % Create AvroButton
            app.AvroButton = uiradiobutton(app.InputButton);
            app.AvroButton.Text = 'Avro';
            app.AvroButton.Position = [97 -3 49 22];

            % Create CSVButton
            app.CSVButton = uiradiobutton(app.InputButton);
            app.CSVButton.Text = 'CSV';
            app.CSVButton.Position = [147 -3 49 22];
            app.CSVButton.Value = true;

            % Create InputLabel
            app.InputLabel = uilabel(app.LOTUS_readerUIFigure);
            app.InputLabel.FontWeight = 'bold';
            app.InputLabel.Position = [466 387 38 22];
            app.InputLabel.Text = 'Input:';

            % Create CoolSwitch
            app.CoolSwitch = uiswitch(app.LOTUS_readerUIFigure, 'slider');
            app.CoolSwitch.Items = {'0', '1'};
            app.CoolSwitch.ValueChangedFcn = createCallbackFcn(app, @CoolSwitchValueChanged, true);
            app.CoolSwitch.FontSize = 0.01;
            app.CoolSwitch.Position = [575 464 23 10];
            app.CoolSwitch.Value = '0';

            % Create DarkLabel
            app.DarkLabel = uilabel(app.LOTUS_readerUIFigure);
            app.DarkLabel.FontSize = 10;
            app.DarkLabel.FontAngle = 'italic';
            app.DarkLabel.FontColor = [0.502 0.502 0.502];
            app.DarkLabel.Position = [547 478 26 20];
            app.DarkLabel.Text = 'Dark';

            % Create CoolLabel
            app.CoolLabel = uilabel(app.LOTUS_readerUIFigure);
            app.CoolLabel.FontSize = 10;
            app.CoolLabel.FontAngle = 'italic';
            app.CoolLabel.FontColor = [0.502 0.502 0.502];
            app.CoolLabel.Position = [547 458 26 22];
            app.CoolLabel.Text = 'Cool';

            % Create SubjectListBox
            app.SubjectListBox = uilistbox(app.LOTUS_readerUIFigure);
            app.SubjectListBox.Items = {'Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7', 'Item 8', 'Item 9', 'Item 10', 'Item 11', 'Item 12', 'Item 13', 'Item 14', 'Item 15'};
            app.SubjectListBox.Multiselect = 'on';
            app.SubjectListBox.ValueChangedFcn = createCallbackFcn(app, @SubjectListBoxValueChanged, true);
            app.SubjectListBox.FontSize = 10;
            app.SubjectListBox.FontColor = [0.6392 0.0784 0.1804];
            app.SubjectListBox.Position = [514 157 89 119];
            app.SubjectListBox.Value = {'Item 1'};

            % Create DateRangeInstructions
            app.DateRangeInstructions = uilabel(app.LOTUS_readerUIFigure);
            app.DateRangeInstructions.WordWrap = 'on';
            app.DateRangeInstructions.FontAngle = 'italic';
            app.DateRangeInstructions.FontColor = [0 0 1];
            app.DateRangeInstructions.Position = [20 233 189 37];
            app.DateRangeInstructions.Text = 'Select date range (Start and End dates included)';

            % Create AuthorLabel
            app.AuthorLabel = uilabel(app.LOTUS_readerUIFigure);
            app.AuthorLabel.FontSize = 10;
            app.AuthorLabel.FontWeight = 'bold';
            app.AuthorLabel.FontAngle = 'italic';
            app.AuthorLabel.Position = [40 450 81 28];
            app.AuthorLabel.Text = {'Jack Fogarty'; '2024'};

            % Create loadus
            app.loadus = uiimage(app.LOTUS_readerUIFigure);
            app.loadus.Position = [3 444 41 41];
            app.loadus.ImageSource = fullfile(pathToMLAPP, 'images', 'Static.png');

            % Show the figure after all components are created
            app.LOTUS_readerUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = LOTUS_reader

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.LOTUS_readerUIFigure)

                % Execute the startup function
                runStartupFcn(app, @startupFcn)
            else

                % Focus the running singleton app
                figure(runningApp.LOTUS_readerUIFigure)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.LOTUS_readerUIFigure)
        end
    end
end