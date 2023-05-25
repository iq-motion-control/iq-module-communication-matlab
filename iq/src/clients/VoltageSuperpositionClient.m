% VoltageSuperpositionClient allows the user set up and change settings related to Vertiq underactuated pulsing propellers.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a Voltage Superposition object with obj_id 0
%   % Voltage Superposition objects are always obj_id 0
%   voltageSuperposition = VoltageSuperpositionClient('com', com);
%   % Use the Voltage Superposition object
%   zeroAngle = voltageSuperposition.get('zero_angle');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: VoltageSuperpositionClient.m
% Last update: 2023/05/08 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef VoltageSuperpositionClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = VoltageSuperpositionClient(varargin)
            args = varargin;
            args = [args, {'filename', 'voltage_superposition.json'}];
            obj@Client(args{:});
        end
    end
end