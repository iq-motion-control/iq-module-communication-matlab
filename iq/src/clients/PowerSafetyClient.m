% PowerSafetyClient protects the motor by checking various parameters in the motor, 
% such as voltage and current, to make sure the values are within a specific range.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a Power Safety object with obj_id 0
%   % Power Safety objects are always obj_id 0
%   powerSafety = PowerSafetyClient('com', com);
%   % Use the Power Safety object
%   faultNow = powerSafety.get('fault_now');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: PowerSafetyClient.m
% Last update: 2023/05/09 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef PowerSafetyClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = PowerSafetyClient(varargin)
            args = varargin;
            args = [args, {'filename', 'power_safety.json'}];
            obj@Client(args{:});
        end
    end
end