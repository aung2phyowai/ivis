function [] = ivisDemo015_audio()
% Shows how to use the IvAudio class to present sounds.
%
%   Demonstrates the basics of how to synthesise, load, and calibrate
%   sounds. BE CAREFUL! Don't run this with headphones on unless you're
%   confident you aren't about to deafen yourself!
%
% Requires:         ivis toolbox v1.3
%   
% Matlab:           v2012 onwards
%
% See also:         ivisDemo014_identifyingSaccades.m
%
% Author(S):    	Pete R Jones <petejonze@gmail.com>
%
% Version History: 1.0.0	PJ  20/06/2014    Initial build.
%
% Copyright 2014 : P R Jones
% *********************************************************************
% 

    % clear memory and set workspace
    clearAbsAll();
    import ivis.audio.*;

    % basic audio synthesis and presentation
    params = ivis.main.IvParams.getDefaultConfig();
    A = ivis.audio.IvAudio(params.audio);
    WaitSecs(.5);
          
    % calibration (n.b., these numbers are obviously spurious, and you will
    % need to get a Sound Level Meter and do this properly if you want a
    % specific dP SPL values(!)
    rawDat = [linspace(.001,.4,10)', linspace(10,100,10)'];  % invent some raw data, in [rms db] format
    A.calibrate(rawDat);
    % Alernatively we could have done this at startup, by using the
    % following params:
    % params.audio.useCalibration = true;
    % params.audio.rms2db_fnOrMatrix = [linspace(.001,.4,10)', linspace(10,100,10)'];
    %
    % quiet
    A.test(1);
    WaitSecs(.5);
    % loud
    A.test(74);
    WaitSecs(.5);

    % load and play wav file
    fn = fullfile(ivisdir(),'ivisDemos','demoResources','good.wav');
    wav = A.wavload(fn);
    A.play(wav, 74)
    WaitSecs(.5);
    % quiet
    A.play(wav, 1);
    
    % finish up
    A.delete();
    clearAbsAll();
end