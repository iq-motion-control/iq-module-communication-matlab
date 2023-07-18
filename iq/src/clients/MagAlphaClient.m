% MagAlphaClient is used to get raw values from the position sensor.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a Mag Alpha object with obj_id 0
%   magAlpha = MagAlphaClient('com', com);
%   % Use the Mag Alpha object
%   angleRaw = magAlpha.get('angle_raw');
%
% Copyright 2023 Vertiq support@vertiq.co
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: MagAlphaClient.m
% Last update: 2023/06/28 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef MagAlphaClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = MagAlphaClient(varargin)
            args = varargin;
            args = [args, {'filename', 'mag_alpha.json'}];
            obj@Client(args{:});
        end
    end
end