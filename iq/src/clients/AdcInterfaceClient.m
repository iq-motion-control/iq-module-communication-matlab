% AdcInterfaceClient provides access to an on-board Analog to Digital Converter (ADC).
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a ADC Interface object with obj_id 0
%   % ADC Interface objects are always obj_id 0
%   adcInterface = AdcInterfaceClient('com', com);
%   % Use the ADC Interface object
%   adcVoltage = adcInterface.get('adc_voltage');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: AdcInterfaceClient.m
% Last update: 2023/05/08 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef AdcInterfaceClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = AdcInterfaceClient(varargin)
            args = varargin;
            args = [args, {'filename', 'adc_interface.json'}];
            obj@Client(args{:});
        end
    end
end