classdef LOTUS_analyser < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        LOTUS_analyserUIFigure          matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        HomeTab                         matlab.ui.container.Tab
        HT_Title                        matlab.ui.control.Label
        HT_Lotus_a                      matlab.ui.control.Image
        HT_Lotus_b                      matlab.ui.control.Image
        HT_Lotus_c                      matlab.ui.control.Image
        EditTagsTab                     matlab.ui.container.Tab
        OverlayOriginal                 matlab.ui.control.CheckBox
        ET_Xreset                       matlab.ui.control.Button
        ET_Yreset                       matlab.ui.control.Button
        ET_Browse                       matlab.ui.control.Button
        ET_Apply                        matlab.ui.control.Button
        ET_Reset                        matlab.ui.control.Button
        ET_Save                         matlab.ui.control.Button
        ET_YUp                          matlab.ui.control.Button
        ET_YDwn                         matlab.ui.control.Button
        ET_BigStepDwn                   matlab.ui.control.Button
        ET_SmallStepDwn                 matlab.ui.control.Button
        ET_SmallStepUp                  matlab.ui.control.Button
        ET_BigStepUp                    matlab.ui.control.Button
        ET_FileDropDwn                  matlab.ui.control.DropDown
        ET_filen                        matlab.ui.control.NumericEditField
        ET_FileDwn                      matlab.ui.control.Button
        ET_FileUp                       matlab.ui.control.Button
        ET_SignalDropDown               matlab.ui.control.DropDown
        ET_UITable                      matlab.ui.control.Table
        ET_EditEventTagsLabel           matlab.ui.control.Label
        ET_TotalTagsLabel               matlab.ui.control.Label
        ET_LoadNextOnSave               matlab.ui.control.CheckBox
        ET_Overwrite                    matlab.ui.control.CheckBox
        ET_Panel                        matlab.ui.container.Panel
        ET_TabGroup                     matlab.ui.container.TabGroup
        ET_TimeRange                    matlab.ui.container.Tab
        ET_AutoButton                   matlab.ui.control.Button
        SelectnewtimerangetodisplayontheplotxaxisaboveLabel  matlab.ui.control.Label
        ET_DaysLabel                    matlab.ui.control.Label
        ET_Label_a                      matlab.ui.control.Label
        ET_Label_b                      matlab.ui.control.Label
        ET_Label_c                      matlab.ui.control.Label
        ET_StartDay                     matlab.ui.control.Spinner
        ET_StartHour                    matlab.ui.control.Spinner
        ET_StartMin                     matlab.ui.control.Spinner
        ET_StartSec                     matlab.ui.control.Spinner
        ET_HoursLabel                   matlab.ui.control.Label
        ET_MinsLabel                    matlab.ui.control.Label
        ET_SecsLabel                    matlab.ui.control.Label
        ET_AddTags                      matlab.ui.container.Tab
        ET_AddTagsGrid                  matlab.ui.container.GridLayout
        ET_AddButton                    matlab.ui.control.Button
        ET_DateLabel                    matlab.ui.control.Label
        ET_hourLabel                    matlab.ui.control.Label
        ET_minLabel                     matlab.ui.control.Label
        ET_secLabel                     matlab.ui.control.Label
        ET_msLabel                      matlab.ui.control.Label
        ET_DatePicker                   matlab.ui.control.DatePicker
        ET_NewTagH                      matlab.ui.control.Spinner
        ET_NewTagM                      matlab.ui.control.Spinner
        ET_NewTagS                      matlab.ui.control.Spinner
        ET_NewTagms                     matlab.ui.control.Spinner
        TagAddInst                      matlab.ui.control.Label
        ET_RemoveTags                   matlab.ui.container.Tab
        ET_TimeWindowInst               matlab.ui.control.Label
        ET_TagListBox                   matlab.ui.control.ListBox
        ET_DeleteButton                 matlab.ui.control.Button
        TagListBoxLabel                 matlab.ui.control.Label
        ET_UIAxes                       matlab.ui.control.UIAxes
        PreprocessTab                   matlab.ui.container.Tab
        EVR_SelectEventButtonGroup      matlab.ui.container.ButtonGroup
        EVR_PreEditField                matlab.ui.control.NumericEditField
        EVR_PostEditField               matlab.ui.control.NumericEditField
        EVR_epoch_label                 matlab.ui.control.Label
        EVR_ListBox                     matlab.ui.control.ListBox
        EVR_PreLabel                    matlab.ui.control.Label
        EVR_to                          matlab.ui.control.Label
        EVR_PostLabel                   matlab.ui.control.Label
        EVR_AnnotationButton            matlab.ui.control.RadioButton
        EVR_TagButton                   matlab.ui.control.RadioButton
        ETP_SelectTimepointButtonGroup  matlab.ui.container.ButtonGroup
        ETP_ep_point                    matlab.ui.control.NumericEditField
        ETP_PointButton                 matlab.ui.control.RadioButton
        ETP_TimeButton                  matlab.ui.control.RadioButton
        ETP_ep_datetime                 matlab.ui.control.EditField
        ETP_ep_datepick                 matlab.ui.control.DatePicker
        ETP_epoch_label                 matlab.ui.control.Label
        ETP_PreLabel                    matlab.ui.control.Label
        ETP_PreEditField                matlab.ui.control.NumericEditField
        ETP_to                          matlab.ui.control.Label
        ETP_PostEditField               matlab.ui.control.NumericEditField
        ETP_PostLabel                   matlab.ui.control.Label
        SEQ_SequentialEpochsButtonGroup  matlab.ui.container.ButtonGroup
        SEQ_ForwardsButton              matlab.ui.control.StateButton
        SEQ_N_epochs_label              matlab.ui.control.Label
        SEQ_length_label                matlab.ui.control.Label
        SEQ_N_epochs                    matlab.ui.control.NumericEditField
        SEQ_event_dropdown              matlab.ui.control.DropDown
        SEQ_overlap_label               matlab.ui.control.Label
        SEQ_window_length               matlab.ui.control.NumericEditField
        SEQ_epoch_overlap               matlab.ui.control.NumericEditField
        SEQ_AnnotationButton            matlab.ui.control.RadioButton
        SEQ_TagButton                   matlab.ui.control.RadioButton
        EB_EventBButtonGroup            matlab.ui.container.ButtonGroup
        EB_event_dropdown               matlab.ui.control.DropDown
        EB_AnnotationButton             matlab.ui.control.RadioButton
        EB_TagButton                    matlab.ui.control.RadioButton
        EA_EventAButtonGroup            matlab.ui.container.ButtonGroup
        EA_event_dropdown               matlab.ui.control.DropDown
        EA_AnnotationButton             matlab.ui.control.RadioButton
        EA_TagButton                    matlab.ui.control.RadioButton
        EPO_ApplytoAll                  matlab.ui.control.CheckBox
        EPO_ModeListBox                 matlab.ui.control.ListBox
        EPO_Add                         matlab.ui.control.Button
        ART_ApplytoAll                  matlab.ui.control.CheckBox
        ART_DetrendDataPanel            matlab.ui.container.Panel
        DET_niter                       matlab.ui.control.NumericEditField
        ThresholdLabel                  matlab.ui.control.Label
        DET_nanflag                     matlab.ui.control.CheckBox
        DET_TypeDropDown                matlab.ui.control.DropDown
        FunctionLabel                   matlab.ui.control.Label
        DET_Thresh                      matlab.ui.control.NumericEditField
        ThresholdforOutliersLabel       matlab.ui.control.Label
        DET_PolynomialDegree            matlab.ui.control.NumericEditField
        PolyDegreeOrderLabel            matlab.ui.control.Label
        ART_TransformDataPanel          matlab.ui.container.Panel
        TransformWindow                 matlab.ui.control.NumericEditField
        ArtefactPaddingLabel_5          matlab.ui.control.Label
        Log10CheckBox                   matlab.ui.control.CheckBox
        ZscoreCheckBox                  matlab.ui.control.CheckBox
        ART_InterpolateDataPanel        matlab.ui.container.Panel
        INT_EndValuesDropDown           matlab.ui.control.DropDown
        EndValuesDropDownLabel          matlab.ui.control.Label
        INT_MaxGap                      matlab.ui.control.NumericEditField
        MaxGapEditFieldLabel            matlab.ui.control.Label
        INT_WindowLengthPts             matlab.ui.control.NumericEditField
        WindowLengthPtsEditField_2Label  matlab.ui.control.Label
        INT_Scalarvalue                 matlab.ui.control.NumericEditField
        ScalarvalueEditFieldLabel       matlab.ui.control.Label
        INT_TypeDropDown                matlab.ui.control.DropDown
        TypeDropDown_2Label             matlab.ui.control.Label
        ART_FilterDataPanel             matlab.ui.container.Panel
        FIL_Notch                       matlab.ui.control.CheckBox
        FIL_FilterOrder                 matlab.ui.control.NumericEditField
        FilterorderEditFieldLabel       matlab.ui.control.Label
        FIL_Lowpasscutoff               matlab.ui.control.NumericEditField
        LowpasscutoffHzEditFieldLabel   matlab.ui.control.Label
        FIL_Highpasscutoff              matlab.ui.control.NumericEditField
        HighpasscutoffHzEditFieldLabel  matlab.ui.control.Label
        FIL_FilterWindowPts             matlab.ui.control.NumericEditField
        WindowLengthPtsEditFieldLabel   matlab.ui.control.Label
        FIL_FilterTypeDD                matlab.ui.control.DropDown
        TypeDropDownLabel               matlab.ui.control.Label
        ART_ArtefactDetectionPanel      matlab.ui.container.Panel
        ARD_maxThreshlabel              matlab.ui.control.Label
        ARD_minThreshlabel              matlab.ui.control.Label
        ARD_minThreshCheck              matlab.ui.control.CheckBox
        ARD_maxThreshCheck              matlab.ui.control.CheckBox
        ARD_Criteria                    matlab.ui.control.DropDown
        CriteriaLabel                   matlab.ui.control.Label
        ARD_maxThreshold                matlab.ui.control.NumericEditField
        ARD_minThreshold                matlab.ui.control.NumericEditField
        ARD_ArtefactWindow              matlab.ui.control.NumericEditField
        ArtefactPaddingLabel_2          matlab.ui.control.Label
        ARD_plot_artefact               matlab.ui.control.Button
        ARD_ArtefactPadding             matlab.ui.control.NumericEditField
        ArtefactPaddingLabel            matlab.ui.control.Label
        ART_Add                         matlab.ui.control.Button
        ART_ArtefactFunction            matlab.ui.container.ButtonGroup
        ART_TransformCheckBox           matlab.ui.control.CheckBox
        ART_InterpolateCheckBox         matlab.ui.control.CheckBox
        ART_IDArtefactCheckBox          matlab.ui.control.CheckBox
        ART_FilterCheckBox              matlab.ui.control.CheckBox
        ART_DetrendCheckBox             matlab.ui.control.CheckBox
        ART_show_transform              matlab.ui.control.ToggleButton
        ART_show_interpolate            matlab.ui.control.ToggleButton
        ART_show_ID_artefact            matlab.ui.control.ToggleButton
        ART_show_filter                 matlab.ui.control.ToggleButton
        ART_show_detrend                matlab.ui.control.ToggleButton
        ExportTypeLabel                 matlab.ui.control.Label
        matCheckBox                     matlab.ui.control.CheckBox
        xlsxCheckBox                    matlab.ui.control.CheckBox
        PT_PipelinePanel                matlab.ui.container.Panel
        ArtefactsCheckBox               matlab.ui.control.CheckBox
        EpochsCheckBox                  matlab.ui.control.CheckBox
        HideButton                      matlab.ui.control.StateButton
        PT_ListBox                      matlab.ui.control.ListBox
        PT_Delete                       matlab.ui.control.Button
        PT_ResetButton                  matlab.ui.control.Button
        PT_SaveButton                   matlab.ui.control.Button
        PT_ResampleDataPanel            matlab.ui.container.Panel
        RES_InterpolationTypeLabel      matlab.ui.control.Label
        RES_ApplytoAll                  matlab.ui.control.CheckBox
        RES_Interp                      matlab.ui.control.DropDown
        RES_Hz_label                    matlab.ui.control.Label
        RES_Add                         matlab.ui.control.Button
        RES_label                       matlab.ui.control.Label
        RES_HzEdit                      matlab.ui.control.NumericEditField
        HzEditFieldLabel                matlab.ui.control.Label
        RES_ResampletoHzLabel           matlab.ui.control.Label
        PT_EpochDataPanel               matlab.ui.container.Panel
        PT_EpochTabGroup                matlab.ui.container.TabGroup
        PT_EDAEpochTab                  matlab.ui.container.Tab
        PT_BVPEpochTab                  matlab.ui.container.Tab
        PT_SystPEpochTab                matlab.ui.container.Tab
        PT_ACCEpochTab                  matlab.ui.container.Tab
        PT_TempEpochTab                 matlab.ui.container.Tab
        PT_ArtefactsPanel               matlab.ui.container.Panel
        PT_ArtefactTab                  matlab.ui.container.TabGroup
        PT_EDAArtefactTab               matlab.ui.container.Tab
        PT_BVPArtefactTab               matlab.ui.container.Tab
        PT_SystPArtefactTab             matlab.ui.container.Tab
        PT_ACCArtefactTab               matlab.ui.container.Tab
        PT_TempArtefactTab              matlab.ui.container.Tab
        AnalysesTab                     matlab.ui.container.Tab
        SynchronyTab                    matlab.ui.container.Tab
        CoolSwitch                      matlab.ui.control.Switch
        DarkSwitch                      matlab.ui.control.Switch
        CoolLabel                       matlab.ui.control.Label
        DarkLabel                       matlab.ui.control.Label
        AuthorLabel                     matlab.ui.control.Label
        AppTitle                        matlab.ui.control.Label
    end

%%% NOTES FOR IMPROVEMENT

%%% Artefact rejection
    % Resampling should potentially abolish artefact ID's held in working memory [possibly make updating artefact a sep function]

%%% Epoching
    % Epoch A vs B should also allow pre/post time adjustment

%%% Add a 'clear all' button to GUI tabs [will require a full 'written out' reset of app component defaults]

%%% Determine if log10 transformation is useful in preprocessing phase

%%% Ensure ability to read epochs into analyzer (currently all ok except for sequential epoch files; EVR epochs may be nice to see the tag...)

%%% UPDATE SAVE & ALLOW MULTI SAVE INCLUDING INPUT DATA + EPOCHS
%%% Save configuration details with excel?
%%% Check configuration and constistency of data management across key structures

%%% Terminology for epochs vs distinct continuous recordings is overlapping and potentially confusing in code.
%%% Log/history of processes?
%%% GUI spacing / grid alignments
    
    properties (Access = private)
                        
    end
    
    properties (Access = public)

        % General and Edit variables
        file         % The file to read in
        filepath     % file path for the loaded data
        big          % Big step in plot
        small        % Small step in plot
        timerange    % Timerange of x axis
        deleted_tags % Tags removed
        signals      % List of non-empty signal arrays in data
        osigdat      % Original version of current signal
        sigdat       % Working version of  current signal
        styles       % store styles of the tables
        fav          % Number of files(cells) available
        f            % File(cell) selected
        e            % Epoch selected
        rmv_tags     % Tags that are marked for deletion        
        cfg          % Configuration for editing
        dat          % Data structure for editing
        original_cfg % Original loadeded configuration
        original_dat % Original loadeded data
        ep_list      % Track epochs for updating listbox
        art_list     % Track artefacts for updating listbox
        rtn          % Flag return from warning

        % Analysis variables
        res          % Resampling parameters
        det          % Detrend parameters
        fil          % Filter parameters
        art          % Artefact detection parameters
        rej          % Applied artefact rejection
        int          % Interpolation parameters
        Tra          % Transforms
        
        % Epoch variables
        epoch        % Storage for the epochs
        sel_epoch    % Index for the current selected epoch

    end
        

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
                
            % Position GUI in center screen
            movegui(app.LOTUS_analyserUIFigure,'north');
            
            % Save plot axes positions
            app.ET_UIAxes.PositionConstraint = 'innerposition';
            
            % Start epoch and file markers at 1
            % N.B. Epoch marker and selection currently redundant for continuous files which are now output from LOTUS reader as a single epoch file
            app.e = 1;
            app.f = 1;
            
            % File marker
            app.ET_filen.Value = app.e;

            % Set up list markers and other parameters
            app.ep_list  = {'Input Data'};
            app.art_list = {'Input Data'};
            app.rtn = 0;
                        
        end

        % Button down function: EditTagsTab
        function EditTagsTabButtonDown(app, event)
            
            % Shift UIAxes and common components between tabs
            app.ET_Browse.Parent         = app.EditTagsTab;
            app.ET_FileDropDwn.Parent    = app.EditTagsTab;
            app.ET_FileDwn.Parent        = app.EditTagsTab;
            app.ET_FileUp.Parent         = app.EditTagsTab;
            app.ET_filen.Parent          = app.EditTagsTab;
            app.ET_SignalDropDown.Parent = app.EditTagsTab;
            app.ET_UIAxes.Parent         = app.EditTagsTab;
            app.ET_YUp.Parent            = app.EditTagsTab;
            app.ET_YDwn.Parent           = app.EditTagsTab;
            app.ET_BigStepDwn.Parent     = app.EditTagsTab;
            app.ET_BigStepUp.Parent      = app.EditTagsTab;
            app.ET_SmallStepDwn.Parent   = app.EditTagsTab;
            app.ET_SmallStepUp.Parent    = app.EditTagsTab;
            app.ET_Xreset.Parent         = app.EditTagsTab;
            app.ET_Yreset.Parent         = app.EditTagsTab;
            app.OverlayOriginal.Parent   = app.EditTagsTab;
                 
        end

        % Button down function: PreprocessTab
        function PreprocessTabButtonDown(app, event)

            % Shift UIAxes and common components between tabs
            app.ET_Browse.Parent         = app.PreprocessTab;
            app.ET_FileDropDwn.Parent    = app.PreprocessTab;
            app.ET_FileDwn.Parent        = app.PreprocessTab;
            app.ET_FileUp.Parent         = app.PreprocessTab;
            app.ET_filen.Parent          = app.PreprocessTab;
            app.ET_SignalDropDown.Parent = app.PreprocessTab;
            app.ET_UIAxes.Parent         = app.PreprocessTab;
            app.ET_YUp.Parent            = app.PreprocessTab;
            app.ET_YDwn.Parent           = app.PreprocessTab;
            app.ET_BigStepDwn.Parent     = app.PreprocessTab;
            app.ET_BigStepUp.Parent      = app.PreprocessTab;
            app.ET_SmallStepDwn.Parent   = app.PreprocessTab;
            app.ET_SmallStepUp.Parent    = app.PreprocessTab;
            app.ET_Xreset.Parent         = app.PreprocessTab;
            app.ET_Yreset.Parent         = app.PreprocessTab;
            app.OverlayOriginal.Parent   = app.PreprocessTab;
            
            % Refresh Low-Level Tab Groups
            ep_refresh_PT(app);
            
        end

        % Button pushed function: ET_Browse
        function ET_BrowseButtonPushed(app, event)
                        
            % Browse to parent folder (subfolders should be dates)
            [app.file, app.filepath] = uigetfile('*.mat','MultiSelect','on');

            % Redraw figure on Cancel: If user clicks cancel the file will be an empty double (do nothing)
            if ~iscell(app.file) & ~ischar(app.file)
                figure(app.LOTUS_analyserUIFigure);
            else

                % Check format of file info
                if ischar(app.file)
                   app.file = {app.file};
                end
    
                % Update file drop down
                app.ET_FileDropDwn.Items = app.file;
                app.ET_FileDropDwn.ValueIndex = 1;
                
                % Reset file counter and import first file
                app.f = 1;
                ep_load_data(app);
                
                % Update GUI elements with selected data
                ep_update_gui(app,'load_new');
                
                % Refresh Low-Level Tab Groups
                if strcmp(app.TabGroup.SelectedTab.Title,'Preprocess Data')
                   ep_refresh_PT(app);
                end
    
                % Redraw figure
                figure(app.LOTUS_analyserUIFigure);

            end
            
        end

        % Button pushed function: ET_BigStepUp
        function ET_BigStepUpButtonPushed(app, event)
                        
            % Increase by big step but do not go beyond limit of the data
            if  app.ET_UIAxes.XLim(2)+app.big > eval([app.sigdat '.local_time(end)'])
                app.ET_UIAxes.XLim = [eval([app.sigdat '.local_time(end)'])-app.timerange eval([app.sigdat '.local_time(end)'])];
            else
                app.ET_UIAxes.XLim = app.ET_UIAxes.XLim+app.big;
            end

            % Update plot
            ep_updateplot(app,'NAV');
            
        end

        % Button pushed function: ET_SmallStepUp
        function ET_SmallStepUpButtonPushed(app, event)
                                    
            % Increase by small step but do not go beyond limit of the data
            if  app.ET_UIAxes.XLim(2)+app.small > eval([app.sigdat '.local_time(end)'])
                app.ET_UIAxes.XLim = [eval([app.sigdat '.local_time(end)'])-app.timerange eval([app.sigdat '.local_time(end)'])];
            else
                app.ET_UIAxes.XLim = app.ET_UIAxes.XLim+app.small;
            end

            % Update plot
            ep_updateplot(app,'NAV');
            
        end

        % Button pushed function: ET_SmallStepDwn
        function ET_SmallStepDwnButtonPushed(app, event)
                                   
            % Decrease by small step but do not go beyond limit of the data
            if  app.ET_UIAxes.XLim(1)-app.small < eval([app.sigdat '.local_time(1)'])
                app.ET_UIAxes.XLim = [eval([app.sigdat '.local_time(1)']) eval([app.sigdat '.local_time(1)'])+app.timerange];
            else
                app.ET_UIAxes.XLim = app.ET_UIAxes.XLim-app.small;
            end

            % Update plot
            ep_updateplot(app,'NAV');
            
        end

        % Button pushed function: ET_BigStepDwn
        function ET_BigStepDwnButtonPushed(app, event)
                                               
            % Decrease by big step but do not go beyond limit of the data
            if  app.ET_UIAxes.XLim(1)-app.big < eval([app.sigdat '.local_time(1)'])
                app.ET_UIAxes.XLim = [eval([app.sigdat '.local_time(1)']) eval([app.sigdat '.local_time(1)'])+app.timerange];
            else
                app.ET_UIAxes.XLim = app.ET_UIAxes.XLim-app.big;
            end
            
            % Update plot
            ep_updateplot(app,'NAV');

        end

        % Button pushed function: ET_YUp
        function ET_YUpButtonPushed(app, event)
                        
            app.ET_UIAxes.YLim = app.ET_UIAxes.YLim-app.ET_UIAxes.YLim*0.05;
            
        end

        % Button pushed function: ET_YDwn
        function ET_YDwnButtonPushed(app, event)
                        
            app.ET_UIAxes.YLim = app.ET_UIAxes.YLim+app.ET_UIAxes.YLim*0.05;
            
        end

        % Button pushed function: ET_Yreset
        function ET_YresetButtonPushed(app, event)
            
            app.ET_UIAxes.YLimMode = 'auto';

        end

        % Button pushed function: ET_Xreset
        function ET_XresetButtonPushed(app, event)
            
            % Return to earliest timepoint
            app.ET_UIAxes.XLim = [min(eval([app.sigdat '.local_time'])) min(eval([app.sigdat '.local_time']))+app.timerange];

            % Update plot
            ep_updateplot(app,'NAV');

        end

        % Button pushed function: ET_AddButton
        function ET_AddButtonPushed(app, event)
                        
            % New tag date
            tag_date = app.ET_DatePicker.Value + duration(app.ET_NewTagH.Value,app.ET_NewTagM.Value,app.ET_NewTagS.Value,app.ET_NewTagms.Value);
            tag_date.TimeZone = app.cfg.TimeZone; tag_date.Format = 'MM/dd/yy HH:mm:ss.SSS';

            % Determine tag number and closest file times
            if isempty(app.dat.Tags{app.e})
               
               % Create alternate format for the table
               tag_numb = 1;
               app.dat.Tags{app.e} = table(tag_numb,NaT,NaT,tag_date,{['Event added '  datestr(datetime('today'))]},'VariableNames',{'Tag','UTC_FileTime','TZ_FileTime','TZ_TagTime','Annotation'});
               ep_format_table(app,event);
            else
               tag_numb = app.dat.Tags{app.e}.Tag(end)+1;
            
               % Closest file time
               tmp      = app.dat.Tags{app.e}.TZ_FileTime; tmp.Format = 'MM/dd/yy HH:mm:ss.SSS';
               if isnat(tmp)
                  closest_utime = NaT;
                  closest_rtime = NaT;
               else
                  [~,ind1] = min(abs(tmp-tag_date));
                  closest_utime = app.dat.Tags{app.e}.UTC_FileTime(ind1,:);
                  closest_rtime = app.dat.Tags{app.e}.TZ_FileTime(ind1,:);
               end
               
               % Update Table
               newRow = [{tag_numb},{closest_utime},{closest_rtime},{tag_date},{['Event added '  datestr(datetime('today'))]}];
               app.dat.Tags{app.e} = [app.dat.Tags{app.e}; newRow];
               ep_format_table(app,event);
            end
            
            % Update listbox
            app.ET_TagListBox.Items = [app.ET_TagListBox.Items {['Tag ' num2str(tag_numb)]}];

            % Update plot
            if ~isempty(app.signals)
                xline(app.ET_UIAxes, app.dat.Tags{app.e}.TZ_TagTime(tag_numb),'red',num2str(tag_numb),'LabelHorizontalAlignment','center','LabelOrientation','horizontal'); % ,'HandleVisibility','off'
            end
            
            % Update Tag Number
            app.ET_TotalTagsLabel.Text = ['Total Tags: ' num2str(height(app.dat.Tags{app.e}))];
            
        end

        % Button pushed function: ET_DeleteButton
        function ET_DeleteButtonPushed(app, event)
                       
            % Add selected tags to those listed for removal
            if isempty(app.rmv_tags{app.e,1})
                app.rmv_tags{app.e,1} = [find(ismember(app.ET_TagListBox.Items, app.ET_TagListBox.Value))];
            else
                app.rmv_tags{app.e,1} = [app.rmv_tags{app.e,1} find(ismember(app.ET_TagListBox.Items, app.ET_TagListBox.Value))];
            end
            
            % Remove duplicates of the same value
            app.rmv_tags{app.e,1} = unique(app.rmv_tags{app.e,1});
            
            % Highlight removed tags in table
            s = uistyle("BackgroundColor","#fAC5C5");
            addStyle(app.ET_UITable,s,"row",app.rmv_tags{app.e,1});
            
            % Remove tags from plot
            if ~isempty(app.signals)
               delete(app.ET_UIAxes.Children(find(ismember(get(findobj(app.ET_UIAxes,'type','ConstantLine'),'Label'),string(app.rmv_tags{app.e,1})))));
            end
            
            % Update style for this set of tags
            app.styles{app.e,1} =  app.ET_UITable.StyleConfigurations;
                        
        end

        % Button pushed function: ET_Apply
        function ET_ApplyButtonPushed(app, event)
                        
            % Apply changes
            updategui = 1;
            ep_apply_changes(app,'Tag',updategui);
                                 
        end

        % Value changed function: ET_SignalDropDown
        function ET_SignalDropDownValueChanged(app, event)
            
            ep_updateplot(app,'SIG');

            % Update tab groups
            if strcmp(app.ET_SignalDropDown.Value,'EDA')
                app.PT_EpochTabGroup.SelectedTab    = app.PT_EDAEpochTab;
                app.PT_ArtefactTab.SelectedTab      = app.PT_EDAArtefactTab;
                                
                % Update Fs label
                app.RES_Hz_label.Text = [num2str(round(1/seconds(mean(diff(eval([app.sigdat '.local_time'])))))) ' Hz']; % Hz
                
                
            elseif strcmp(app.ET_SignalDropDown.Value,'BVP')
                app.PT_EpochTabGroup.SelectedTab    = app.PT_BVPEpochTab;
                app.PT_ArtefactTab.SelectedTab      = app.PT_BVPArtefactTab;
                                
                % Update Fs label
                app.RES_Hz_label.Text = [num2str(round(1/seconds(mean(diff(eval([app.sigdat '.local_time'])))))) ' Hz']; % Hz
                
            elseif strcmp(app.ET_SignalDropDown.Value,'SystP')
                app.PT_EpochTabGroup.SelectedTab    = app.PT_SystPEpochTab;
                app.PT_ArtefactTab.SelectedTab      = app.PT_SystPArtefactTab;
                
                % Update Fs label
                app.RES_Hz_label.Text = '~ Hz';
                
            elseif strcmp(app.ET_SignalDropDown.Value,'ACC')
                app.PT_EpochTabGroup.SelectedTab    = app.PT_ACCEpochTab;
                app.PT_ArtefactTab.SelectedTab      = app.PT_ACCArtefactTab;
                                
                % Update Fs label
                app.RES_Hz_label.Text = [num2str(round(1/seconds(mean(diff(eval([app.sigdat '.local_time'])))))) ' Hz']; % Hz
                
            elseif strcmp(app.ET_SignalDropDown.Value,'Temp')
                app.PT_EpochTabGroup.SelectedTab    = app.PT_TempEpochTab;
                app.PT_ArtefactTab.SelectedTab      = app.PT_TempArtefactTab;
                                
                % Update Fs label
                app.RES_Hz_label.Text = [num2str(round(1/seconds(mean(diff(eval([app.sigdat '.local_time'])))))) ' Hz']; % Hz
                
            % Add more signals...

            end
            
            
        end

        % Button pushed function: ET_FileDwn
        function ET_FileDwnButtonPushed(app, event)
                        
            % Load the previous epoch for this subject
            if  app.e-1 < 1
                % No change: stay with first epoch
            else
                app.e = app.e-1;
                ep_update_gui(app,event);
            end
            
        end

        % Button pushed function: ET_FileUp
        function ET_FileUpButtonPushed(app, event)
                                    
            % Load the next epoch for this subject
            if  app.e+1 > app.fav
                % No change: stay with last epoch
            else
                app.e = app.e+1;
                ep_update_gui(app,event);
            end
            
        end

        % Value changed function: ET_FileDropDwn
        function ET_FileDropDwnValueChanged(app, event)
            
            % Update file and epoch markers
            app.f = find(strcmp(app.ET_FileDropDwn.Value,app.file));
            app.e = 1;
            
            % Import file
            ep_load_data(app);
            
            % Update GUI elements with selected data
            ep_update_gui(app,'load_new');
            
        end

        % Button pushed function: ET_Reset
        function ET_ResetButtonPushed(app, event)
                        
            % Reset the current dataset
            ep_update_gui(app,'reset');
            
        end

        % Button pushed function: ET_Save
        function ET_SaveButtonPushed(app, event)
                        
            % Apply changes to all subsamples for this subject
            tmp = app.e;
            for i = 1:app.fav
                updategui = tmp == i; % Flag to update current GUI table or not
                app.e     = i;
                ep_apply_changes(app,event,updategui);
            end
            app.e = tmp;
            clear i tmp    
                        
            % Compile new data and save in output folder

                % Update the Tags variable and prepare output
                cfg = app.cfg;        
                dat = app.dat;
                dat.deleted_Tags = app.deleted_tags;

                % Output new Matfile
                if app.ET_Overwrite.Value
                    % Output the mat data for this subject
                    save([app.filepath '\' app.file{1,app.f}],'dat','cfg');
                else
                    % Select output folder
                    tmp = uigetdir(app.cfg.parent_folder,'Select output folder');
        
                    % Output the mat data for this subject
                    save([tmp '\' app.file{1,app.f} '-TC.mat'],'dat','cfg');
                end

            % Load next file if option selected
            if length(app.file) > 1 && app.f < length(app.file) && app.ET_LoadNextOnSave.Value
                
                % Update file markers and drop down
                app.f = app.f+1;
                app.e = 1;
                app.ET_FileDropDwn.Value = app.ET_FileDropDwn.Items(app.f);
                
                % Import file
                ep_load_data(app);
                
                % Update GUI elements with selected data
                ep_update_gui(app,'load_new');
                
            end
            
            % Redraw figure
            figure(app.LOTUS_analyserUIFigure);
            
        end

        % Cell edit callback: ET_UITable
        function ET_UITableCellEdit(app, event)
            
            indices = event.Indices;
            newData = event.NewData;
            app.dat.Tags{app.e,1}(indices(1),indices(2)) = {newData};
            
        end

        % Value changed function: EPO_ModeListBox
        function EPO_ModeListBoxValueChanged(app, event)
            
            % Update epoching tab
            if     strcmp(app.EPO_ModeListBox.Value,'Event-Related')
                    
                    % Event-Related
                    app.EVR_SelectEventButtonGroup.Visible = 1;
                    % Timepoint
                    app.ETP_SelectTimepointButtonGroup.Visible = 0;
                    % Sequential
                    app.SEQ_SequentialEpochsButtonGroup.Visible = 0;
                    % Event A to B
                    app.EA_EventAButtonGroup.Visible = 0;
                    app.EB_EventBButtonGroup.Visible = 0;
                    
            elseif strcmp(app.EPO_ModeListBox.Value,'Timepoint')
                                    
                    % Event-Related
                    app.EVR_SelectEventButtonGroup.Visible = 0;
                    % Timepoint
                    app.ETP_SelectTimepointButtonGroup.Visible  = 1;
                    % Sequential
                    app.SEQ_SequentialEpochsButtonGroup.Visible = 0;
                    % Event A to B
                    app.EA_EventAButtonGroup.Visible = 0;
                    app.EB_EventBButtonGroup.Visible = 0;
                    
            elseif strcmp(app.EPO_ModeListBox.Value,'Sequential')
                                    
                    % Event-Related
                    app.EVR_SelectEventButtonGroup.Visible = 0;
                    % Timepoint
                    app.ETP_SelectTimepointButtonGroup.Visible = 0;
                    % Sequential
                    app.SEQ_SequentialEpochsButtonGroup.Visible = 1;
                    % Event A to B
                    app.EA_EventAButtonGroup.Visible = 0;
                    app.EB_EventBButtonGroup.Visible = 0;
                    
            elseif strcmp(app.EPO_ModeListBox.Value,'Event A to B')
                                    
                    % Event-Related
                    app.EVR_SelectEventButtonGroup.Visible = 0;
                    % Timepoint
                    app.ETP_SelectTimepointButtonGroup.Visible = 0;
                    % Sequential
                    app.SEQ_SequentialEpochsButtonGroup.Visible = 0;
                    % Event A to B
                    app.EA_EventAButtonGroup.Visible = 1;
                    app.EB_EventBButtonGroup.Visible = 1;
                    
            end
            
        end

        % Selection changed function: ART_ArtefactFunction
        function ART_ArtefactFunctionSelectionChanged(app, event)
            
            if strcmp(app.ART_ArtefactFunction.SelectedObject.Tag,'B1')
                app.ART_DetrendDataPanel.Visible       = 1;
                app.ART_FilterDataPanel.Visible        = 0;
                app.ART_ArtefactDetectionPanel.Visible = 0;
                app.ART_InterpolateDataPanel.Visible   = 0;
                app.ART_TransformDataPanel.Visible     = 0;
            elseif strcmp(app.ART_ArtefactFunction.SelectedObject.Tag,'B2')
                app.ART_DetrendDataPanel.Visible       = 0;
                app.ART_FilterDataPanel.Visible        = 1;
                app.ART_ArtefactDetectionPanel.Visible = 0;
                app.ART_InterpolateDataPanel.Visible   = 0;
                app.ART_TransformDataPanel.Visible     = 0;
            elseif strcmp(app.ART_ArtefactFunction.SelectedObject.Tag,'B3')
                app.ART_DetrendDataPanel.Visible       = 0;
                app.ART_FilterDataPanel.Visible        = 0;
                app.ART_ArtefactDetectionPanel.Visible = 1;
                app.ART_InterpolateDataPanel.Visible   = 0;
                app.ART_TransformDataPanel.Visible     = 0;
            elseif strcmp(app.ART_ArtefactFunction.SelectedObject.Tag,'B4')
                app.ART_DetrendDataPanel.Visible       = 0;
                app.ART_FilterDataPanel.Visible        = 0;
                app.ART_ArtefactDetectionPanel.Visible = 0;
                app.ART_InterpolateDataPanel.Visible   = 1;
                app.ART_TransformDataPanel.Visible     = 0;
            elseif strcmp(app.ART_ArtefactFunction.SelectedObject.Tag,'B5')
                app.ART_DetrendDataPanel.Visible       = 0;
                app.ART_FilterDataPanel.Visible        = 0;
                app.ART_ArtefactDetectionPanel.Visible = 0;
                app.ART_InterpolateDataPanel.Visible   = 0;
                app.ART_TransformDataPanel.Visible     = 1;
            end
            
        end

        % Button pushed function: RES_Add
        function RES_ApplyPushed(app, event)
            
            % Grab index incase resampling more than once (index redundant?)
            i = 1+size(app.res,1);
            app.res{i,1}.apa = app.RES_ApplytoAll.Value;

            % Resample data
            app = ep_resample(app,i);
                            
            % Update sample rate in 'Resample Section'
            app.RES_Hz_label.Text = [num2str(round(1/seconds(mean(diff(eval([app.sigdat '.local_time'])))))) ' Hz']; % Hz

            % Update plot with new signal data
            ep_updateplot(app,'PROC');

            
        end

        % Button pushed function: ART_Add
        function ART_ApplyPushed(app, event)
            
            % If the detrend check box is checked
            if app.ART_DetrendCheckBox.Value
                
                % Mark to ensure identification of the chosen action across variables/components 
                i = 1+size(app.det,1);
                app.det{i,1}.cfg.apa    = app.ART_ApplytoAll.Value;

                % Call desired function
                if      strcmp(app.DET_TypeDropDown.Value,'detrend')     % Default Matlab function
                            app = ep_detrend(app,i);
                elseif  strcmp(app.DET_TypeDropDown.Value,'nt_detrend')  % Based on NoiseTools function nt_detrend: de Cheveigne & Arzounian (2017)
                            app = ep_nt_detrend(app,i);
                elseif  strcmp(app.DET_TypeDropDown.Value,'sp_tarvainen')  % Based on NoiseTools function nt_detrend: de Cheveigne & Arzounian (2017)
                            app = ep_spRR_detrend(app,i);
                end
                               
                % Validate or remove returned structure
                if app.rtn
                    app.det(i) = [];
                    app.rtn    = 0;
                end
                                      
            end

            % If the filter check box is checked
            if app.ART_FilterCheckBox.Value
                
                % Mark to ensure identification of the chosen action across variables/components 
                i = 1+size(app.fil,1);
                app.fil{i,1}.cfg.apa    = app.ART_ApplytoAll.Value;

                % Call desired filter
                if      strcmp(app.FIL_FilterTypeDD.Value,'movmean')     % Movmean function
                            app = ep_movmean(app,i);
                elseif  strcmp(app.FIL_FilterTypeDD.Value,'median')      % Median function
                            app = ep_movmedian(app,i);
                elseif  strcmp(app.FIL_FilterTypeDD.Value,'Butterworth') % Butterworth function
                            app = ep_butterworth(app,i);
                end

                % Validate or remove returned structure
                if app.rtn
                    app.fil(i) = [];
                    app.rtn    = 0;
                end
                                      
            end

            % If the artefact ID check box is checked
            if app.ART_IDArtefactCheckBox.Value
                
                % Mark to ensure identification of the chosen process [can consider adding a pop-up summarising the listed choices and their contents for confirmation] 
                if contains(app.PT_ListBox.Value,'Artefact')
                    i = app.PT_ListBox.ValueIndex;
                else                
                    % Find app figure
                    allfigs = findall(0,'Type', 'figure'); 
                    app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');

                    % No artefact specified. User needs to define limits
                    figure(app2Handle);
                    uialert(app2Handle,'Select artefacts to reject from the "Select Data" pane.','Warning');
                                                            
                    % Return to Main GUI
                    return    
                end

                % Call desired function
                ep_art_reject(app,i-1)

                % Remove applied artefact rejection from the artefact list and update
                app.art(i-1)    = [];
                app.art_list(i) = [];
                for t = 1:length(app.art_list)
                    if ~strcmp(app.PT_ListBox.Items{t},'Input Data')
                        app.art_list{t} = replaceBetween(app.art_list{t},'_','_',num2str(t-1));
                    end
                end

                if app.ArtefactsCheckBox.Value
                    app.PT_ListBox.Items = app.art_list;
                end
                       
            end


            % If the artefact ID check box is checked
            if app.ART_InterpolateCheckBox.Value
                
                % Mark to ensure identification of the chosen action across variables/components 
                i = 1+size(app.int,1);
                app.int{i,1}.cfg.apa    = app.ART_ApplytoAll.Value;

                % Call desired function
                app = ep_interpolate(app,i);

                % Validate or remove returned structure
                if app.rtn
                    app.int(i) = [];
                    app.rtn    = 0;
                end
                       
            end

            % If the Transform check box is checked
            if app.ART_TransformCheckBox.Value
                
                % Mark to ensure identification of the chosen action across variables/components 
                i = 1+size(app.Tra,1);
                app.Tra{i,1}.cfg.apa    = app.ART_ApplytoAll.Value;

                % Call desired function
                app = ep_transform(app,i);

                % Validate or remove returned structure
                if app.rtn
                    app.Tra(i) = [];
                    app.rtn    = 0;
                end
                       
            end


            % Update plot with new signal data
            ep_updateplot(app,'PROC');
            
        end

        % Button pushed function: EPO_Add
        function EPO_ApplyPushed(app, event)
      
                % Index for the epoch number (instance)
                if isempty(app.epoch)
                    i = 1;
                else
                    i = 1+size(app.epoch,1);
                end

                % Call relevant epoch function
                if      strcmp(app.EPO_ModeListBox.Value,'Event-Related') % Event-related function
                            app = ep_epoch_evr(app,i);
                elseif  strcmp(app.EPO_ModeListBox.Value,'Timepoint')     % Timepoint epoching function
                            app = ep_epoch_tpt(app,i);
                elseif  strcmp(app.EPO_ModeListBox.Value,'Sequential')    % Sequential epoching function
                            app = ep_epoch_seq(app,i);
                elseif  strcmp(app.EPO_ModeListBox.Value,'Event A to B')  % Event A to B function
                            app = ep_epoch_ab(app,i);
                end

                if ~app.rtn

                    % Add epoch to data stack and reorient listbox
                    if app.epoch{i,1}.cfg.apa == 1
                       app.ep_list = [app.ep_list {['Epoch_' num2str(i) '_All' ]}];
                    else
                       app.ep_list = [app.ep_list {['Epoch_' num2str(i) '_' app.ET_SignalDropDown.Value]}];
                    end
    
                    % Update selected layer in stack
                    app.PT_ListBox.Items         = app.ep_list;
                    app.EpochsCheckBox.Value     = 1;
                    app.ArtefactsCheckBox.Value  = 0;
                    app.PT_ListBox.ValueIndex    = i+1;
    
                    ep_updateplot(app,'EPO');

                else

                    % Ensure structure for rejected epoch is cleared
                    app.epoch(i) = [];

                end
                app.rtn = 0; % Reset warning return flag

        end

        % Selection changed function: EVR_SelectEventButtonGroup
        function EVR_SelectEventButtonGroupSelectionChanged(app, event)
            
                % Update list of events based on choice of Tag # or annotation for Event-Related Epoching
                if  app.EVR_TagButton.Value 
                    app.EVR_ListBox.Items = cellstr(num2str(app.dat.Tags{app.e}.Tag));
                else
                    app.EVR_ListBox.Items = app.dat.Tags{app.e}.Annotation;
                end
            
        end

        % Selection changed function: SEQ_SequentialEpochsButtonGroup
        function SEQ_SequentialEpochsButtonGroupSelectionChanged(app, event)
                            
            % Update list of events based on choice of Tag # or annotation for Sequential Epoching
            if  app.SEQ_TagButton.Value
                app.SEQ_event_dropdown.Items = cellstr(num2str(app.dat.Tags{app.e}.Tag));
            else
                app.SEQ_event_dropdown.Items = app.dat.Tags{app.e}.Annotation;
            end

        end

        % Selection changed function: ETP_SelectTimepointButtonGroup
        function ETP_SelectTimepointButtonGroupSelectionChanged(app, event)
            
            % Enable Time or Point setting for timepoint selection
            if  app.ETP_TimeButton.Value
                app.ETP_ep_datepick.Enable = 1;
                app.ETP_ep_datetime.Enable = 1;
                app.ETP_ep_point.Enable    = 0;
            else
                app.ETP_ep_datepick.Enable = 0;
                app.ETP_ep_datetime.Enable = 0;
                app.ETP_ep_point.Enable    = 1;
            end

        end

        % Selection changed function: EA_EventAButtonGroup
        function EA_EventAButtonGroupSelectionChanged(app, event)
                            
            % Update list of events based on choice of Tag # or annotation for Event A
            if  app.EA_TagButton.Value
                app.EA_event_dropdown.Items = cellstr(num2str(app.dat.Tags{app.e}.Tag));
            else
                app.EA_event_dropdown.Items   = app.dat.Tags{app.e}.Annotation;
            end

        end

        % Selection changed function: EB_EventBButtonGroup
        function EB_EventBButtonGroupSelectionChanged(app, event)
            
            % Update list of events based on choice of Tag # or annotation for Event B
            if  app.EB_TagButton.Value
                app.EB_event_dropdown.Items = cellstr(num2str(app.dat.Tags{app.e}.Tag));
            else
                app.EB_event_dropdown.Items   = app.dat.Tags{app.e}.Annotation;
            end   

        end

        % Button pushed function: PT_Delete
        function PT_DeleteButtonPushed(app, event)
            
            % Prevent the deletion of the input data before editing
            if length(app.PT_ListBox.Items) > 1 & ~strcmp(app.PT_ListBox.Value,'Input Data')

                % Index value
                idx = app.PT_ListBox.ValueIndex;

                % Remove selected process from pipeline stack
                if contains(app.PT_ListBox.Value,'Epoch')
                
                    % Remove selected item from pipeline listbox
                    app.PT_ListBox.Items(idx) = [];

                    app.epoch(idx-1)   = [];
                    app.ep_list(idx)   = [];
    
                    % Update epoch listing
                    for t = 1:length(app.PT_ListBox.Items)
                        if ~strcmp(app.PT_ListBox.Items{t},'Input Data')
                            app.PT_ListBox.Items{t} = replaceBetween(app.PT_ListBox.Items{t},'_','_',num2str(t-1));
                        end
                    end
                end

                if contains(app.PT_ListBox.Value,'Artefact')
                    
                    % Remove selected item from pipeline listbox
                    app.PT_ListBox.Items(idx) = [];

                    app.art(idx-1)      = [];
                    app.art_list(idx)   = [];
    
                    % Update artefact listing
                    for t = 1:length(app.PT_ListBox.Items)
                        if ~strcmp(app.PT_ListBox.Items{t},'Input Data')
                            app.PT_ListBox.Items{t} = replaceBetween(app.PT_ListBox.Items{t},'_','_',num2str(t-1));
                        end
                    end
                end

                % Set value to the input data
                app.PT_ListBox.ValueIndex = 1;
                
                % Update plot
                ep_updateplot(app,'EPO');

            end

        end

        % Value changed function: ART_DetrendCheckBox
        function ART_DetrendCheckBoxValueChanged(app, event)
            
            if app.ART_DetrendCheckBox.Value
                app.ART_show_detrend.Value        = 1;
                app.ART_FilterCheckBox.Value      = 0;
                app.ART_IDArtefactCheckBox.Value  = 0;
                app.ART_InterpolateCheckBox.Value = 0;
                app.ART_TransformCheckBox.Value   = 0;
                ART_ArtefactFunctionSelectionChanged(app, event);
            end

        end

        % Value changed function: ART_FilterCheckBox
        function ART_FilterCheckBoxValueChanged(app, event)
                
            if app.ART_FilterCheckBox.Value
                app.ART_show_filter.Value         = 1;
                app.ART_DetrendCheckBox.Value     = 0;
                app.ART_IDArtefactCheckBox.Value  = 0;
                app.ART_InterpolateCheckBox.Value = 0;
                app.ART_TransformCheckBox.Value   = 0;
                ART_ArtefactFunctionSelectionChanged(app, event);
            end
            
        end

        % Value changed function: ART_IDArtefactCheckBox
        function ART_IDArtefactCheckBoxValueChanged(app, event)
                
             if app.ART_IDArtefactCheckBox.Value
                app.ART_show_ID_artefact.Value    = 1;
                app.ART_DetrendCheckBox.Value     = 0;
                app.ART_FilterCheckBox.Value      = 0;
                app.ART_InterpolateCheckBox.Value = 0;
                app.ART_TransformCheckBox.Value   = 0;
                ART_ArtefactFunctionSelectionChanged(app, event);
             end

        end

        % Value changed function: ART_InterpolateCheckBox
        function ART_InterpolateCheckBoxValueChanged(app, event)
                
            if  app.ART_InterpolateCheckBox.Value
                app.ART_show_interpolate.Value    = 1;
                app.ART_DetrendCheckBox.Value     = 0;
                app.ART_FilterCheckBox.Value      = 0;
                app.ART_IDArtefactCheckBox.Value  = 0;
                app.ART_TransformCheckBox.Value   = 0;
                ART_ArtefactFunctionSelectionChanged(app, event);
            end
            
        end

        % Value changed function: ART_TransformCheckBox
        function ART_TransformCheckBoxValueChanged(app, event)
              
            if  app.ART_TransformCheckBox.Value
                app.ART_show_transform.Value      = 1;
                app.ART_DetrendCheckBox.Value     = 0;
                app.ART_FilterCheckBox.Value      = 0;
                app.ART_IDArtefactCheckBox.Value  = 0;
                app.ART_InterpolateCheckBox.Value = 0;
                ART_ArtefactFunctionSelectionChanged(app, event);
            end

        end

        % Button pushed function: PT_ResetButton
        function PT_ResetButtonPushed(app, event)
            
            % Prompt for reset all signals or just the current selected
            answer = questdlg('Reset all signals or just the selected signal?', ...
	                    'Reset Signals', ...
	                    'All',['Selected [' app.ET_SignalDropDown.Value ']'],'Cancel','Cancel');

            % Handle response without resetting the Tags
            switch answer
                case 'All'

                    % Reset the input signal data
                    try
                        app.dat.EDA{app.e}   = app.original_dat.EDA{app.e};
                    end
                    try
                        app.dat.BVP{app.e}   = app.original_dat.BVP{app.e};
                    end
                    try
                        app.dat.SystP{app.e} = app.original_dat.SystP{app.e};
                    end
                    try
                        app.dat.Temp{app.e}  = app.original_dat.Temp{app.e};
                    end
                    try
                        app.dat.ACC{app.e}   = app.original_dat.ACC{app.e};
                    end
                    try
                        app.dat.GYR{app.e}   = app.original_dat.GYR{app.e};
                    end
                    try
                        app.dat.Steps{app.e} = app.original_dat.Steps{app.e};
                    end
                    try
                        app.dat.Other{app.e} = app.original_dat.Other{app.e};
                    end

                    % Reset all artefacts
                    app.art = [];
                    app.rej = [];
                    app.art_list(2:end) = [];

                case ['Selected [' app.ET_SignalDropDown.Value ']']
                    
                    % Reset the input signal data
                    try
                        eval(['app.dat.' app.ET_SignalDropDown.Value '{app.e}   = app.original_dat.' app.ET_SignalDropDown.Value '{app.e};']);
                    end

                    % Reset 'identified' artefacts for the selected signal in batch 'all' artefact
                    idx = find(contains(app.art_list,'All'));
                    for i = 1:length(idx)
                        eval(['app.art{idx(i)-1,1}.dat.' app.ET_SignalDropDown.Value ' = []']);

                        % If artefact structure is now empty, remove
                        tmp_idx = [];
                        if all(structfun(@isempty,app.art{idx(i)-1,1}.dat))
                            app.art{idx(i)-1,1} = [];
                            tmp_idx = idx;
                        end

                        if ~isempty(tmp_idx)
                            app.art_list(tmp_idx) = [];
                        end

                    end

                    % Delete specific artefact associated with the selected signal
                    idx = find(contains(app.art_list,app.ET_SignalDropDown.Value));
                    app.art(idx-1)    = []; % Minus 1 to account for extra list item 'Input Data' when creating idx
                    app.art_list(idx) = [];

                    % Reset 'rejected' artefacts for the selected signal in batch 'all' artefact
                    for i = 1:length(app.rej)
                        eval(['app.rej{i,1}.dat.' app.ET_SignalDropDown.Value ' = []']);

                        % If artefact structure is now empty, remove
                        if all(structfun(@isempty,app.rej{i,1}.dat))
                            app.rej(i,1) = [];
                        end
                    end

                case 'Cancel'
                    % Do nothing
            end

            % Update artefact stack if required
            for t = 1:length(app.art_list)
                if ~strcmp(app.PT_ListBox.Items{t},'Input Data')
                    app.art_list{t} = replaceBetween(app.art_list{t},'_','_',num2str(t-1));
                end
            end

            if app.ArtefactsCheckBox.Value
                app.PT_ListBox.Items = app.art_list;
            end

            % Update plot with new signal data
            ep_updateplot(app,'PROC');

        end

        % Value changed function: PT_ListBox
        function PT_ListBoxValueChanged(app, event)
            
            ep_updateplot(app,'EPO');

        end

        % Button pushed function: PT_SaveButton
        function PT_SaveButtonPushed(app, event)
                       
            % Format and save data
            ep_save_pt(app);

        end

        % Clicked callback: PT_ListBox
        function PT_ListBoxClicked(app, event)
            
            PT_ListBoxValueChanged(app, event);
            
        end

        % Value changed function: OverlayOriginal
        function OverlayOriginalValueChanged(app, event)
            
            if ~isempty(app.dat)
                ep_updateplot(app,'OVR');
            end
            
        end

        % Value changed function: DET_TypeDropDown
        function DET_TypeDropDownValueChanged(app, event)
            
            if strcmp(app.DET_TypeDropDown.Value,'nt_detrend')

                % Enable/Disable extra parameters
                app.PolyDegreeOrderLabel.Text   = 'Degree (Order)';
                app.DET_PolynomialDegree.Value = 0;
                app.DET_Thresh.Enable = 1;
                app.DET_niter.Enable  = 1;

            elseif strcmp(app.DET_TypeDropDown.Value,'sp_tarvainen')

                % Enable/Disable extra parameters
                app.PolyDegreeOrderLabel.Text   = 'Lambda';
                app.DET_PolynomialDegree.Value  = 35; % Working default [seemed ok for empatica despite recommended value in paper to be 10]
                app.DET_Thresh.Enable = 0;
                app.DET_niter.Enable  = 0;
            
            else
                
                % Disable extra parameters
                app.PolyDegreeOrderLabel.Text   = 'Degree (Order)';
                app.DET_PolynomialDegree.Value  = 0;
                app.DET_Thresh.Enable = 0;
                app.DET_niter.Enable  = 0;

            end
            
        end

        % Button pushed function: ARD_plot_artefact
        function ARD_plot_artefactButtonPushed(app, event)
            
            % Mark to ensure identification of the chosen action across variables/components
            if isempty(app.art)
                i = 1;
            else
                i = 1+size(app.art,1);
            end

            % Apply artefact detection
            app = ep_art_thresh(app,i);

            if ~app.rtn

                % Add epoch to data stack and reorient listbox
                if app.art{i,1}.cfg.apa == 1
                   app.art_list = [app.art_list {['Artefact_' num2str(i) '_All' ]}];
                else
                   app.art_list = [app.art_list {['Artefact_' num2str(i) '_' app.ET_SignalDropDown.Value]}];
                end
    
                % Update selected layer in stack
                app.PT_ListBox.Items         = app.art_list;
                app.EpochsCheckBox.Value     = 0;
                app.ArtefactsCheckBox.Value  = 1;
                app.PT_ListBox.ValueIndex    = i+1;
    
                ep_updateplot(app,'ART');

            else

                % Ensure structure for rejected artefact is cleared
                app.art(i) = [];

            end
            app.rtn = 0; % Reset warning return flag

        end

        % Value changed function: ARD_minThreshCheck
        function ARD_minThreshCheckValueChanged(app, event)
            
            if app.ARD_minThreshCheck.Value
                app.ARD_minThreshold.Enable = 1;
            else
                app.ARD_minThreshold.Enable = 0;
            end
            
        end

        % Value changed function: ARD_maxThreshCheck
        function ARD_maxThreshCheckValueChanged(app, event)
            
            if app.ARD_maxThreshCheck.Value
                app.ARD_maxThreshold.Enable = 1;
            else
                app.ARD_maxThreshold.Enable = 0;
            end
            
        end

        % Value changed function: EpochsCheckBox
        function EpochsCheckBoxValueChanged(app, event)
            
            % Refuse uncheck
            if ~app.ArtefactsCheckBox.Value
                app.EpochsCheckBox.Value = 1;
            end

            % Update listbox on check
            if app.EpochsCheckBox.Value
                app.ArtefactsCheckBox.Value = 0;
                app.PT_ListBox.Items        = app.ep_list;
                app.PT_ListBox.ValueIndex   = 1;
            end
                        
            ep_updateplot(app,'EPO');

        end

        % Value changed function: ArtefactsCheckBox
        function ArtefactsCheckBoxValueChanged(app, event)
            
            % Refuse uncheck
            if ~app.EpochsCheckBox.Value
                app.ArtefactsCheckBox.Value = 1;
            end

            % Update listbox on check
            if app.ArtefactsCheckBox.Value
                app.EpochsCheckBox.Value    = 0;
                app.PT_ListBox.Items        = app.art_list;
                app.PT_ListBox.ValueIndex   = 1;
            end
                        
            ep_updateplot(app,'EPO');
            
        end

        % Value changed function: SEQ_ForwardsButton
        function SEQ_ForwardsButtonValueChanged(app, event)
            
                % Change sequential 'mode' on button press
                if ~app.SEQ_ForwardsButton.Value
                    app.SEQ_ForwardsButton.Text = 'Forwards';
                    app.SEQ_ForwardsButton.BackgroundColor = [0.15,0.15,0.15];
                else
                    app.SEQ_ForwardsButton.Text = 'Backwards';
                    app.SEQ_ForwardsButton.BackgroundColor = [0.49,0.18,0.56];
                end

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create LOTUS_analyserUIFigure and hide until all components are created
            app.LOTUS_analyserUIFigure = uifigure('Visible', 'off');
            app.LOTUS_analyserUIFigure.Position = [100 100 1083 616];
            app.LOTUS_analyserUIFigure.Name = 'LOTUS_analyser';
            app.LOTUS_analyserUIFigure.Resize = 'off';
            app.LOTUS_analyserUIFigure.Tag = 'LOTUS_analyser';

            % Create AppTitle
            app.AppTitle = uilabel(app.LOTUS_analyserUIFigure);
            app.AppTitle.BackgroundColor = [0.8 0.8 0.8];
            app.AppTitle.FontSize = 22;
            app.AppTitle.FontWeight = 'bold';
            app.AppTitle.FontColor = [0 0 1];
            app.AppTitle.Position = [6 554 1073 58];
            app.AppTitle.Text = {' LOTUS Analyser'; ' '};

            % Create AuthorLabel
            app.AuthorLabel = uilabel(app.LOTUS_analyserUIFigure);
            app.AuthorLabel.FontSize = 10;
            app.AuthorLabel.FontWeight = 'bold';
            app.AuthorLabel.FontAngle = 'italic';
            app.AuthorLabel.Position = [13 555 81 28];
            app.AuthorLabel.Text = {'Jack Fogarty'; '2024'};

            % Create DarkLabel
            app.DarkLabel = uilabel(app.LOTUS_analyserUIFigure);
            app.DarkLabel.FontSize = 10;
            app.DarkLabel.FontAngle = 'italic';
            app.DarkLabel.FontColor = [0.502 0.502 0.502];
            app.DarkLabel.Position = [1016 583 26 20];
            app.DarkLabel.Text = 'Dark';

            % Create CoolLabel
            app.CoolLabel = uilabel(app.LOTUS_analyserUIFigure);
            app.CoolLabel.FontSize = 10;
            app.CoolLabel.FontAngle = 'italic';
            app.CoolLabel.FontColor = [0.502 0.502 0.502];
            app.CoolLabel.Position = [1016 563 26 22];
            app.CoolLabel.Text = 'Cool';

            % Create DarkSwitch
            app.DarkSwitch = uiswitch(app.LOTUS_analyserUIFigure, 'slider');
            app.DarkSwitch.Items = {'0', '1'};
            app.DarkSwitch.FontSize = 0.01;
            app.DarkSwitch.Position = [1049 588 23 10];
            app.DarkSwitch.Value = '0';

            % Create CoolSwitch
            app.CoolSwitch = uiswitch(app.LOTUS_analyserUIFigure, 'slider');
            app.CoolSwitch.Items = {'0', '1'};
            app.CoolSwitch.FontSize = 0.01;
            app.CoolSwitch.Position = [1049 569 23 10];
            app.CoolSwitch.Value = '0';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.LOTUS_analyserUIFigure);
            app.TabGroup.Position = [7 6 1072 538];

            % Create HomeTab
            app.HomeTab = uitab(app.TabGroup);
            app.HomeTab.Title = 'Home';

            % Create HT_Lotus_c
            app.HT_Lotus_c = uiimage(app.HomeTab);
            app.HT_Lotus_c.ScaleMethod = 'fill';
            app.HT_Lotus_c.Position = [517 249 41 40];
            app.HT_Lotus_c.ImageSource = fullfile(pathToMLAPP, 'images', '3dgifmaker43500.gif');

            % Create HT_Lotus_b
            app.HT_Lotus_b = uiimage(app.HomeTab);
            app.HT_Lotus_b.ScaleMethod = 'fill';
            app.HT_Lotus_b.Position = [501 232 73 74];
            app.HT_Lotus_b.ImageSource = fullfile(pathToMLAPP, 'images', '3dgifmaker37761.gif');

            % Create HT_Lotus_a
            app.HT_Lotus_a = uiimage(app.HomeTab);
            app.HT_Lotus_a.ScaleMethod = 'stretch';
            app.HT_Lotus_a.Position = [466 198 143 143];
            app.HT_Lotus_a.ImageSource = fullfile(pathToMLAPP, 'images', 'LotusT.png');

            % Create HT_Title
            app.HT_Title = uilabel(app.HomeTab);
            app.HT_Title.HorizontalAlignment = 'center';
            app.HT_Title.FontWeight = 'bold';
            app.HT_Title.Position = [378 165 318 22];
            app.HT_Title.Text = 'Longitudinal Timeseries Unification & Signal Analyser';

            % Create EditTagsTab
            app.EditTagsTab = uitab(app.TabGroup);
            app.EditTagsTab.Title = 'Edit Tags';
            app.EditTagsTab.ButtonDownFcn = createCallbackFcn(app, @EditTagsTabButtonDown, true);

            % Create ET_UIAxes
            app.ET_UIAxes = uiaxes(app.EditTagsTab);
            app.ET_UIAxes.YLimitMethod = 'padded';
            app.ET_UIAxes.Position = [64 265 987 204];

            % Create ET_Panel
            app.ET_Panel = uipanel(app.EditTagsTab);
            app.ET_Panel.BackgroundColor = [0.149 0.149 0.149];
            app.ET_Panel.Position = [24 69 331 148];

            % Create ET_TabGroup
            app.ET_TabGroup = uitabgroup(app.ET_Panel);
            app.ET_TabGroup.Position = [5 5 321 138];

            % Create ET_TimeRange
            app.ET_TimeRange = uitab(app.ET_TabGroup);
            app.ET_TimeRange.Title = 'Time Range';
            app.ET_TimeRange.BackgroundColor = [0.9412 0.9412 0.9412];

            % Create ET_SecsLabel
            app.ET_SecsLabel = uilabel(app.ET_TimeRange);
            app.ET_SecsLabel.HorizontalAlignment = 'center';
            app.ET_SecsLabel.FontAngle = 'italic';
            app.ET_SecsLabel.Position = [237 64 32 22];
            app.ET_SecsLabel.Text = 'Secs';

            % Create ET_MinsLabel
            app.ET_MinsLabel = uilabel(app.ET_TimeRange);
            app.ET_MinsLabel.HorizontalAlignment = 'center';
            app.ET_MinsLabel.FontAngle = 'italic';
            app.ET_MinsLabel.Position = [173 64 31 22];
            app.ET_MinsLabel.Text = 'Mins';

            % Create ET_HoursLabel
            app.ET_HoursLabel = uilabel(app.ET_TimeRange);
            app.ET_HoursLabel.HorizontalAlignment = 'center';
            app.ET_HoursLabel.FontAngle = 'italic';
            app.ET_HoursLabel.Position = [108 64 38 22];
            app.ET_HoursLabel.Text = 'Hours';

            % Create ET_StartSec
            app.ET_StartSec = uispinner(app.ET_TimeRange);
            app.ET_StartSec.Limits = [0 59];
            app.ET_StartSec.Enable = 'off';
            app.ET_StartSec.Position = [229 38 49 27];

            % Create ET_StartMin
            app.ET_StartMin = uispinner(app.ET_TimeRange);
            app.ET_StartMin.Limits = [0 59];
            app.ET_StartMin.Enable = 'off';
            app.ET_StartMin.Position = [164 38 49 27];

            % Create ET_StartHour
            app.ET_StartHour = uispinner(app.ET_TimeRange);
            app.ET_StartHour.Limits = [0 23];
            app.ET_StartHour.Enable = 'off';
            app.ET_StartHour.Position = [102 38 49 27];

            % Create ET_StartDay
            app.ET_StartDay = uispinner(app.ET_TimeRange);
            app.ET_StartDay.Limits = [0 1];
            app.ET_StartDay.Enable = 'off';
            app.ET_StartDay.Position = [38 38 49 27];

            % Create ET_Label_c
            app.ET_Label_c = uilabel(app.ET_TimeRange);
            app.ET_Label_c.HorizontalAlignment = 'center';
            app.ET_Label_c.FontWeight = 'bold';
            app.ET_Label_c.Position = [208 40 25 22];
            app.ET_Label_c.Text = ':';

            % Create ET_Label_b
            app.ET_Label_b = uilabel(app.ET_TimeRange);
            app.ET_Label_b.HorizontalAlignment = 'center';
            app.ET_Label_b.FontWeight = 'bold';
            app.ET_Label_b.Position = [144 40 25 22];
            app.ET_Label_b.Text = ':';

            % Create ET_Label_a
            app.ET_Label_a = uilabel(app.ET_TimeRange);
            app.ET_Label_a.HorizontalAlignment = 'center';
            app.ET_Label_a.FontWeight = 'bold';
            app.ET_Label_a.Position = [81 40 25 22];
            app.ET_Label_a.Text = ':';

            % Create ET_DaysLabel
            app.ET_DaysLabel = uilabel(app.ET_TimeRange);
            app.ET_DaysLabel.HorizontalAlignment = 'center';
            app.ET_DaysLabel.FontAngle = 'italic';
            app.ET_DaysLabel.Position = [45 64 33 22];
            app.ET_DaysLabel.Text = 'Days';

            % Create SelectnewtimerangetodisplayontheplotxaxisaboveLabel
            app.SelectnewtimerangetodisplayontheplotxaxisaboveLabel = uilabel(app.ET_TimeRange);
            app.SelectnewtimerangetodisplayontheplotxaxisaboveLabel.FontAngle = 'italic';
            app.SelectnewtimerangetodisplayontheplotxaxisaboveLabel.FontColor = [0 0 1];
            app.SelectnewtimerangetodisplayontheplotxaxisaboveLabel.Position = [7 86 316 22];
            app.SelectnewtimerangetodisplayontheplotxaxisaboveLabel.Text = 'Select new time range to display on the plot x-axis above.';

            % Create ET_AutoButton
            app.ET_AutoButton = uibutton(app.ET_TimeRange, 'push');
            app.ET_AutoButton.BackgroundColor = [1 1 1];
            app.ET_AutoButton.Position = [237 8 71 22];
            app.ET_AutoButton.Text = 'Auto';

            % Create ET_AddTags
            app.ET_AddTags = uitab(app.ET_TabGroup);
            app.ET_AddTags.Title = 'Add Tags';
            app.ET_AddTags.BackgroundColor = [0.9412 0.9412 0.9412];

            % Create ET_AddTagsGrid
            app.ET_AddTagsGrid = uigridlayout(app.ET_AddTags);
            app.ET_AddTagsGrid.ColumnWidth = {'100x', '100x', '100x', '100x', '100x', '100x', '100x', '100x', '100x', '100x', '100x'};
            app.ET_AddTagsGrid.RowHeight = {24, 25, '100x', 25};
            app.ET_AddTagsGrid.ColumnSpacing = 5.5;
            app.ET_AddTagsGrid.RowSpacing = 4;
            app.ET_AddTagsGrid.Padding = [5.5 4 5.5 4];

            % Create TagAddInst
            app.TagAddInst = uilabel(app.ET_AddTagsGrid);
            app.TagAddInst.FontAngle = 'italic';
            app.TagAddInst.FontColor = [0 0 1];
            app.TagAddInst.Layout.Row = 1;
            app.TagAddInst.Layout.Column = [1 11];
            app.TagAddInst.Text = 'Add new tag date and time in 24h format (e.g. 13:34:04).';

            % Create ET_NewTagms
            app.ET_NewTagms = uispinner(app.ET_AddTagsGrid);
            app.ET_NewTagms.Layout.Row = 4;
            app.ET_NewTagms.Layout.Column = [8 9];

            % Create ET_NewTagS
            app.ET_NewTagS = uispinner(app.ET_AddTagsGrid);
            app.ET_NewTagS.Layout.Row = 4;
            app.ET_NewTagS.Layout.Column = [6 7];

            % Create ET_NewTagM
            app.ET_NewTagM = uispinner(app.ET_AddTagsGrid);
            app.ET_NewTagM.Layout.Row = 4;
            app.ET_NewTagM.Layout.Column = [4 5];

            % Create ET_NewTagH
            app.ET_NewTagH = uispinner(app.ET_AddTagsGrid);
            app.ET_NewTagH.Layout.Row = 4;
            app.ET_NewTagH.Layout.Column = [2 3];

            % Create ET_DatePicker
            app.ET_DatePicker = uidatepicker(app.ET_AddTagsGrid);
            app.ET_DatePicker.Layout.Row = 2;
            app.ET_DatePicker.Layout.Column = [3 6];

            % Create ET_msLabel
            app.ET_msLabel = uilabel(app.ET_AddTagsGrid);
            app.ET_msLabel.HorizontalAlignment = 'center';
            app.ET_msLabel.VerticalAlignment = 'bottom';
            app.ET_msLabel.FontAngle = 'italic';
            app.ET_msLabel.Layout.Row = 3;
            app.ET_msLabel.Layout.Column = [8 9];
            app.ET_msLabel.Text = 'ms';

            % Create ET_secLabel
            app.ET_secLabel = uilabel(app.ET_AddTagsGrid);
            app.ET_secLabel.HorizontalAlignment = 'center';
            app.ET_secLabel.VerticalAlignment = 'bottom';
            app.ET_secLabel.FontAngle = 'italic';
            app.ET_secLabel.Layout.Row = 3;
            app.ET_secLabel.Layout.Column = [6 7];
            app.ET_secLabel.Text = 'sec';

            % Create ET_minLabel
            app.ET_minLabel = uilabel(app.ET_AddTagsGrid);
            app.ET_minLabel.HorizontalAlignment = 'center';
            app.ET_minLabel.VerticalAlignment = 'bottom';
            app.ET_minLabel.FontAngle = 'italic';
            app.ET_minLabel.Layout.Row = 3;
            app.ET_minLabel.Layout.Column = [4 5];
            app.ET_minLabel.Text = 'min';

            % Create ET_hourLabel
            app.ET_hourLabel = uilabel(app.ET_AddTagsGrid);
            app.ET_hourLabel.HorizontalAlignment = 'center';
            app.ET_hourLabel.VerticalAlignment = 'bottom';
            app.ET_hourLabel.FontAngle = 'italic';
            app.ET_hourLabel.Layout.Row = 3;
            app.ET_hourLabel.Layout.Column = [2 3];
            app.ET_hourLabel.Text = 'hour';

            % Create ET_DateLabel
            app.ET_DateLabel = uilabel(app.ET_AddTagsGrid);
            app.ET_DateLabel.HorizontalAlignment = 'center';
            app.ET_DateLabel.FontAngle = 'italic';
            app.ET_DateLabel.Layout.Row = 2;
            app.ET_DateLabel.Layout.Column = [1 2];
            app.ET_DateLabel.Text = 'Date';

            % Create ET_AddButton
            app.ET_AddButton = uibutton(app.ET_AddTagsGrid, 'push');
            app.ET_AddButton.ButtonPushedFcn = createCallbackFcn(app, @ET_AddButtonPushed, true);
            app.ET_AddButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.ET_AddButton.FontWeight = 'bold';
            app.ET_AddButton.Layout.Row = 4;
            app.ET_AddButton.Layout.Column = [10 11];
            app.ET_AddButton.Text = 'Add';

            % Create ET_RemoveTags
            app.ET_RemoveTags = uitab(app.ET_TabGroup);
            app.ET_RemoveTags.Title = 'Remove Tags';
            app.ET_RemoveTags.BackgroundColor = [0.9412 0.9412 0.9412];

            % Create TagListBoxLabel
            app.TagListBoxLabel = uilabel(app.ET_RemoveTags);
            app.TagListBoxLabel.HorizontalAlignment = 'right';
            app.TagListBoxLabel.Position = [8 58 35 22];
            app.TagListBoxLabel.Text = 'Tag #';

            % Create ET_DeleteButton
            app.ET_DeleteButton = uibutton(app.ET_RemoveTags, 'push');
            app.ET_DeleteButton.ButtonPushedFcn = createCallbackFcn(app, @ET_DeleteButtonPushed, true);
            app.ET_DeleteButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.ET_DeleteButton.Position = [237 8 71 22];
            app.ET_DeleteButton.Text = 'Delete';

            % Create ET_TagListBox
            app.ET_TagListBox = uilistbox(app.ET_RemoveTags);
            app.ET_TagListBox.Multiselect = 'on';
            app.ET_TagListBox.Position = [58 8 100 74];
            app.ET_TagListBox.Value = {'Item 1'};

            % Create ET_TimeWindowInst
            app.ET_TimeWindowInst = uilabel(app.ET_RemoveTags);
            app.ET_TimeWindowInst.FontAngle = 'italic';
            app.ET_TimeWindowInst.FontColor = [0 0 1];
            app.ET_TimeWindowInst.Position = [7 86 259 22];
            app.ET_TimeWindowInst.Text = 'Select and delete tags (refer to table for Tag #).';

            % Create ET_Overwrite
            app.ET_Overwrite = uicheckbox(app.EditTagsTab);
            app.ET_Overwrite.Text = 'Overwrite input on ''Save''';
            app.ET_Overwrite.Position = [30 38 193 22];

            % Create ET_LoadNextOnSave
            app.ET_LoadNextOnSave = uicheckbox(app.EditTagsTab);
            app.ET_LoadNextOnSave.Text = 'Load next dataset on ''Save''';
            app.ET_LoadNextOnSave.Position = [30 11 169 22];
            app.ET_LoadNextOnSave.Value = true;

            % Create ET_TotalTagsLabel
            app.ET_TotalTagsLabel = uilabel(app.EditTagsTab);
            app.ET_TotalTagsLabel.FontColor = [0.6353 0.0784 0.1843];
            app.ET_TotalTagsLabel.Position = [833 222 112 22];
            app.ET_TotalTagsLabel.Text = 'Total Tags:';

            % Create ET_EditEventTagsLabel
            app.ET_EditEventTagsLabel = uilabel(app.EditTagsTab);
            app.ET_EditEventTagsLabel.HorizontalAlignment = 'center';
            app.ET_EditEventTagsLabel.FontSize = 16;
            app.ET_EditEventTagsLabel.FontWeight = 'bold';
            app.ET_EditEventTagsLabel.Position = [606 222 124 22];
            app.ET_EditEventTagsLabel.Text = 'Edit Event Tags';

            % Create ET_UITable
            app.ET_UITable = uitable(app.EditTagsTab);
            app.ET_UITable.ColumnName = {'Tag'; 'File Time (UTC)'; 'File Datetime'; 'Tag Datetime'; 'Annotation'};
            app.ET_UITable.RowName = {};
            app.ET_UITable.ColumnEditable = [true true true true true];
            app.ET_UITable.CellEditCallback = createCallbackFcn(app, @ET_UITableCellEdit, true);
            app.ET_UITable.Position = [373 11 594 206];

            % Create ET_SignalDropDown
            app.ET_SignalDropDown = uidropdown(app.EditTagsTab);
            app.ET_SignalDropDown.ValueChangedFcn = createCallbackFcn(app, @ET_SignalDropDownValueChanged, true);
            app.ET_SignalDropDown.BackgroundColor = [1 1 1];
            app.ET_SignalDropDown.Position = [401 477 104 22];

            % Create ET_FileUp
            app.ET_FileUp = uibutton(app.EditTagsTab, 'push');
            app.ET_FileUp.ButtonPushedFcn = createCallbackFcn(app, @ET_FileUpButtonPushed, true);
            app.ET_FileUp.BackgroundColor = [0.9294 0.6941 0.1255];
            app.ET_FileUp.FontWeight = 'bold';
            app.ET_FileUp.Position = [341 477 46 22];
            app.ET_FileUp.Text = '>';

            % Create ET_FileDwn
            app.ET_FileDwn = uibutton(app.EditTagsTab, 'push');
            app.ET_FileDwn.ButtonPushedFcn = createCallbackFcn(app, @ET_FileDwnButtonPushed, true);
            app.ET_FileDwn.BackgroundColor = [0.9294 0.6941 0.1255];
            app.ET_FileDwn.FontWeight = 'bold';
            app.ET_FileDwn.Position = [226 477 46 22];
            app.ET_FileDwn.Text = '<';

            % Create ET_filen
            app.ET_filen = uieditfield(app.EditTagsTab, 'numeric');
            app.ET_filen.HorizontalAlignment = 'center';
            app.ET_filen.FontSize = 14;
            app.ET_filen.BackgroundColor = [1 0.9373 0.7882];
            app.ET_filen.Position = [282 477 49 22];

            % Create ET_FileDropDwn
            app.ET_FileDropDwn = uidropdown(app.EditTagsTab);
            app.ET_FileDropDwn.ValueChangedFcn = createCallbackFcn(app, @ET_FileDropDwnValueChanged, true);
            app.ET_FileDropDwn.BackgroundColor = [1 1 1];
            app.ET_FileDropDwn.Position = [108 477 104 22];

            % Create ET_BigStepUp
            app.ET_BigStepUp = uibutton(app.EditTagsTab, 'push');
            app.ET_BigStepUp.ButtonPushedFcn = createCallbackFcn(app, @ET_BigStepUpButtonPushed, true);
            app.ET_BigStepUp.BackgroundColor = [0.302 0.7451 0.9333];
            app.ET_BigStepUp.FontWeight = 'bold';
            app.ET_BigStepUp.Position = [273 230 46 22];
            app.ET_BigStepUp.Text = '>>';

            % Create ET_SmallStepUp
            app.ET_SmallStepUp = uibutton(app.EditTagsTab, 'push');
            app.ET_SmallStepUp.ButtonPushedFcn = createCallbackFcn(app, @ET_SmallStepUpButtonPushed, true);
            app.ET_SmallStepUp.BackgroundColor = [0.302 0.7451 0.9333];
            app.ET_SmallStepUp.FontWeight = 'bold';
            app.ET_SmallStepUp.Position = [221 230 46 22];
            app.ET_SmallStepUp.Text = '>';

            % Create ET_SmallStepDwn
            app.ET_SmallStepDwn = uibutton(app.EditTagsTab, 'push');
            app.ET_SmallStepDwn.ButtonPushedFcn = createCallbackFcn(app, @ET_SmallStepDwnButtonPushed, true);
            app.ET_SmallStepDwn.BackgroundColor = [0.302 0.7451 0.9333];
            app.ET_SmallStepDwn.FontWeight = 'bold';
            app.ET_SmallStepDwn.Position = [141 230 46 22];
            app.ET_SmallStepDwn.Text = '<';

            % Create ET_BigStepDwn
            app.ET_BigStepDwn = uibutton(app.EditTagsTab, 'push');
            app.ET_BigStepDwn.ButtonPushedFcn = createCallbackFcn(app, @ET_BigStepDwnButtonPushed, true);
            app.ET_BigStepDwn.BackgroundColor = [0.302 0.7451 0.9333];
            app.ET_BigStepDwn.FontWeight = 'bold';
            app.ET_BigStepDwn.Position = [89 230 46 22];
            app.ET_BigStepDwn.Text = '<<';

            % Create ET_YDwn
            app.ET_YDwn = uibutton(app.EditTagsTab, 'push');
            app.ET_YDwn.ButtonPushedFcn = createCallbackFcn(app, @ET_YDwnButtonPushed, true);
            app.ET_YDwn.IconAlignment = 'center';
            app.ET_YDwn.BackgroundColor = [0.302 0.7451 0.9333];
            app.ET_YDwn.Position = [27 288 22 22];
            app.ET_YDwn.Text = '-';

            % Create ET_YUp
            app.ET_YUp = uibutton(app.EditTagsTab, 'push');
            app.ET_YUp.ButtonPushedFcn = createCallbackFcn(app, @ET_YUpButtonPushed, true);
            app.ET_YUp.IconAlignment = 'center';
            app.ET_YUp.BackgroundColor = [0.302 0.7451 0.9333];
            app.ET_YUp.Position = [27 340 22 22];
            app.ET_YUp.Text = '+';

            % Create ET_Save
            app.ET_Save = uibutton(app.EditTagsTab, 'push');
            app.ET_Save.ButtonPushedFcn = createCallbackFcn(app, @ET_SaveButtonPushed, true);
            app.ET_Save.BackgroundColor = [0 1 0];
            app.ET_Save.Position = [986 13 71 22];
            app.ET_Save.Text = 'Save';

            % Create ET_Reset
            app.ET_Reset = uibutton(app.EditTagsTab, 'push');
            app.ET_Reset.ButtonPushedFcn = createCallbackFcn(app, @ET_ResetButtonPushed, true);
            app.ET_Reset.BackgroundColor = [0 1 1];
            app.ET_Reset.Position = [986 44 71 22];
            app.ET_Reset.Text = 'Reset';

            % Create ET_Apply
            app.ET_Apply = uibutton(app.EditTagsTab, 'push');
            app.ET_Apply.ButtonPushedFcn = createCallbackFcn(app, @ET_ApplyButtonPushed, true);
            app.ET_Apply.BackgroundColor = [1 1 1];
            app.ET_Apply.Position = [986 76 71 22];
            app.ET_Apply.Text = 'Apply';

            % Create ET_Browse
            app.ET_Browse = uibutton(app.EditTagsTab, 'push');
            app.ET_Browse.ButtonPushedFcn = createCallbackFcn(app, @ET_BrowseButtonPushed, true);
            app.ET_Browse.BackgroundColor = [1 1 1];
            app.ET_Browse.FontWeight = 'bold';
            app.ET_Browse.Position = [23 477 71 22];
            app.ET_Browse.Text = 'Browse';

            % Create ET_Yreset
            app.ET_Yreset = uibutton(app.EditTagsTab, 'push');
            app.ET_Yreset.ButtonPushedFcn = createCallbackFcn(app, @ET_YresetButtonPushed, true);
            app.ET_Yreset.IconAlignment = 'center';
            app.ET_Yreset.BackgroundColor = [0.8 0.8 0.8];
            app.ET_Yreset.FontSize = 10;
            app.ET_Yreset.Position = [27 314 22 22];
            app.ET_Yreset.Text = 'RY';

            % Create ET_Xreset
            app.ET_Xreset = uibutton(app.EditTagsTab, 'push');
            app.ET_Xreset.ButtonPushedFcn = createCallbackFcn(app, @ET_XresetButtonPushed, true);
            app.ET_Xreset.IconAlignment = 'center';
            app.ET_Xreset.BackgroundColor = [0.8 0.8 0.8];
            app.ET_Xreset.FontSize = 10;
            app.ET_Xreset.Position = [193 230 22 22];
            app.ET_Xreset.Text = 'RX';

            % Create OverlayOriginal
            app.OverlayOriginal = uicheckbox(app.EditTagsTab);
            app.OverlayOriginal.ValueChangedFcn = createCallbackFcn(app, @OverlayOriginalValueChanged, true);
            app.OverlayOriginal.Text = 'Overlay Original';
            app.OverlayOriginal.Position = [519 477 108 22];

            % Create PreprocessTab
            app.PreprocessTab = uitab(app.TabGroup);
            app.PreprocessTab.Title = 'Preprocess Data';
            app.PreprocessTab.BackgroundColor = [0.9412 0.9412 0.9412];
            app.PreprocessTab.ButtonDownFcn = createCallbackFcn(app, @PreprocessTabButtonDown, true);

            % Create PT_ArtefactsPanel
            app.PT_ArtefactsPanel = uipanel(app.PreprocessTab);
            app.PT_ArtefactsPanel.Title = 'Detrend, Filter, and Correct Artefacts';
            app.PT_ArtefactsPanel.BackgroundColor = [0.902 0.902 0.902];
            app.PT_ArtefactsPanel.FontWeight = 'bold';
            app.PT_ArtefactsPanel.Position = [159 13 325 202];

            % Create PT_ArtefactTab
            app.PT_ArtefactTab = uitabgroup(app.PT_ArtefactsPanel);
            app.PT_ArtefactTab.Position = [0 0 325 182];

            % Create PT_EDAArtefactTab
            app.PT_EDAArtefactTab = uitab(app.PT_ArtefactTab);
            app.PT_EDAArtefactTab.Title = 'EDA';

            % Create PT_BVPArtefactTab
            app.PT_BVPArtefactTab = uitab(app.PT_ArtefactTab);
            app.PT_BVPArtefactTab.Title = 'BVP';

            % Create PT_SystPArtefactTab
            app.PT_SystPArtefactTab = uitab(app.PT_ArtefactTab);
            app.PT_SystPArtefactTab.Title = 'SystP';

            % Create PT_ACCArtefactTab
            app.PT_ACCArtefactTab = uitab(app.PT_ArtefactTab);
            app.PT_ACCArtefactTab.Title = 'ACC';

            % Create PT_TempArtefactTab
            app.PT_TempArtefactTab = uitab(app.PT_ArtefactTab);
            app.PT_TempArtefactTab.Title = 'Temp';

            % Create PT_EpochDataPanel
            app.PT_EpochDataPanel = uipanel(app.PreprocessTab);
            app.PT_EpochDataPanel.Title = 'Epoch Data';
            app.PT_EpochDataPanel.BackgroundColor = [0.902 0.902 0.902];
            app.PT_EpochDataPanel.FontWeight = 'bold';
            app.PT_EpochDataPanel.Position = [496 13 325 202];

            % Create PT_EpochTabGroup
            app.PT_EpochTabGroup = uitabgroup(app.PT_EpochDataPanel);
            app.PT_EpochTabGroup.Position = [0 0 325 182];

            % Create PT_EDAEpochTab
            app.PT_EDAEpochTab = uitab(app.PT_EpochTabGroup);
            app.PT_EDAEpochTab.Title = 'EDA';

            % Create PT_BVPEpochTab
            app.PT_BVPEpochTab = uitab(app.PT_EpochTabGroup);
            app.PT_BVPEpochTab.Title = 'BVP';

            % Create PT_SystPEpochTab
            app.PT_SystPEpochTab = uitab(app.PT_EpochTabGroup);
            app.PT_SystPEpochTab.Title = 'SystP';

            % Create PT_ACCEpochTab
            app.PT_ACCEpochTab = uitab(app.PT_EpochTabGroup);
            app.PT_ACCEpochTab.Title = 'ACC';

            % Create PT_TempEpochTab
            app.PT_TempEpochTab = uitab(app.PT_EpochTabGroup);
            app.PT_TempEpochTab.Title = 'Temp';

            % Create PT_ResampleDataPanel
            app.PT_ResampleDataPanel = uipanel(app.PreprocessTab);
            app.PT_ResampleDataPanel.Title = 'Resample Data';
            app.PT_ResampleDataPanel.BackgroundColor = [0.902 0.902 0.902];
            app.PT_ResampleDataPanel.FontWeight = 'bold';
            app.PT_ResampleDataPanel.Position = [13 14 135 201];

            % Create RES_ResampletoHzLabel
            app.RES_ResampletoHzLabel = uilabel(app.PT_ResampleDataPanel);
            app.RES_ResampletoHzLabel.FontAngle = 'italic';
            app.RES_ResampletoHzLabel.FontColor = [0 0 1];
            app.RES_ResampletoHzLabel.Position = [5 126 91 22];
            app.RES_ResampletoHzLabel.Text = 'Resample to Hz';

            % Create HzEditFieldLabel
            app.HzEditFieldLabel = uilabel(app.PT_ResampleDataPanel);
            app.HzEditFieldLabel.HorizontalAlignment = 'center';
            app.HzEditFieldLabel.Position = [49 105 25 22];
            app.HzEditFieldLabel.Text = 'Hz';

            % Create RES_HzEdit
            app.RES_HzEdit = uieditfield(app.PT_ResampleDataPanel, 'numeric');
            app.RES_HzEdit.Position = [8 105 43 22];

            % Create RES_label
            app.RES_label = uilabel(app.PT_ResampleDataPanel);
            app.RES_label.WordWrap = 'on';
            app.RES_label.Position = [4 142 130 42];
            app.RES_label.Text = 'Selected data has a sample rate of: ';

            % Create RES_Add
            app.RES_Add = uibutton(app.PT_ResampleDataPanel, 'push');
            app.RES_Add.ButtonPushedFcn = createCallbackFcn(app, @RES_ApplyPushed, true);
            app.RES_Add.BackgroundColor = [0.9412 0.9412 0.9412];
            app.RES_Add.Position = [8 5 51 23];
            app.RES_Add.Text = 'Apply';

            % Create RES_Hz_label
            app.RES_Hz_label = uilabel(app.PT_ResampleDataPanel);
            app.RES_Hz_label.FontWeight = 'bold';
            app.RES_Hz_label.FontColor = [1 0 0];
            app.RES_Hz_label.Position = [88 144 40 22];
            app.RES_Hz_label.Text = 'XX Hz';

            % Create RES_Interp
            app.RES_Interp = uidropdown(app.PT_ResampleDataPanel);
            app.RES_Interp.Items = {'linear', 'spline', 'pchip', 'makima'};
            app.RES_Interp.Position = [5 60 98 22];
            app.RES_Interp.Value = 'makima';

            % Create RES_ApplytoAll
            app.RES_ApplytoAll = uicheckbox(app.PT_ResampleDataPanel);
            app.RES_ApplytoAll.Tooltip = {'Apply selected function to all signals.'};
            app.RES_ApplytoAll.Text = 'Apply to all';
            app.RES_ApplytoAll.FontSize = 11;
            app.RES_ApplytoAll.FontColor = [0.6353 0.0784 0.1843];
            app.RES_ApplytoAll.Position = [5 34 76 22];

            % Create RES_InterpolationTypeLabel
            app.RES_InterpolationTypeLabel = uilabel(app.PT_ResampleDataPanel);
            app.RES_InterpolationTypeLabel.FontAngle = 'italic';
            app.RES_InterpolationTypeLabel.FontColor = [0 0 1];
            app.RES_InterpolationTypeLabel.Position = [5 81 100 22];
            app.RES_InterpolationTypeLabel.Text = 'Interpolation Type';

            % Create PT_SaveButton
            app.PT_SaveButton = uibutton(app.PreprocessTab, 'push');
            app.PT_SaveButton.ButtonPushedFcn = createCallbackFcn(app, @PT_SaveButtonPushed, true);
            app.PT_SaveButton.BackgroundColor = [0 1 0];
            app.PT_SaveButton.Position = [986 13 71 22];
            app.PT_SaveButton.Text = 'Save';

            % Create PT_ResetButton
            app.PT_ResetButton = uibutton(app.PreprocessTab, 'push');
            app.PT_ResetButton.ButtonPushedFcn = createCallbackFcn(app, @PT_ResetButtonPushed, true);
            app.PT_ResetButton.BackgroundColor = [0 1 1];
            app.PT_ResetButton.Position = [986 44 71 22];
            app.PT_ResetButton.Text = 'Reset';

            % Create PT_PipelinePanel
            app.PT_PipelinePanel = uipanel(app.PreprocessTab);
            app.PT_PipelinePanel.Title = 'Select Data';
            app.PT_PipelinePanel.BackgroundColor = [0.902 0.902 0.902];
            app.PT_PipelinePanel.FontWeight = 'bold';
            app.PT_PipelinePanel.Position = [833 13 142 202];

            % Create PT_Delete
            app.PT_Delete = uibutton(app.PT_PipelinePanel, 'push');
            app.PT_Delete.ButtonPushedFcn = createCallbackFcn(app, @PT_DeleteButtonPushed, true);
            app.PT_Delete.BackgroundColor = [1 0.4118 0.1608];
            app.PT_Delete.Position = [78 8 56 22];
            app.PT_Delete.Text = 'Delete';

            % Create PT_ListBox
            app.PT_ListBox = uilistbox(app.PT_PipelinePanel);
            app.PT_ListBox.Items = {'Input Data'};
            app.PT_ListBox.ValueChangedFcn = createCallbackFcn(app, @PT_ListBoxValueChanged, true);
            app.PT_ListBox.ClickedFcn = createCallbackFcn(app, @PT_ListBoxClicked, true);
            app.PT_ListBox.Position = [7 35 128 119];
            app.PT_ListBox.Value = 'Input Data';

            % Create HideButton
            app.HideButton = uibutton(app.PT_PipelinePanel, 'state');
            app.HideButton.Text = 'Hide';
            app.HideButton.Position = [7 8 56 22];

            % Create EpochsCheckBox
            app.EpochsCheckBox = uicheckbox(app.PT_PipelinePanel);
            app.EpochsCheckBox.ValueChangedFcn = createCallbackFcn(app, @EpochsCheckBoxValueChanged, true);
            app.EpochsCheckBox.Text = 'Epochs';
            app.EpochsCheckBox.Position = [7 157 62 22];
            app.EpochsCheckBox.Value = true;

            % Create ArtefactsCheckBox
            app.ArtefactsCheckBox = uicheckbox(app.PT_PipelinePanel);
            app.ArtefactsCheckBox.ValueChangedFcn = createCallbackFcn(app, @ArtefactsCheckBoxValueChanged, true);
            app.ArtefactsCheckBox.Text = 'Artefacts';
            app.ArtefactsCheckBox.Position = [71 157 69 22];

            % Create xlsxCheckBox
            app.xlsxCheckBox = uicheckbox(app.PreprocessTab);
            app.xlsxCheckBox.Text = '.xlsx';
            app.xlsxCheckBox.Position = [986 76 46 22];

            % Create matCheckBox
            app.matCheckBox = uicheckbox(app.PreprocessTab);
            app.matCheckBox.Text = '.mat';
            app.matCheckBox.Position = [986 99 45 22];
            app.matCheckBox.Value = true;

            % Create ExportTypeLabel
            app.ExportTypeLabel = uilabel(app.PreprocessTab);
            app.ExportTypeLabel.Position = [986 123 69 22];
            app.ExportTypeLabel.Text = 'Export Type';

            % Create ART_ArtefactFunction
            app.ART_ArtefactFunction = uibuttongroup(app.PreprocessTab);
            app.ART_ArtefactFunction.SelectionChangedFcn = createCallbackFcn(app, @ART_ArtefactFunctionSelectionChanged, true);
            app.ART_ArtefactFunction.Title = 'Functions';
            app.ART_ArtefactFunction.Position = [164 45 125 122];

            % Create ART_show_detrend
            app.ART_show_detrend = uitogglebutton(app.ART_ArtefactFunction);
            app.ART_show_detrend.Tag = 'B1';
            app.ART_show_detrend.IconAlignment = 'top';
            app.ART_show_detrend.Text = '◙';
            app.ART_show_detrend.FontSize = 8;
            app.ART_show_detrend.Position = [101 81 18 18];
            app.ART_show_detrend.Value = true;

            % Create ART_show_filter
            app.ART_show_filter = uitogglebutton(app.ART_ArtefactFunction);
            app.ART_show_filter.Tag = 'B2';
            app.ART_show_filter.IconAlignment = 'center';
            app.ART_show_filter.Text = '◙';
            app.ART_show_filter.BackgroundColor = [0.9608 0.9608 0.9608];
            app.ART_show_filter.FontSize = 8;
            app.ART_show_filter.Position = [101 61 18 18];

            % Create ART_show_ID_artefact
            app.ART_show_ID_artefact = uitogglebutton(app.ART_ArtefactFunction);
            app.ART_show_ID_artefact.Tag = 'B3';
            app.ART_show_ID_artefact.IconAlignment = 'center';
            app.ART_show_ID_artefact.Text = '◙';
            app.ART_show_ID_artefact.FontSize = 8;
            app.ART_show_ID_artefact.Position = [101 41 18 18];

            % Create ART_show_interpolate
            app.ART_show_interpolate = uitogglebutton(app.ART_ArtefactFunction);
            app.ART_show_interpolate.Tag = 'B4';
            app.ART_show_interpolate.IconAlignment = 'center';
            app.ART_show_interpolate.Text = '◙';
            app.ART_show_interpolate.FontSize = 8;
            app.ART_show_interpolate.Position = [101 22 18 18];

            % Create ART_show_transform
            app.ART_show_transform = uitogglebutton(app.ART_ArtefactFunction);
            app.ART_show_transform.Tag = 'B5';
            app.ART_show_transform.IconAlignment = 'center';
            app.ART_show_transform.Text = '◙';
            app.ART_show_transform.FontSize = 8;
            app.ART_show_transform.Position = [101 2 18 18];

            % Create ART_DetrendCheckBox
            app.ART_DetrendCheckBox = uicheckbox(app.ART_ArtefactFunction);
            app.ART_DetrendCheckBox.ValueChangedFcn = createCallbackFcn(app, @ART_DetrendCheckBoxValueChanged, true);
            app.ART_DetrendCheckBox.Text = 'Detrend';
            app.ART_DetrendCheckBox.Position = [6 80 65 22];

            % Create ART_FilterCheckBox
            app.ART_FilterCheckBox = uicheckbox(app.ART_ArtefactFunction);
            app.ART_FilterCheckBox.ValueChangedFcn = createCallbackFcn(app, @ART_FilterCheckBoxValueChanged, true);
            app.ART_FilterCheckBox.Text = 'Filter';
            app.ART_FilterCheckBox.Position = [6 60 49 22];

            % Create ART_IDArtefactCheckBox
            app.ART_IDArtefactCheckBox = uicheckbox(app.ART_ArtefactFunction);
            app.ART_IDArtefactCheckBox.ValueChangedFcn = createCallbackFcn(app, @ART_IDArtefactCheckBoxValueChanged, true);
            app.ART_IDArtefactCheckBox.Text = 'ID Artefact';
            app.ART_IDArtefactCheckBox.Position = [6 40 78 22];

            % Create ART_InterpolateCheckBox
            app.ART_InterpolateCheckBox = uicheckbox(app.ART_ArtefactFunction);
            app.ART_InterpolateCheckBox.ValueChangedFcn = createCallbackFcn(app, @ART_InterpolateCheckBoxValueChanged, true);
            app.ART_InterpolateCheckBox.Text = 'Interpolate';
            app.ART_InterpolateCheckBox.Position = [6 20 79 22];

            % Create ART_TransformCheckBox
            app.ART_TransformCheckBox = uicheckbox(app.ART_ArtefactFunction);
            app.ART_TransformCheckBox.ValueChangedFcn = createCallbackFcn(app, @ART_TransformCheckBoxValueChanged, true);
            app.ART_TransformCheckBox.Text = 'Transform';
            app.ART_TransformCheckBox.Position = [6 1 76 22];

            % Create ART_Add
            app.ART_Add = uibutton(app.PreprocessTab, 'push');
            app.ART_Add.ButtonPushedFcn = createCallbackFcn(app, @ART_ApplyPushed, true);
            app.ART_Add.BackgroundColor = [0.9412 0.9412 0.9412];
            app.ART_Add.Position = [164 19 51 23];
            app.ART_Add.Text = 'Apply';

            % Create ART_ArtefactDetectionPanel
            app.ART_ArtefactDetectionPanel = uipanel(app.PreprocessTab);
            app.ART_ArtefactDetectionPanel.TitlePosition = 'centertop';
            app.ART_ArtefactDetectionPanel.Title = 'Artefact Detection';
            app.ART_ArtefactDetectionPanel.Visible = 'off';
            app.ART_ArtefactDetectionPanel.BackgroundColor = [0.8588 0.9412 0.9686];
            app.ART_ArtefactDetectionPanel.FontWeight = 'bold';
            app.ART_ArtefactDetectionPanel.Position = [297 17 182 150];

            % Create ArtefactPaddingLabel
            app.ArtefactPaddingLabel = uilabel(app.ART_ArtefactDetectionPanel);
            app.ArtefactPaddingLabel.HorizontalAlignment = 'right';
            app.ArtefactPaddingLabel.Position = [45 5 82 22];
            app.ArtefactPaddingLabel.Text = 'Padding (sec):';

            % Create ARD_ArtefactPadding
            app.ARD_ArtefactPadding = uieditfield(app.ART_ArtefactDetectionPanel, 'numeric');
            app.ARD_ArtefactPadding.HorizontalAlignment = 'center';
            app.ARD_ArtefactPadding.Position = [134 4 44 22];

            % Create ARD_plot_artefact
            app.ARD_plot_artefact = uibutton(app.ART_ArtefactDetectionPanel, 'push');
            app.ARD_plot_artefact.ButtonPushedFcn = createCallbackFcn(app, @ARD_plot_artefactButtonPushed, true);
            app.ARD_plot_artefact.BackgroundColor = [0.302 0.7451 0.9333];
            app.ARD_plot_artefact.Position = [4 4 40 23];
            app.ARD_plot_artefact.Text = 'Plot';

            % Create ArtefactPaddingLabel_2
            app.ArtefactPaddingLabel_2 = uilabel(app.ART_ArtefactDetectionPanel);
            app.ArtefactPaddingLabel_2.HorizontalAlignment = 'right';
            app.ArtefactPaddingLabel_2.Position = [4 30 123 22];
            app.ArtefactPaddingLabel_2.Text = 'Moving Window (sec):';

            % Create ARD_ArtefactWindow
            app.ARD_ArtefactWindow = uieditfield(app.ART_ArtefactDetectionPanel, 'numeric');
            app.ARD_ArtefactWindow.HorizontalAlignment = 'center';
            app.ARD_ArtefactWindow.Position = [134 30 44 22];

            % Create ARD_minThreshold
            app.ARD_minThreshold = uieditfield(app.ART_ArtefactDetectionPanel, 'numeric');
            app.ARD_minThreshold.HorizontalAlignment = 'center';
            app.ARD_minThreshold.Enable = 'off';
            app.ARD_minThreshold.Position = [134 55 44 22];

            % Create ARD_maxThreshold
            app.ARD_maxThreshold = uieditfield(app.ART_ArtefactDetectionPanel, 'numeric');
            app.ARD_maxThreshold.HorizontalAlignment = 'center';
            app.ARD_maxThreshold.Position = [134 80 44 22];

            % Create CriteriaLabel
            app.CriteriaLabel = uilabel(app.ART_ArtefactDetectionPanel);
            app.CriteriaLabel.HorizontalAlignment = 'right';
            app.CriteriaLabel.Position = [29 105 44 22];
            app.CriteriaLabel.Text = 'Criteria';

            % Create ARD_Criteria
            app.ARD_Criteria = uidropdown(app.ART_ArtefactDetectionPanel);
            app.ARD_Criteria.Items = {'amplitude', 'Zscore', 'Variance', 'SD', 'Slope'};
            app.ARD_Criteria.Position = [78 105 100 22];
            app.ARD_Criteria.Value = 'amplitude';

            % Create ARD_maxThreshCheck
            app.ARD_maxThreshCheck = uicheckbox(app.ART_ArtefactDetectionPanel);
            app.ARD_maxThreshCheck.ValueChangedFcn = createCallbackFcn(app, @ARD_maxThreshCheckValueChanged, true);
            app.ARD_maxThreshCheck.Text = '';
            app.ARD_maxThreshCheck.Position = [115 80 15 22];
            app.ARD_maxThreshCheck.Value = true;

            % Create ARD_minThreshCheck
            app.ARD_minThreshCheck = uicheckbox(app.ART_ArtefactDetectionPanel);
            app.ARD_minThreshCheck.ValueChangedFcn = createCallbackFcn(app, @ARD_minThreshCheckValueChanged, true);
            app.ARD_minThreshCheck.Text = '';
            app.ARD_minThreshCheck.Position = [115 55 15 22];

            % Create ARD_minThreshlabel
            app.ARD_minThreshlabel = uilabel(app.ART_ArtefactDetectionPanel);
            app.ARD_minThreshlabel.HorizontalAlignment = 'right';
            app.ARD_minThreshlabel.Position = [45 55 65 22];
            app.ARD_minThreshlabel.Text = 'minThresh:';

            % Create ARD_maxThreshlabel
            app.ARD_maxThreshlabel = uilabel(app.ART_ArtefactDetectionPanel);
            app.ARD_maxThreshlabel.HorizontalAlignment = 'right';
            app.ARD_maxThreshlabel.Position = [42 80 68 22];
            app.ARD_maxThreshlabel.Text = 'maxThresh:';

            % Create ART_FilterDataPanel
            app.ART_FilterDataPanel = uipanel(app.PreprocessTab);
            app.ART_FilterDataPanel.TitlePosition = 'centertop';
            app.ART_FilterDataPanel.Title = 'Filter Data';
            app.ART_FilterDataPanel.Visible = 'off';
            app.ART_FilterDataPanel.BackgroundColor = [0.8588 0.9412 0.9686];
            app.ART_FilterDataPanel.FontWeight = 'bold';
            app.ART_FilterDataPanel.Position = [298 17 182 150];

            % Create TypeDropDownLabel
            app.TypeDropDownLabel = uilabel(app.ART_FilterDataPanel);
            app.TypeDropDownLabel.HorizontalAlignment = 'right';
            app.TypeDropDownLabel.Position = [41 105 32 22];
            app.TypeDropDownLabel.Text = 'Type';

            % Create FIL_FilterTypeDD
            app.FIL_FilterTypeDD = uidropdown(app.ART_FilterDataPanel);
            app.FIL_FilterTypeDD.Items = {'movmean', 'median', 'Butterworth'};
            app.FIL_FilterTypeDD.Position = [78 105 100 22];
            app.FIL_FilterTypeDD.Value = 'movmean';

            % Create WindowLengthPtsEditFieldLabel
            app.WindowLengthPtsEditFieldLabel = uilabel(app.ART_FilterDataPanel);
            app.WindowLengthPtsEditFieldLabel.HorizontalAlignment = 'right';
            app.WindowLengthPtsEditFieldLabel.Position = [17 79 117 22];
            app.WindowLengthPtsEditFieldLabel.Text = 'Window Length (Pts)';

            % Create FIL_FilterWindowPts
            app.FIL_FilterWindowPts = uieditfield(app.ART_FilterDataPanel, 'numeric');
            app.FIL_FilterWindowPts.HorizontalAlignment = 'center';
            app.FIL_FilterWindowPts.Position = [138 79 40 22];

            % Create HighpasscutoffHzEditFieldLabel
            app.HighpasscutoffHzEditFieldLabel = uilabel(app.ART_FilterDataPanel);
            app.HighpasscutoffHzEditFieldLabel.HorizontalAlignment = 'right';
            app.HighpasscutoffHzEditFieldLabel.Position = [12 54 122 22];
            app.HighpasscutoffHzEditFieldLabel.Text = 'High-pass cut-off (Hz)';

            % Create FIL_Highpasscutoff
            app.FIL_Highpasscutoff = uieditfield(app.ART_FilterDataPanel, 'numeric');
            app.FIL_Highpasscutoff.HorizontalAlignment = 'center';
            app.FIL_Highpasscutoff.Position = [138 54 40 22];

            % Create LowpasscutoffHzEditFieldLabel
            app.LowpasscutoffHzEditFieldLabel = uilabel(app.ART_FilterDataPanel);
            app.LowpasscutoffHzEditFieldLabel.HorizontalAlignment = 'right';
            app.LowpasscutoffHzEditFieldLabel.Position = [15 29 119 22];
            app.LowpasscutoffHzEditFieldLabel.Text = 'Low-pass cut-off (Hz)';

            % Create FIL_Lowpasscutoff
            app.FIL_Lowpasscutoff = uieditfield(app.ART_FilterDataPanel, 'numeric');
            app.FIL_Lowpasscutoff.HorizontalAlignment = 'center';
            app.FIL_Lowpasscutoff.Position = [138 29 40 22];

            % Create FilterorderEditFieldLabel
            app.FilterorderEditFieldLabel = uilabel(app.ART_FilterDataPanel);
            app.FilterorderEditFieldLabel.HorizontalAlignment = 'right';
            app.FilterorderEditFieldLabel.Position = [70 4 64 22];
            app.FilterorderEditFieldLabel.Text = 'Filter order';

            % Create FIL_FilterOrder
            app.FIL_FilterOrder = uieditfield(app.ART_FilterDataPanel, 'numeric');
            app.FIL_FilterOrder.HorizontalAlignment = 'center';
            app.FIL_FilterOrder.Position = [138 4 40 22];

            % Create FIL_Notch
            app.FIL_Notch = uicheckbox(app.ART_FilterDataPanel);
            app.FIL_Notch.Text = 'Notch';
            app.FIL_Notch.FontColor = [1 0.4118 0.1608];
            app.FIL_Notch.Position = [7 4 54 22];

            % Create ART_InterpolateDataPanel
            app.ART_InterpolateDataPanel = uipanel(app.PreprocessTab);
            app.ART_InterpolateDataPanel.TitlePosition = 'centertop';
            app.ART_InterpolateDataPanel.Title = 'Interpolate Data';
            app.ART_InterpolateDataPanel.Visible = 'off';
            app.ART_InterpolateDataPanel.BackgroundColor = [0.8588 0.9412 0.9686];
            app.ART_InterpolateDataPanel.FontWeight = 'bold';
            app.ART_InterpolateDataPanel.Position = [298 17 182 150];

            % Create TypeDropDown_2Label
            app.TypeDropDown_2Label = uilabel(app.ART_InterpolateDataPanel);
            app.TypeDropDown_2Label.HorizontalAlignment = 'right';
            app.TypeDropDown_2Label.Position = [41 105 32 22];
            app.TypeDropDown_2Label.Text = 'Type';

            % Create INT_TypeDropDown
            app.INT_TypeDropDown = uidropdown(app.ART_InterpolateDataPanel);
            app.INT_TypeDropDown.Items = {'previous', 'next', 'nearest', 'linear', 'spline', 'pchip', 'makima', 'movmean', 'movmedian'};
            app.INT_TypeDropDown.Position = [78 105 100 22];
            app.INT_TypeDropDown.Value = 'makima';

            % Create ScalarvalueEditFieldLabel
            app.ScalarvalueEditFieldLabel = uilabel(app.ART_InterpolateDataPanel);
            app.ScalarvalueEditFieldLabel.HorizontalAlignment = 'right';
            app.ScalarvalueEditFieldLabel.Position = [62 54 72 22];
            app.ScalarvalueEditFieldLabel.Text = 'Scalar value';

            % Create INT_Scalarvalue
            app.INT_Scalarvalue = uieditfield(app.ART_InterpolateDataPanel, 'numeric');
            app.INT_Scalarvalue.HorizontalAlignment = 'center';
            app.INT_Scalarvalue.Position = [138 54 40 22];

            % Create WindowLengthPtsEditField_2Label
            app.WindowLengthPtsEditField_2Label = uilabel(app.ART_InterpolateDataPanel);
            app.WindowLengthPtsEditField_2Label.HorizontalAlignment = 'right';
            app.WindowLengthPtsEditField_2Label.Position = [17 29 117 22];
            app.WindowLengthPtsEditField_2Label.Text = 'Window Length (Pts)';

            % Create INT_WindowLengthPts
            app.INT_WindowLengthPts = uieditfield(app.ART_InterpolateDataPanel, 'numeric');
            app.INT_WindowLengthPts.HorizontalAlignment = 'center';
            app.INT_WindowLengthPts.Position = [138 29 40 22];

            % Create MaxGapEditFieldLabel
            app.MaxGapEditFieldLabel = uilabel(app.ART_InterpolateDataPanel);
            app.MaxGapEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxGapEditFieldLabel.Position = [83 4 51 22];
            app.MaxGapEditFieldLabel.Text = 'MaxGap';

            % Create INT_MaxGap
            app.INT_MaxGap = uieditfield(app.ART_InterpolateDataPanel, 'numeric');
            app.INT_MaxGap.HorizontalAlignment = 'center';
            app.INT_MaxGap.Position = [138 4 40 22];

            % Create EndValuesDropDownLabel
            app.EndValuesDropDownLabel = uilabel(app.ART_InterpolateDataPanel);
            app.EndValuesDropDownLabel.HorizontalAlignment = 'right';
            app.EndValuesDropDownLabel.Position = [7 80 66 22];
            app.EndValuesDropDownLabel.Text = 'End Values';

            % Create INT_EndValuesDropDown
            app.INT_EndValuesDropDown = uidropdown(app.ART_InterpolateDataPanel);
            app.INT_EndValuesDropDown.Items = {'extrap', 'previous', 'next', 'nearest', 'none', 'scalar'};
            app.INT_EndValuesDropDown.Position = [78 80 100 22];
            app.INT_EndValuesDropDown.Value = 'none';

            % Create ART_TransformDataPanel
            app.ART_TransformDataPanel = uipanel(app.PreprocessTab);
            app.ART_TransformDataPanel.TitlePosition = 'centertop';
            app.ART_TransformDataPanel.Title = 'Transform Data';
            app.ART_TransformDataPanel.Visible = 'off';
            app.ART_TransformDataPanel.BackgroundColor = [0.8588 0.9412 0.9686];
            app.ART_TransformDataPanel.FontWeight = 'bold';
            app.ART_TransformDataPanel.Position = [298 17 182 150];

            % Create ZscoreCheckBox
            app.ZscoreCheckBox = uicheckbox(app.ART_TransformDataPanel);
            app.ZscoreCheckBox.Text = 'Z score';
            app.ZscoreCheckBox.Position = [8 104 62 22];

            % Create Log10CheckBox
            app.Log10CheckBox = uicheckbox(app.ART_TransformDataPanel);
            app.Log10CheckBox.Enable = 'off';
            app.Log10CheckBox.Text = 'Log10';
            app.Log10CheckBox.Position = [8 80 55 22];

            % Create ArtefactPaddingLabel_5
            app.ArtefactPaddingLabel_5 = uilabel(app.ART_TransformDataPanel);
            app.ArtefactPaddingLabel_5.HorizontalAlignment = 'right';
            app.ArtefactPaddingLabel_5.Position = [3 58 123 22];
            app.ArtefactPaddingLabel_5.Text = 'Moving Window (sec):';

            % Create TransformWindow
            app.TransformWindow = uieditfield(app.ART_TransformDataPanel, 'numeric');
            app.TransformWindow.HorizontalAlignment = 'center';
            app.TransformWindow.Position = [133 58 44 22];

            % Create ART_DetrendDataPanel
            app.ART_DetrendDataPanel = uipanel(app.PreprocessTab);
            app.ART_DetrendDataPanel.TitlePosition = 'centertop';
            app.ART_DetrendDataPanel.Title = 'Detrend Data';
            app.ART_DetrendDataPanel.BackgroundColor = [0.8588 0.9412 0.9686];
            app.ART_DetrendDataPanel.FontWeight = 'bold';
            app.ART_DetrendDataPanel.Position = [298 17 182 150];

            % Create PolyDegreeOrderLabel
            app.PolyDegreeOrderLabel = uilabel(app.ART_DetrendDataPanel);
            app.PolyDegreeOrderLabel.HorizontalAlignment = 'right';
            app.PolyDegreeOrderLabel.Position = [8 78 125 22];
            app.PolyDegreeOrderLabel.Text = 'Degree (Order)';

            % Create DET_PolynomialDegree
            app.DET_PolynomialDegree = uieditfield(app.ART_DetrendDataPanel, 'numeric');
            app.DET_PolynomialDegree.HorizontalAlignment = 'center';
            app.DET_PolynomialDegree.Position = [138 78 39 22];

            % Create ThresholdforOutliersLabel
            app.ThresholdforOutliersLabel = uilabel(app.ART_DetrendDataPanel);
            app.ThresholdforOutliersLabel.HorizontalAlignment = 'right';
            app.ThresholdforOutliersLabel.Position = [12 52 121 22];
            app.ThresholdforOutliersLabel.Text = 'Outlier Thresh (in SD)';

            % Create DET_Thresh
            app.DET_Thresh = uieditfield(app.ART_DetrendDataPanel, 'numeric');
            app.DET_Thresh.HorizontalAlignment = 'center';
            app.DET_Thresh.Enable = 'off';
            app.DET_Thresh.Position = [138 52 39 22];
            app.DET_Thresh.Value = 3;

            % Create FunctionLabel
            app.FunctionLabel = uilabel(app.ART_DetrendDataPanel);
            app.FunctionLabel.HorizontalAlignment = 'right';
            app.FunctionLabel.Position = [3 104 51 22];
            app.FunctionLabel.Text = 'Function';

            % Create DET_TypeDropDown
            app.DET_TypeDropDown = uidropdown(app.ART_DetrendDataPanel);
            app.DET_TypeDropDown.Items = {'detrend', 'nt_detrend', 'sp_tarvainen'};
            app.DET_TypeDropDown.ValueChangedFcn = createCallbackFcn(app, @DET_TypeDropDownValueChanged, true);
            app.DET_TypeDropDown.Position = [60 104 117 22];
            app.DET_TypeDropDown.Value = 'detrend';

            % Create DET_nanflag
            app.DET_nanflag = uicheckbox(app.ART_DetrendDataPanel);
            app.DET_nanflag.Text = 'omitnan';
            app.DET_nanflag.FontColor = [1 0.4118 0.1608];
            app.DET_nanflag.Position = [3 1 65 22];
            app.DET_nanflag.Value = true;

            % Create ThresholdLabel
            app.ThresholdLabel = uilabel(app.ART_DetrendDataPanel);
            app.ThresholdLabel.HorizontalAlignment = 'right';
            app.ThresholdLabel.Position = [9 26 124 22];
            app.ThresholdLabel.Text = 'Number of Iterations';

            % Create DET_niter
            app.DET_niter = uieditfield(app.ART_DetrendDataPanel, 'numeric');
            app.DET_niter.HorizontalAlignment = 'center';
            app.DET_niter.Enable = 'off';
            app.DET_niter.Position = [138 26 39 22];
            app.DET_niter.Value = 3;

            % Create ART_ApplytoAll
            app.ART_ApplytoAll = uicheckbox(app.PreprocessTab);
            app.ART_ApplytoAll.Tooltip = {'Apply selected function to all signals.'};
            app.ART_ApplytoAll.Text = 'Apply to all';
            app.ART_ApplytoAll.WordWrap = 'on';
            app.ART_ApplytoAll.FontSize = 11;
            app.ART_ApplytoAll.FontColor = [0.6353 0.0784 0.1843];
            app.ART_ApplytoAll.Position = [219 20 77 22];

            % Create EPO_Add
            app.EPO_Add = uibutton(app.PreprocessTab, 'push');
            app.EPO_Add.ButtonPushedFcn = createCallbackFcn(app, @EPO_ApplyPushed, true);
            app.EPO_Add.BackgroundColor = [0.9412 0.9412 0.9412];
            app.EPO_Add.Position = [503 19 51 23];
            app.EPO_Add.Text = 'Apply';

            % Create EPO_ModeListBox
            app.EPO_ModeListBox = uilistbox(app.PreprocessTab);
            app.EPO_ModeListBox.Items = {'Event-Related', 'Timepoint', 'Sequential', 'Event A to B'};
            app.EPO_ModeListBox.ValueChangedFcn = createCallbackFcn(app, @EPO_ModeListBoxValueChanged, true);
            app.EPO_ModeListBox.Position = [503 89 103 77];
            app.EPO_ModeListBox.Value = 'Event-Related';

            % Create EPO_ApplytoAll
            app.EPO_ApplytoAll = uicheckbox(app.PreprocessTab);
            app.EPO_ApplytoAll.Tooltip = {'Apply selected function to all signals.'};
            app.EPO_ApplytoAll.Text = 'Apply to all';
            app.EPO_ApplytoAll.WordWrap = 'on';
            app.EPO_ApplytoAll.FontSize = 11;
            app.EPO_ApplytoAll.FontColor = [0.6353 0.0784 0.1843];
            app.EPO_ApplytoAll.Position = [503 65 103 22];

            % Create EA_EventAButtonGroup
            app.EA_EventAButtonGroup = uibuttongroup(app.PreprocessTab);
            app.EA_EventAButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @EA_EventAButtonGroupSelectionChanged, true);
            app.EA_EventAButtonGroup.Title = 'Event A';
            app.EA_EventAButtonGroup.BackgroundColor = [0.8588 0.9412 0.9686];
            app.EA_EventAButtonGroup.Position = [612 94 205 72];

            % Create EA_TagButton
            app.EA_TagButton = uiradiobutton(app.EA_EventAButtonGroup);
            app.EA_TagButton.Text = 'Tag #';
            app.EA_TagButton.Position = [9 26 58 22];
            app.EA_TagButton.Value = true;

            % Create EA_AnnotationButton
            app.EA_AnnotationButton = uiradiobutton(app.EA_EventAButtonGroup);
            app.EA_AnnotationButton.Text = 'Annotation';
            app.EA_AnnotationButton.Position = [9 4 80 22];

            % Create EA_event_dropdown
            app.EA_event_dropdown = uidropdown(app.EA_EventAButtonGroup);
            app.EA_event_dropdown.BackgroundColor = [0.9412 0.9412 0.9412];
            app.EA_event_dropdown.Position = [88 26 110 22];

            % Create EB_EventBButtonGroup
            app.EB_EventBButtonGroup = uibuttongroup(app.PreprocessTab);
            app.EB_EventBButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @EB_EventBButtonGroupSelectionChanged, true);
            app.EB_EventBButtonGroup.Title = 'Event B';
            app.EB_EventBButtonGroup.BackgroundColor = [0.8588 0.9686 0.9216];
            app.EB_EventBButtonGroup.Position = [612 18 205 72];

            % Create EB_TagButton
            app.EB_TagButton = uiradiobutton(app.EB_EventBButtonGroup);
            app.EB_TagButton.Text = 'Tag #';
            app.EB_TagButton.Position = [9 26 58 22];
            app.EB_TagButton.Value = true;

            % Create EB_AnnotationButton
            app.EB_AnnotationButton = uiradiobutton(app.EB_EventBButtonGroup);
            app.EB_AnnotationButton.Text = 'Annotation';
            app.EB_AnnotationButton.Position = [9 4 80 22];

            % Create EB_event_dropdown
            app.EB_event_dropdown = uidropdown(app.EB_EventBButtonGroup);
            app.EB_event_dropdown.BackgroundColor = [0.9412 0.9412 0.9412];
            app.EB_event_dropdown.Position = [88 26 110 22];

            % Create SEQ_SequentialEpochsButtonGroup
            app.SEQ_SequentialEpochsButtonGroup = uibuttongroup(app.PreprocessTab);
            app.SEQ_SequentialEpochsButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @SEQ_SequentialEpochsButtonGroupSelectionChanged, true);
            app.SEQ_SequentialEpochsButtonGroup.Title = 'Sequential Epochs';
            app.SEQ_SequentialEpochsButtonGroup.BackgroundColor = [0.9686 0.9098 0.8588];
            app.SEQ_SequentialEpochsButtonGroup.Position = [612 18 205 147];

            % Create SEQ_TagButton
            app.SEQ_TagButton = uiradiobutton(app.SEQ_SequentialEpochsButtonGroup);
            app.SEQ_TagButton.Text = 'Tag #';
            app.SEQ_TagButton.Position = [9 100 80 22];
            app.SEQ_TagButton.Value = true;

            % Create SEQ_AnnotationButton
            app.SEQ_AnnotationButton = uiradiobutton(app.SEQ_SequentialEpochsButtonGroup);
            app.SEQ_AnnotationButton.Text = 'Annotation';
            app.SEQ_AnnotationButton.Position = [9 79 88 22];

            % Create SEQ_epoch_overlap
            app.SEQ_epoch_overlap = uieditfield(app.SEQ_SequentialEpochsButtonGroup, 'numeric');
            app.SEQ_epoch_overlap.HorizontalAlignment = 'center';
            app.SEQ_epoch_overlap.Position = [158 4 43 22];

            % Create SEQ_window_length
            app.SEQ_window_length = uieditfield(app.SEQ_SequentialEpochsButtonGroup, 'numeric');
            app.SEQ_window_length.HorizontalAlignment = 'center';
            app.SEQ_window_length.Position = [158 28 43 22];

            % Create SEQ_overlap_label
            app.SEQ_overlap_label = uilabel(app.SEQ_SequentialEpochsButtonGroup);
            app.SEQ_overlap_label.Position = [88 4 73 22];
            app.SEQ_overlap_label.Text = 'Overlap (%):';

            % Create SEQ_event_dropdown
            app.SEQ_event_dropdown = uidropdown(app.SEQ_SequentialEpochsButtonGroup);
            app.SEQ_event_dropdown.Position = [95 100 106 22];

            % Create SEQ_N_epochs
            app.SEQ_N_epochs = uieditfield(app.SEQ_SequentialEpochsButtonGroup, 'numeric');
            app.SEQ_N_epochs.HorizontalAlignment = 'center';
            app.SEQ_N_epochs.Position = [158 52 43 22];

            % Create SEQ_length_label
            app.SEQ_length_label = uilabel(app.SEQ_SequentialEpochsButtonGroup);
            app.SEQ_length_label.Position = [27 28 134 22];
            app.SEQ_length_label.Text = 'Length of Epochs (Sec):';

            % Create SEQ_N_epochs_label
            app.SEQ_N_epochs_label = uilabel(app.SEQ_SequentialEpochsButtonGroup);
            app.SEQ_N_epochs_label.Position = [53 52 108 22];
            app.SEQ_N_epochs_label.Text = 'Number of Epochs:';

            % Create SEQ_ForwardsButton
            app.SEQ_ForwardsButton = uibutton(app.SEQ_SequentialEpochsButtonGroup, 'state');
            app.SEQ_ForwardsButton.ValueChangedFcn = createCallbackFcn(app, @SEQ_ForwardsButtonValueChanged, true);
            app.SEQ_ForwardsButton.Text = 'Forwards';
            app.SEQ_ForwardsButton.BackgroundColor = [0.149 0.149 0.149];
            app.SEQ_ForwardsButton.FontColor = [1 1 1];
            app.SEQ_ForwardsButton.Position = [5 4 66 22];

            % Create ETP_SelectTimepointButtonGroup
            app.ETP_SelectTimepointButtonGroup = uibuttongroup(app.PreprocessTab);
            app.ETP_SelectTimepointButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ETP_SelectTimepointButtonGroupSelectionChanged, true);
            app.ETP_SelectTimepointButtonGroup.Title = 'Select Timepoint';
            app.ETP_SelectTimepointButtonGroup.BackgroundColor = [0.8588 0.9686 0.9216];
            app.ETP_SelectTimepointButtonGroup.Position = [612 18 205 147];

            % Create ETP_PostLabel
            app.ETP_PostLabel = uilabel(app.ETP_SelectTimepointButtonGroup);
            app.ETP_PostLabel.HorizontalAlignment = 'center';
            app.ETP_PostLabel.FontAngle = 'italic';
            app.ETP_PostLabel.Position = [164 26 30 17];
            app.ETP_PostLabel.Text = 'Post';

            % Create ETP_PostEditField
            app.ETP_PostEditField = uieditfield(app.ETP_SelectTimepointButtonGroup, 'numeric');
            app.ETP_PostEditField.HorizontalAlignment = 'center';
            app.ETP_PostEditField.Position = [157 4 43 22];

            % Create ETP_to
            app.ETP_to = uilabel(app.ETP_SelectTimepointButtonGroup);
            app.ETP_to.HorizontalAlignment = 'center';
            app.ETP_to.Position = [134 4 25 22];
            app.ETP_to.Text = 'to';

            % Create ETP_PreEditField
            app.ETP_PreEditField = uieditfield(app.ETP_SelectTimepointButtonGroup, 'numeric');
            app.ETP_PreEditField.HorizontalAlignment = 'center';
            app.ETP_PreEditField.Position = [95 4 43 22];

            % Create ETP_PreLabel
            app.ETP_PreLabel = uilabel(app.ETP_SelectTimepointButtonGroup);
            app.ETP_PreLabel.HorizontalAlignment = 'center';
            app.ETP_PreLabel.FontAngle = 'italic';
            app.ETP_PreLabel.Position = [104 26 25 17];
            app.ETP_PreLabel.Text = 'Pre';

            % Create ETP_epoch_label
            app.ETP_epoch_label = uilabel(app.ETP_SelectTimepointButtonGroup);
            app.ETP_epoch_label.Position = [8 4 88 22];
            app.ETP_epoch_label.Text = 'Epoch (sec/pts)';

            % Create ETP_ep_datepick
            app.ETP_ep_datepick = uidatepicker(app.ETP_SelectTimepointButtonGroup);
            app.ETP_ep_datepick.Position = [95 97 105 25];

            % Create ETP_ep_datetime
            app.ETP_ep_datetime = uieditfield(app.ETP_SelectTimepointButtonGroup, 'text');
            app.ETP_ep_datetime.HorizontalAlignment = 'right';
            app.ETP_ep_datetime.Placeholder = 'HH:mm:ss.SSS';
            app.ETP_ep_datetime.Position = [95 73 105 22];

            % Create ETP_TimeButton
            app.ETP_TimeButton = uiradiobutton(app.ETP_SelectTimepointButtonGroup);
            app.ETP_TimeButton.Text = 'Time';
            app.ETP_TimeButton.Position = [9 101 59 22];
            app.ETP_TimeButton.Value = true;

            % Create ETP_PointButton
            app.ETP_PointButton = uiradiobutton(app.ETP_SelectTimepointButtonGroup);
            app.ETP_PointButton.Enable = 'off';
            app.ETP_PointButton.Text = 'Point';
            app.ETP_PointButton.Position = [9 79 51 22];

            % Create ETP_ep_point
            app.ETP_ep_point = uieditfield(app.ETP_SelectTimepointButtonGroup, 'numeric');
            app.ETP_ep_point.Position = [95 49 105 22];

            % Create EVR_SelectEventButtonGroup
            app.EVR_SelectEventButtonGroup = uibuttongroup(app.PreprocessTab);
            app.EVR_SelectEventButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @EVR_SelectEventButtonGroupSelectionChanged, true);
            app.EVR_SelectEventButtonGroup.Title = 'Select Event';
            app.EVR_SelectEventButtonGroup.BackgroundColor = [0.8588 0.9412 0.9686];
            app.EVR_SelectEventButtonGroup.Position = [612 18 205 147];

            % Create EVR_TagButton
            app.EVR_TagButton = uiradiobutton(app.EVR_SelectEventButtonGroup);
            app.EVR_TagButton.Text = 'Tag #';
            app.EVR_TagButton.Position = [8 101 58 22];
            app.EVR_TagButton.Value = true;

            % Create EVR_AnnotationButton
            app.EVR_AnnotationButton = uiradiobutton(app.EVR_SelectEventButtonGroup);
            app.EVR_AnnotationButton.Text = 'Annotation';
            app.EVR_AnnotationButton.Position = [8 79 80 22];

            % Create EVR_PostLabel
            app.EVR_PostLabel = uilabel(app.EVR_SelectEventButtonGroup);
            app.EVR_PostLabel.HorizontalAlignment = 'center';
            app.EVR_PostLabel.FontAngle = 'italic';
            app.EVR_PostLabel.Position = [164 26 30 17];
            app.EVR_PostLabel.Text = 'Post';

            % Create EVR_to
            app.EVR_to = uilabel(app.EVR_SelectEventButtonGroup);
            app.EVR_to.HorizontalAlignment = 'center';
            app.EVR_to.Position = [135 4 25 22];
            app.EVR_to.Text = 'to';

            % Create EVR_PreLabel
            app.EVR_PreLabel = uilabel(app.EVR_SelectEventButtonGroup);
            app.EVR_PreLabel.HorizontalAlignment = 'center';
            app.EVR_PreLabel.FontAngle = 'italic';
            app.EVR_PreLabel.Position = [104 26 25 17];
            app.EVR_PreLabel.Text = 'Pre';

            % Create EVR_ListBox
            app.EVR_ListBox = uilistbox(app.EVR_SelectEventButtonGroup);
            app.EVR_ListBox.Position = [96 50 105 74];

            % Create EVR_epoch_label
            app.EVR_epoch_label = uilabel(app.EVR_SelectEventButtonGroup);
            app.EVR_epoch_label.Position = [11 4 82 22];
            app.EVR_epoch_label.Text = 'Epoch (in sec)';

            % Create EVR_PostEditField
            app.EVR_PostEditField = uieditfield(app.EVR_SelectEventButtonGroup, 'numeric');
            app.EVR_PostEditField.AllowEmpty = 'on';
            app.EVR_PostEditField.HorizontalAlignment = 'center';
            app.EVR_PostEditField.Position = [158 4 43 22];

            % Create EVR_PreEditField
            app.EVR_PreEditField = uieditfield(app.EVR_SelectEventButtonGroup, 'numeric');
            app.EVR_PreEditField.AllowEmpty = 'on';
            app.EVR_PreEditField.HorizontalAlignment = 'center';
            app.EVR_PreEditField.Position = [94 4 43 22];

            % Create AnalysesTab
            app.AnalysesTab = uitab(app.TabGroup);
            app.AnalysesTab.Title = 'Analyses';

            % Create SynchronyTab
            app.SynchronyTab = uitab(app.TabGroup);
            app.SynchronyTab.Title = 'Synchrony';

            % Show the figure after all components are created
            app.LOTUS_analyserUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = LOTUS_analyser

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.LOTUS_analyserUIFigure)

                % Execute the startup function
                runStartupFcn(app, @startupFcn)
            else

                % Focus the running singleton app
                figure(runningApp.LOTUS_analyserUIFigure)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.LOTUS_analyserUIFigure)
        end
    end
end