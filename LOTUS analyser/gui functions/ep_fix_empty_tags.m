%% LOTUS: Fix empty tags
%  Copyright (C) (2024) Jack Fogarty

function tags = ep_fix_empty_tags(cfg)

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

    tags = table({0},NaT,NaT,NaT,{''},'VariableNames',{'Tag','UTC_FileTime','TZ_FileTime','TZ_TagTime','Annotation'});
    tags.UTC_FileTime.TimeZone = cfg.TimeZone;
    tags.TZ_FileTime.TimeZone  = cfg.TimeZone;
    tags.TZ_TagTime.TimeZone   = cfg.TimeZone;
    tags(:,:) = [];
    tags = {tags};

end