%% LOTUS: Check Custom EmbracePlus data
%  Copyright (C) (2024) Jack Fogarty

% This script checks to ensure that custom epochs match across the
% different data modalities. This is mostly prevalent when there are Tags
% for some days and not others. Currently forcing the sorting of all
% datasets to avoid additional (commented) loop checks.

function [cfg, dat] = ep_check_custom(cfg,dat)

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

        % Identify available fields
        if all(cellfun(@isempty,dat.Tags))
            dat.Tags = [];
        end
        tmp = fieldnames(dat); 
        tmp = tmp(~structfun(@isempty,dat));

        if isempty(tmp)
            return
        end

        % Determine number of unique epochs
        for t = 1:length(tmp)
            m(t,1) = eval(['length(dat.' tmp{t} ')']);
        end
        clear t
        
        % Identify unique epoch dates
        days = [];
        for t = 1:length(tmp)
            if ~strcmp(tmp{t},'Tags') & ~strcmp(tmp{t},'Summary')
                for e = 1:eval(['length(dat.' tmp{t} ')'])
                    idx(e,1) = dateshift(eval(['dat.' tmp{t} '{' num2str(e) ',1}.local_time(1)']),'start','day');
                    idx.Format = 'MM/dd/yy';
                end
            elseif ~strcmp(tmp{t},'Summary')
                for e = 1:eval(['length(dat.' tmp{t} ')'])
                    idx(e,1) = dateshift(eval(['dat.' tmp{t} '{' num2str(e) ',1}.TZ_FileTime(1)']),'start','day');
                    idx.Format = 'MM/dd/yy';
                end
            else
                % Summary
            end
            days  = [days; idx];
        end
        days = sort(unique(days));
        clear t idx e

        % Check and reconstruct data structure
        tab = table('Size',[max(m) length(m)],'VariableTypes',repmat({'datetime'},1,length(m)),'VariableNames',tmp);
        for t = 1:length(tmp)
            eval(['tab.' tmp{t} '.TimeZone = cfg.TimeZone;']);
        end
        clear t

        % Determine how to sort Summary data
        if any(ismember(tmp,{'EDA','BVP','SystP','Temp','ACC'}))
            s = 1; % Use signal times
        else
            s = 0; % Use tag times
        end

        for t = 1:length(tmp)
            if ~strcmp(tmp{t},'Tags') & ~strcmp(tmp{t},'Summary')
                
                % Get the dates for this given data modality
                for e = 1:eval(['length(dat.' tmp{t} ')'])
                    idx(e,1) = dateshift(eval(['dat.' tmp{t} '{' num2str(e) ',1}.local_time(1)']),'start','day');
                    idx.Format = 'MM/dd/yy';
                end
                clear e
                
                [ia, ib] = ismember(days,idx);
                
                % IF all dates match... and are in order...
%                 if all(ia) && issorted(ib)
%                     eval(['tab.' tmp{t} ' = idx']);
%                 else % IF not all 1... and if not in order...
                    ndat = cell(max(m),1);
                    for i = 1:height(tab)
                        try
                            eval(['tab.' tmp{t} '(i) = idx(ib(i));']);
                            eval(['ndat(i,1)   = dat.' tmp{t} '(ib(i),1);']);
                        end
                    end
                    eval(['dat.' tmp{t} ' = ndat;']);
%                 end
                clear idx ia ib

            elseif ~strcmp(tmp{t},'Summary')
                
                for e = 1:eval(['length(dat.' tmp{t} ')'])
                    idx(e,1) = dateshift(eval(['dat.' tmp{t} '{' num2str(e) ',1}.TZ_FileTime(1)']),'start','day');
                    idx.Format = 'MM/dd/yy';
                end
                
                [ia, ib] = ismember(days,idx);
                
                % IF all dates match... and are in order...
%                 if all(ia) && issorted(ib)
%                     eval(['tab.' tmp{t} ' = idx']);
%                 else % IF not all 1... and if not in order...
                    ndat = cell(max(m),1);
                    for i = 1:height(tab)
                        try
                            tab.Tags(i) = idx(ib(i));
                            ndat(i,1)   = dat.Tags(ib(i),1);
                        end
                    end
                    dat.Tags = ndat;
%                 end
                clear idx ia ib ndat     

            else

                % Get the dates for the first modality and use it to sort the summary data
                if s
                    for e = 1:eval(['length(dat.' tmp{1} ')'])
                        idx(e,1) = dateshift(eval(['dat.' tmp{1} '{' num2str(e) ',1}.local_time(1)']),'start','day');
                        idx.Format = 'MM/dd/yy';
                    end
                    clear e
                else 
                    for e = 1:eval(['length(dat.' tmp{t} ')'])
                        idx(e,1) = dateshift(eval(['dat.' tmp{t} '{' num2str(e) ',1}.TZ_FileTime(1)']),'start','day');
                        idx.Format = 'MM/dd/yy';
                    end
                end
                
                [ia, ib] = ismember(days,idx);
                
                % IF all dates match... and are in order...
%                 if all(ia) && issorted(ib)
%                     eval(['tab.' tmp{t} ' = idx']);
%                 else % IF not all 1... and if not in order...
                    ndat = cell(max(m),1);
                    for i = 1:height(tab)
                        try
                            eval(['tab.' tmp{t} '(i) = idx(ib(i));']);
                            eval(['ndat(i,1)   = dat.' tmp{t} '(ib(i),1);']);
                        end
                    end
                    eval(['dat.' tmp{t} ' = ndat;']);
%                 end
                clear idx ia ib  
            end
            
        end

    % Selected days
    cfg.selected_days = days;
        
    % Clear vars
    clearvars -except cfg dat

end