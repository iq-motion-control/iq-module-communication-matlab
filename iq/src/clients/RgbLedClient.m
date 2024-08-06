% RgbLedClient allows the user to control the RGB LED on an LED board connected to a Vertiq module.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM3', 115200);
%   % Make a RgbLedClient object with obj_id 0
%   rgbLed = RgbLedClient('com', com);
%   % Use the RgbLedClient object
%   rgbLedRed = rgbLed.get('red');
%
% Copyright 2024 Vertiq support@vertiq.co
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: RgbLedClient.m
% Last update: 2024/08/05 by Fred Kummer
% Author: Fred Kummer
% Contributors:

classdef RgbLedClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = RgbLedClient(varargin)
            args = varargin;
            args = [args, {'filename', 'rgb_led.json'}];
            obj@Client(args{:});
        end
    end
end