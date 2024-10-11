%% LOTUS: Check signal data and apply chosen corrections
% Jack Fogarty, 2024

function [cfg,dat] = ep_check_signal(cfg,dat,Fs,PSX,span,day_idx,e)

    % Create difference vector between consecutive timepoints to check discontinuities
    check = diff(dat.local_time); check.Format = 'hh:mm:ss.SSS';
    check = round(seconds(check),3);
    
    % Check for major discontinuities in the input signal after rounding to nearest ms
    idx   = [];
    idx   = find(seconds(check) > seconds(round(1/Fs,3)));
        
    % If discontinuities were detected display a warning
    if ~isempty(idx)
        fprintf(['************\n Warning:\n There were ' num2str(length(idx)) ' discontinuities identified in continuous data.\n************']);
    end
    
    % Record discontinuities
    %
    
    % Conduct NaN padding for discontinuities in the data if option is selected (default = 1)
    if ~isempty(idx) && cfg.padding == 1
        dat = ep_pad_discontinuities(cfg,dat,Fs,PSX,idx);
    end
        
    % Conduct NaN padding to maximum epoch length (default = 1)
    if cfg.padmax == 1
        dat = ep_pad_to_epoch(cfg,dat,Fs,PSX,span,day_idx,e);     
    end
    
end

 
