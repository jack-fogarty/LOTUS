%% LOTUS: Plot Selected Epochs
%  Copyright (C) (2024) Jack Fogarty

function ep_plot_epoch(app)

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

    % Remove any epochs previously plotted
    delete(findobj(app.ET_UIAxes,'tag','epoch'));

    if ~strcmp(app.ET_SignalDropDown.Value,'ACC') % All signals bar ACC                     
        if ~isempty(app.epoch)
            for i = 1:length(app.epoch)

                % Check epoch fields
                sig = fieldnames(app.epoch{i,1}.dat);
                sig = sig(~structfun(@isempty,app.epoch{i,1}.dat) & ~strcmp(sig,'Tags') & ~strcmp(sig,'Summary'));

                if any(ismember(sig,app.ET_SignalDropDown.Value))
                    if any(strcmp(app.epoch{i,1}.cfg.type,{'Event-Related','Event A to B','Timepoint'}))
                        buffer = app.big*m; % Modifiable buffer for signal data plotting
                        valid  = eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.local_time']) >= app.ET_UIAxes.XLim(1)-buffer & eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.local_time']) <= app.ET_UIAxes.XLim(2)+buffer;
                        hold(app.ET_UIAxes, 'on');
                        plot(app.ET_UIAxes,eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.local_time(valid)']),eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.data(valid)']),'LineWidth', 1,'Color',"#EDB120",'YLimInclude','off','XLimInclude','off','Tag','epoch');
                        hold(app.ET_UIAxes, 'off');
                    elseif strcmp(app.epoch{i,1}.cfg.type,{'Sequential'})
                        times = [];
                        datas = [];
                        for e = 1:length(eval(['app.epoch{i, 1}.dat.' app.ET_SignalDropDown.Value '{1,1}']))
                            if isempty(times)
                                times = eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.local_time']);
                                datas = eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.data']);
                            else
                                times = [times; eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.local_time'])];
                                datas = [datas; eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.data'])];
                            end
                        end

                        % Sort compilation in ascending time order
                        [times, idx]  = sort(times);
                        datas = datas(idx);

                        hold(app.ET_UIAxes, 'on');
                        buffer = app.big*m; % Modifiable buffer for signal data plotting
                        valid  = times >= app.ET_UIAxes.XLim(1)-buffer & times <= app.ET_UIAxes.XLim(2)+buffer;
                        plot(app.ET_UIAxes,times(valid),datas(valid),'LineWidth', 1,'Color',"#EDB120",'YLimInclude','off','XLimInclude','off','Tag','epoch');
                        hold(app.ET_UIAxes, 'off');
                    end
                end
            end
        end

    else % if ACC is selected

        if ~isempty(app.epoch)    
            for i = 1:length(app.epoch)
               
                % Check epoch fields
                sig = fieldnames(app.epoch{i,1}.dat);
                sig = sig(~structfun(@isempty,app.epoch{i,1}.dat) & ~strcmp(sig,'Tags') & ~strcmp(sig,'Summary'));

                if any(ismember(sig,app.ET_SignalDropDown.Value))
                    if any(strcmp(app.epoch{i,1}.cfg.type,{'Event-Related','Event A to B','Timepoint'}))
                        buffer = app.big*m; % Modifiable buffer for signal data plotting
                        valid  = eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.local_time']) >= app.ET_UIAxes.XLim(1)-buffer & eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.local_time']) <= app.ET_UIAxes.XLim(2)+buffer;
                        hold(app.ET_UIAxes, 'on');
                        plot(app.ET_UIAxes,eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.local_time(valid)']),eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.data_x(valid)']),'LineWidth',1,'Color',"#EDB120",'YLimInclude','off','XLimInclude','off');
                        plot(app.ET_UIAxes,eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.local_time(valid)']),eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.data_y(valid)']),'LineWidth',1,'Color',"#EDB120",'YLimInclude','off','XLimInclude','off');
                        plot(app.ET_UIAxes,eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.local_time(valid)']),eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}.data_z(valid)']),'LineWidth',1,'Color',"#EDB120",'YLimInclude','off','XLimInclude','off');
                        hold(app.ET_UIAxes, 'off');
                    elseif strcmp(app.epoch{i,1}.cfg.type,{'Sequential'})
                        times = [];
                        datas = [];
                        for e = 1:length(eval(['app.epoch{1, 1}.dat.' app.ET_SignalDropDown.Value '{1,1}']))
                            if isempty(times)
                                times = eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.local_time']);
                                datas = [eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.data_x']) eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.data_y']) eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.data_z'])];
                            else
                                times = [times; eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.local_time'])];
                                datas = [datas; [eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.data_x']) eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.data_y']) eval(['app.epoch{i,1}.dat.' app.ET_SignalDropDown.Value '{1,1}{e,1}.data_z'])]];
                            end
                        end
                                                
                        % Sort compilation in ascending time order
                        [times, idx]  = sort(times);
                        datas = datas(idx);

                        hold(app.ET_UIAxes, 'on');
                        buffer = app.big*m; % Modifiable buffer for signal data plotting
                        valid  = times >= app.ET_UIAxes.XLim(1)-buffer & times <= app.ET_UIAxes.XLim(2)+buffer;
                        plot(app.ET_UIAxes,times(valid),datas(valid),'LineWidth', 1,'Color',"#EDB120",'YLimInclude','off','XLimInclude','off');
                        hold(app.ET_UIAxes, 'off');
                    end
                end
            end
        end
    end

    % Add patch
    ep_plot_epochpatch(app);

    % Ensure tags are on top
    uistack(findobj(app.ET_UIAxes,'type','ConstantLine'),"top");
    
end