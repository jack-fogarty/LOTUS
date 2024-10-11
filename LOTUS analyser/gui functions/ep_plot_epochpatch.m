%% LOTUS: Plot Patch over Selected Epochs
%  Copyright (C) (2024) Jack Fogarty

function ep_plot_epochpatch(app)

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
    
    % Prelim
    m = 2; % Multiplier for big step buffer for plotting large signal data
        
    % Modifiable buffer for signal data plotting
    buffer = app.big*m;

    % Remove any epoch patches previously plotted
    delete(findobj(app.ET_UIAxes.Children, 'type', 'Patch'));

    % Select to plot the patch for the epoch or the artefact
    if contains(app.PT_ListBox.Value,'Epoch')
        idx = str2double(extractBetween(app.PT_ListBox.Value,'_','_'));
                       
        % Check epoch fields
        sig = fieldnames(app.epoch{idx,1}.dat);
        sig = sig(~structfun(@isempty,app.epoch{idx,1}.dat) & ~strcmp(sig,'Tags') & ~strcmp(sig,'Summary'));

        if any(ismember(sig,app.ET_SignalDropDown.Value))
            if any(strcmp(app.epoch{idx,1}.cfg.type,{'Event-Related','Event A to B'}))

                % Get start and end times
                A_tmp = eval(['app.epoch{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.local_time(1)']);
                B_tmp = eval(['app.epoch{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.local_time(end)']);

                % Draw relevant patch if it fits in axes limits
                if A_tmp >= app.ET_UIAxes.XLim(1) && A_tmp <= app.ET_UIAxes.XLim(2) || B_tmp >= app.ET_UIAxes.XLim(1) && B_tmp <= app.ET_UIAxes.XLim(2) 
                    hold(app.ET_UIAxes,  'on');
                    h = fill(app.ET_UIAxes,[A_tmp B_tmp B_tmp A_tmp],[min(app.ET_UIAxes.YLim) min(app.ET_UIAxes.YLim) max(app.ET_UIAxes.YLim) max(app.ET_UIAxes.YLim)],'green','FaceAlpha',0.08,'LineStyle','none', 'YLimInclude','off'); % Setting arbitrary limits for rectangle that are likely 'off-screen'
                    uistack(h,'bottom');
                    hold(app.ET_UIAxes, 'off');
                end

            elseif strcmp(app.epoch{idx,1}.cfg.type,{'Timepoint'})
                
                % Get start and end times
                pre = app.epoch{idx,1}.cfg.EVA - seconds(app.epoch{idx,1}.cfg.pre); % Replace second part with pre secs
                pst = app.epoch{idx,1}.cfg.EVA + seconds(app.epoch{idx,1}.cfg.pst); % Replace second part with post secs
                pre.TimeZone = app.cfg.TimeZone;
                pst.TimeZone = app.cfg.TimeZone;

                % Draw relevant patch if it fits in axes limits
                if pre >= app.ET_UIAxes.XLim(1) && pre <= app.ET_UIAxes.XLim(2) || pst >= app.ET_UIAxes.XLim(1) && pst <= app.ET_UIAxes.XLim(2) 
                    hold(app.ET_UIAxes, 'on');
                    h    = fill(app.ET_UIAxes,[pre pst pst pre],[min(app.ET_UIAxes.YLim) min(app.ET_UIAxes.YLim) max(app.ET_UIAxes.YLim) max(app.ET_UIAxes.YLim)],'green','FaceAlpha',0.08,'LineStyle','none','YLimInclude','off');
                    uistack(h,'bottom');
                    hold(app.ET_UIAxes, 'off');
                end

            elseif strcmp(app.epoch{idx,1}.cfg.type,{'Sequential'})
                
                % Draw relevant patch [explore increase in efficiency like for artefact patches]
                hold(app.ET_UIAxes, 'on');
                order = toeplitz(mod(1:length(eval(['app.epoch{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}'])),2),mod(1,2));
                for e = 1:length(eval(['app.epoch{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}']))
                    if order(e) == 1
                        alpha = 0.08;
                    else
                        alpha = 0.20;
                    end

                    pre = eval(['app.epoch{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.local_time(1)']);
                    pst = eval(['app.epoch{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.local_time(end)']);
                    
                    if pre >= app.ET_UIAxes.XLim(1) && pre <= app.ET_UIAxes.XLim(2) || pst >= app.ET_UIAxes.XLim(1) && pst <= app.ET_UIAxes.XLim(2) 
                        h    = fill(app.ET_UIAxes,[pre pst pst pre],[min(app.ET_UIAxes.YLim) min(app.ET_UIAxes.YLim) max(app.ET_UIAxes.YLim) max(app.ET_UIAxes.YLim)],'green','FaceAlpha',alpha,'LineStyle','none', 'YLimInclude','off');
                        uistack(h,'bottom');
                    end
                end
                hold(app.ET_UIAxes, 'off');

            end
        end
    end
    

    % For any artefact selected...
    if contains(app.PT_ListBox.Value,'Artefact')

        idx = str2double(extractBetween(app.PT_ListBox.Value,'_','_'));
                       
        % Check artefact fields
        sig = fieldnames(app.art{idx,1}.dat);
        sig = sig(~structfun(@isempty,app.art{idx,1}.dat) & ~strcmp(sig,'Tags') & ~strcmp(sig,'Summary'));

        if any(ismember(sig,app.ET_SignalDropDown.Value))
            
            % Indicate that there are no artefacts and move on
            if size(eval(['app.art{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}']),1) == 0

                % % Find app figure
                % allfigs = findall(0,'Type', 'figure'); 
                % app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');
                % 
                % % No epoch limits are specified. User needs to define limits
                % figure(app2Handle)
                % uialert(app2Handle,'There are no artefacts to display under the given criteria.','Warning','Icon','info','Modal',0);
                                                   
            else

                % Plot the patches as one object (more efficient)
                for p = 1:size(eval(['app.art{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}']),1)
    
                    % Create artefact 'fill' matrix
                    pre = eval(['app.dat.' app.ET_SignalDropDown.Value '{app.e,1}.local_time(app.art{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}(p,1))']);
                    pst = eval(['app.dat.' app.ET_SignalDropDown.Value '{app.e,1}.local_time(app.art{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}(p,2))']);
                    f(:,p) = [pre; pst; pst; pre];

                    % Create artefact 'fill' matrix based on times (see commented section in ep_art_thresh)
                    % ...this aimed to address issues replotting ID artefact after
                    % resampling. For now it is just advised that you
                    % resample BEFORE other preprocessing 

                    % if eval(['app.art{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}(p,1) == app.art{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}(p,2)'])
                    %     % single timepoint artefact causes error.
                    %     % Needs handling but may not directly translate if
                    %     % data were resampled after artefact ID
                    % else
                    % tmp = eval(['app.dat.' app.ET_SignalDropDown.Value '{app.e,1}.local_time >= app.art{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}(p,1) & app.dat.' app.ET_SignalDropDown.Value '{app.e,1}.local_time <= app.art{idx,1}.dat.' app.ET_SignalDropDown.Value '{1,1}(p,2)']);
                    % end
                    % 
                    % % Identify pre and post change points for artefact boundary
                    % pre = eval(['app.dat.' app.ET_SignalDropDown.Value '{app.e,1}.local_time(min(find(tmp)))']);
                    % pst = eval(['app.dat.' app.ET_SignalDropDown.Value '{app.e,1}.local_time(max(find(tmp)))']);
                    
    
                end
    
                hold(app.ET_UIAxes, 'on');
                c   = [0.9290 0.700 0.0750];
                h   = fill(app.ET_UIAxes,f,[min(app.ET_UIAxes.YLim) min(app.ET_UIAxes.YLim) max(app.ET_UIAxes.YLim) max(app.ET_UIAxes.YLim)],c,'FaceAlpha',0.4,'LineStyle','none','YLimInclude','off');
                uistack(h,'bottom');
                hold(app.ET_UIAxes, 'off');

            end
            
        end

    end
        
end