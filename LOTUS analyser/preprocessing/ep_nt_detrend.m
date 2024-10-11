%% LOTUS: Robust Detrending via NoiseTools
%  Copyright (C) (2024) Jack Fogarty

function app = ep_nt_detrend(app,i)

%  This script is based ont the nt_detrend function in NoiseTools: de Cheveigne & Arzounian (2017)
%
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
    if app.det{i,1}.cfg.apa == 1
        signals = app.signals;
    else
        signals = {app.ET_SignalDropDown.Value};
    end
    
    % Store parameters in detrend variable (det)
    app.det{i,1}.cfg.type    = app.DET_TypeDropDown.Value;
    app.det{i,1}.cfg.sig     = app.ET_SignalDropDown.Value;
    app.det{i,1}.cfg.ord     = app.DET_PolynomialDegree.Value;
    app.det{i,1}.cfg.thresh  = app.DET_Thresh.Value;
    app.det{i,1}.cfg.niter   = app.DET_niter.Value;
    app.det{i,1}.cfg.basis   ='polynomials';
    app.det{i,1}.cfg.nanflag = app.DET_nanflag.Value;

    % Loop for each signaldet{i,1}
    for sig = 1:length(signals)
                
        % The current signal
        sigdat = ['app.dat.' signals{sig,1}];
 
        % Loop for all available epochs
        for t = 1:length(eval(sigdat))
        
            if ~strcmp(signals{sig,1},'ACC')

                % Detrend the data
                [dat,~,~] = nt_detrend_helper(eval([sigdat '{' num2str(t) ',1}.data']),app.det{i,1}.cfg.ord,[],app.det{i,1}.cfg.basis,app.det{i,1}.cfg.thresh,app.det{i,1}.cfg.niter);
                           
                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data = dat']);

            else

                % Detrend the data
                [datx,~,~] = nt_detrend_helper(eval([sigdat '{' num2str(t) ',1}.data_x']),app.det{i,1}.cfg.ord,[],app.det{i,1}.cfg.basis,app.det{i,1}.cfg.thresh,app.det{i,1}.cfg.niter);
                [daty,~,~] = nt_detrend_helper(eval([sigdat '{' num2str(t) ',1}.data_y']),app.det{i,1}.cfg.ord,[],app.det{i,1}.cfg.basis,app.det{i,1}.cfg.thresh,app.det{i,1}.cfg.niter);
                [datz,~,~] = nt_detrend_helper(eval([sigdat '{' num2str(t) ',1}.data_z']),app.det{i,1}.cfg.ord,[],app.det{i,1}.cfg.basis,app.det{i,1}.cfg.thresh,app.det{i,1}.cfg.niter);
                           
                % Replace the data for this epoch
                eval([sigdat '{' num2str(t) ',1}.data_x = datx']);
                eval([sigdat '{' num2str(t) ',1}.data_y = daty']);
                eval([sigdat '{' num2str(t) ',1}.data_z = datz']);

            end
        
        end
        
    end
    
end






