% PulsingRectangularInputParserClient is used with pulsing modules to use the x and y coordinate commands 
% from the flight controller and converts them into a format that can be used by the pulsing module.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a Pulsing Rectangular Input Parser object with obj_id 0
%   % Pulsing Rectangular Input Parser objects are always obj_id 0
%   pulsingRectangularInputParser = PulsingRectangularInputParserClient('com', com);
%   % Use the Pulsing Rectangular Input Parser object
%   pulsingVoltageMode = pulsingRectangularInputParser.get('pulsing_voltage_mode');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: PulsingRectangularInputParserClient.m
% Last update: 2023/05/08 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef PulsingRectangularInputParserClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = PulsingRectangularInputParserClient(varargin)
            args = varargin;
            args = [args, {'filename', 'pulsing_rectangular_input_parser.json'}];
            obj@Client(args{:});
        end
    end
end