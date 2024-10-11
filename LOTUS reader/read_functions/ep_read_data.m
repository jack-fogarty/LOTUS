%% LOTUS: Read data parent function
%  Copyright (C) (2024) Jack Fogarty

function [cfg] = ep_read_data(cfg)

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

% 1. Check all day (date) folders and reject any abnormal subfolders

    % Day folders
    day_folders = dir(cfg.parent_folder);
    day_folders = day_folders(~ismember({day_folders.name},{'.','..'}));

    % EmbracePlus date folder naming pattern
    day_pat = digitsPattern(4) + "-" + digitsPattern(2) + "-" + digitsPattern(2);

    % Check for any folder names that do not fit the date pattern and remove them
    check = matches({day_folders.name},day_pat);
    if any(check == 0)
        idx = check == 0;
        day_folders(idx) = [];
        fprintf(['************\n Warning:\n ' num2str(sum(idx)) ' folders marked as irrelevant and ommitted from further processing.\n Folder names did not match date pattern "yyyy-mm-dd"\n************']);
    end
    clear check idx day_pat

% 2. Identify subjects in chosen time period by checking date filter
            
            % Check date range and filter relevant folders (allow for open ended limits: i.e., one date to be set and not the other)
            if ~isnat(cfg.Sdate) && ~isnat(cfg.Edate)
                day_folders = day_folders(datetime({day_folders.name}) >= cfg.Sdate & datetime({day_folders.name}) < cfg.Edate);  
            elseif ~isnat(cfg.Sdate) && isnat(cfg.Edate)
                day_folders = day_folders(datetime({day_folders.name}) >= cfg.Sdate);  
            elseif isnat(cfg.Sdate) && ~isnat(cfg.Edate)
                day_folders = day_folders(datetime({day_folders.name}) < cfg.Edate);
            end
            
            % For each day within the selected range
            tmp = [];
            for d = 1:length({day_folders.name})

                % Subject folders
                subs = dir([cfg.parent_folder filesep day_folders(d).name]);
                subs = subs(~ismember({subs.name},{'.','..'}));

                % EmbracePlus subject pattern
                subs_pat = optionalPattern(alphanumericsPattern) + "-" + alphanumericsPattern(10);

                % Check for any folders that do not fit the subject naming pattern and remove them
                check = matches({subs.name},subs_pat);
                if any(check == 0)
                    idx = check == 0;
                    subs(idx) = [];
                    fprintf(['************\n Warning:\n ' num2str(sum(idx)) ' folders from ' day_folders(d).name ' marked as irrelevant and ommitted from further processing.\n Folder names did not match subject name pattern.\n************']);
                end
                clear check idx subs_pat
                
                % Add subject names to list
                if isempty(tmp)
                   tmp = {subs.name}';
                else
                   tmp = [tmp; {subs.name}'];
                end
            end
            cfg.day_folders = day_folders; % unique dates list
            cfg.subjects = unique(tmp);    % unique subject list
            clear tmp day_folders d tmp subs
            
end










