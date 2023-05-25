% PwmInterfaceClient provides access to a PWM output driver with read/write accessibility to the frequency, duty cycle, and mode.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a PWM Interface object with obj_id 0
%   % PWM Interface objects are always obj_id 0
%   pwmInterface = PwmInterfaceClient('com', com);
%   % Use the PWM Interface object
%   pwmFrequency = pwmInterface.get('pwm_frequency');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: PwmInterfaceClient.m
% Last update: 2023/05/08 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef PwmInterfaceClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = PwmInterfaceClient(varargin)
            args = varargin;
            args = [args, {'filename', 'pwm_interface.json'}];
            obj@Client(args{:});
        end
    end
end