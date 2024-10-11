%% LOTUS: Nan pad discontinuities in EmbracePlus signal data
%  Copyright (C) (2024) Jack Fogarty

function [dat] = ep_pad_discontinuities(cfg,dat,Fs,PSX,idx)

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

    % Initialise variables
    cols = size(dat,2)-2; % Number of columns of data
    
    if cols > 1 % Then it is accelerometer data and requires additional table var names
       vars = {'data_x','data_y','data_z'};
    else
       vars = {'data'};
    end

    % Generate padding for discontinuities in the available data
    for i = 1:length(idx)
        pad_rtime = dat.local_time(idx(i))+milliseconds(1000/Fs):milliseconds(1000/Fs):dat.local_time(idx(i)+1); pad_rtime = pad_rtime'; pad_rtime.Format = 'MM/dd/yy HH:mm:ss.SSS';
        pad_utime = posixtime(pad_rtime)*PSX;
        pad_data  = nan(length(pad_rtime),cols);
        if i == 1
           padding       = [array2table(pad_utime,'VariableNames',{'unix_time'}) table(pad_rtime,'VariableNames',{'local_time'}) array2table(pad_data,'VariableNames',vars)];
        else
           tmp_padding   = [array2table(pad_utime,'VariableNames',{'unix_time'}) table(pad_rtime,'VariableNames',{'local_time'}) array2table(pad_data,'VariableNames',vars)];
           padding       = [padding; tmp_padding];
           clear tmp_padding
        end
        clear pad_time pad_utime pad_data
    end

    % Add the padding and sort by time
    dat = [padding; dat];
    dat = sortrows(dat,'local_time');
    clear idx padding i

end