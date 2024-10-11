%% LOTUS: Interpolate Data
%  Copyright (C) (2024) Jack Fogarty

%%% Consider adjusting and adding default values for users

function app = ep_interpolate(app,i)

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


    % Get selected signals
    if app.int{i,1}.cfg.apa == 1
        signals = app.signals;
    else
        signals = {app.ET_SignalDropDown.Value};
    end

    % Check input and set default values
    app.int{i,1}.cfg.type  = app.INT_TypeDropDown.Value;
    app.int{i,1}.cfg.sc    = app.INT_Scalarvalue.Value;
    app.int{i,1}.cfg.ev    = app.INT_EndValuesDropDown.Value;
    app.int{i,1}.cfg.mg    = app.INT_MaxGap.Value;
    app.int{i,1}.cfg.win   = app.INT_WindowLengthPts.Value;
    
    if isempty(app.int{i,1}.cfg.sc)
        app.int{i,1}.cfg.sc = 0;
    end

    if isempty(app.int{i,1}.cfg.ev)
        app.int{i,1}.cfg.ev = 'nearest';
    end

    if isempty(app.int{i,1}.cfg.mg) | app.int{i,1}.cfg.mg <= 0
        app.int{i,1}.cfg.mg = inf;
    end
    
%%% CONSIDER ADDING A DEFAULT INSTEAD OF A WARNING/REJECTION
    if isempty(app.int{i,1}.cfg.win)

        % Find app figure
        allfigs = findall(0,'Type', 'figure'); 
        app2Handle = findall(allfigs, 'Name', 'LOTUS_analyser', 'Tag', 'LOTUS_analyser');
    
        % No epoch limits are specified. User needs to define limits
        figure(app2Handle);
        uialert(app2Handle,'Window length needs to be defined for this function.','Warning');
        app.rtn = 1;
                            
        % Return to Main GUI
        return   

    end

    dim = 1;

    % Loop for each signal
    for sig = 1:length(signals)
                
        % The current signal
        sigdat = ['app.dat.' signals{sig,1}];
 
        % Loop for all available epochs
        for t = 1:length(eval(sigdat))
        
            % Apply interpolation
            if ~strcmp(signals{sig,1},'ACC')

                if      ismember(app.int{i,1}.cfg.type,{'constant'})
                            dat = fillmissing(eval([sigdat '{' num2str(t) ',1}.data']),app.int{i,1}.cfg.type,app.int{i,1}.cfg.sc);
                elseif  ismember(app.int{i,1}.cfg.type,{'previous','next','nearest'})
                            dat = fillmissing(eval([sigdat '{' num2str(t) ',1}.data']),app.int{i,1}.cfg.type,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                elseif  ismember(app.int{i,1}.cfg.type,{'linear','spline','pchip','makima'})
                            dat = fillmissing(eval([sigdat '{' num2str(t) ',1}.data']),app.int{i,1}.cfg.type,dim,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                elseif  ismember(app.int{i,1}.cfg.type,{'movmean','movmedian'})
                            dat = fillmissing(eval([sigdat '{' num2str(t) ',1}.data']),app.int{i,1}.cfg.type,app.int{i,1}.cfg.win,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                end

                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data = dat']);

            else

                if      ismember(app.int{i,1}.cfg.type,{'constant'})
                            datx = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_x']),app.int{i,1}.cfg.type,app.int{i,1}.cfg.sc);
                            daty = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_y']),app.int{i,1}.cfg.type,app.int{i,1}.cfg.sc);
                            datz = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_z']),app.int{i,1}.cfg.type,app.int{i,1}.cfg.sc);
                elseif  ismember(app.int{i,1}.cfg.type,{'previous','next','nearest'})
                            datx = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_x']),app.int{i,1}.cfg.type,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                            daty = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_y']),app.int{i,1}.cfg.type,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                            datz = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_z']),app.int{i,1}.cfg.type,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                elseif  ismember(app.int{i,1}.cfg.type,{'linear','spline','pchip','makima'})
                            datx = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_x']),app.int{i,1}.cfg.type,dim,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                            daty = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_y']),app.int{i,1}.cfg.type,dim,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                            datz = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_z']),app.int{i,1}.cfg.type,dim,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                elseif  ismember(app.int{i,1}.cfg.type,{'movmean','movmedian'})
                            datx = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_x']),app.int{i,1}.cfg.type,app.int{i,1}.cfg.win,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                            daty = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_y']),app.int{i,1}.cfg.type,app.int{i,1}.cfg.win,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                            datz = fillmissing(eval([sigdat '{' num2str(t) ',1}.data_z']),app.int{i,1}.cfg.type,app.int{i,1}.cfg.win,'EndValues',app.int{i,1}.cfg.ev,'MaxGap',app.int{i,1}.cfg.mg);
                end

                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data_x = datx']);
                eval([sigdat '{' num2str(t) ',1}.data_y = daty']);
                eval([sigdat '{' num2str(t) ',1}.data_z = datz']);

            end

        end
        
    end
    
end













