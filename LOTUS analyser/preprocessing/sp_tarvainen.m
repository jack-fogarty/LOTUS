%% LOTUS: Smoothness Priors "Time Varying" Detrend for RR based on Kubios, established in Tarvainen et al. (2002)
%  Copyright (C) (2024) Jack Fogarty

function detrended_RR = sp_tarvainen(RR,L)

%  This script is based on the time varying detrending in Kubios
%  usually conducted for RR after artefact correction: Tarvainen et al. (2002)
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

% Temporarily replace NaNs with zero
    idx_nan     = isnan(RR);
    RR(idx_nan) = 0;

    if length(RR) > 20000 % arbitrary number

        % Split into subsamples
        Wn  = round(length(RR)/round(length(RR)/20000)); % window size set to approximate max of 25,000 arbitrarily
        sz  = size(RR,1)-1;
        bks = [Wn*ones(1,fix(sz/Wn)),1+rem(sz,Wn)]; % subsample blocks
        % Check if any subsamples sizes are equal to one and if so add to previous block
        if any(bks == 1)
            idx = find(bks == 1);
            for i = 1:length(idx)
                bks(idx-1) = bks(idx-1)+bks(idx);
                bks(idx) = [];
            end
        end
        bRR = mat2cell(RR,bks,1); % RR split into blocks

        for i = 1:length(bRR)
    
            T = length(bRR{i});
            % lambda = 35; % Default in paper is 10 but JSF had it previously set to 35 for empatica (needs optimisation)
            I = speye(T);
            D2 = spdiags(ones(T-2,1)*[1 -2 1],[0:2],T-2,T);
    
            % Segmenting operations in "z_stat = (I-inv(I+lambda^2*D2'*D2))*RR;" for memory handling
                
                % Determine X and Y with efficient matrix multiplication
                splitSize    = 10000; % How many rows to do at once
                altSplitSize = 10000; % How many columns to do at once
                X = sparseMatrixMultiplication(D2',D2,splitSize,altSplitSize);
                Y = I+L^2*X;
                clear D2 X splitSize altSplitSize
    
                % Split Y into subsample blocks for block inversion [actually seems slower after segmenting]
                % Wn  = 10000; % window size set to approximate max of 10,000 arbitrarily
                % sz  = size(Y,1)-1;
                % bks = [Wn*ones(1,fix(sz/Wn)),1+rem(sz,Wn)]; % subsample blocks
                % Mi = blockinv(Y, bks);
                % clear Y
    
                % Compute detrended signals
                z_stat{i}  = (I-inv(Y))*bRR{i}; % Detrended signal
                z_trend{i} = bRR{i}-z_stat{i};  % Trend from signal
                clear T Y I
    
        end
    
        % Concatenate data
        detrended_RR = [];
        RR_trend = [];
        for i = 1:length(z_stat)
            detrended_RR = [detrended_RR; z_stat{i}];
            RR_trend     = [RR_trend; z_trend{i}];
        end

    else

    %   Based on Kubios, established in Tarvainen et al. (2002)

    % Apply detrending method to RR
    T = length(RR);
    % lambda = L; % Default in paper is 10 but JSF had it previously set to 35 for empatica (needs optimisation)
    I = speye(T);
    D2 = spdiags(ones(T-2,1)*[1 -2 1],[0:2],T-2,T);
    detrended_RR  = (I-inv(I+L^2*D2'*D2))*RR; % Detrended signal
    RR_trend      = RR-z_stat; % Trend from signal
    clear T I D2

    end

% Replace NaNs
RR(idx_nan) = nan;

end

%%% TREND REMOVAL COMPLETE

% Though it is probably ideal to detrend across the entire sample initial
% tests suggest that there are only (seemingly) small differences in trend computation
% (mostly at the edges) if run in segments. 
% It may then be 'optimal' to run this algorithm as a sliding process with overlap, but
% it features intense computations (e.g., inv()) that are slow, hence it is
% currently run in non-overlapping segments until this potential optimization 
% can be explored further.
