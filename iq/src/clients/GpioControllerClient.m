% GpioControllerClient provides a flexible method of interacting with a module’s user-specific GPIO pins.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a GPIO Controller object with obj_id 0
%   % GPIO Controller objects are always obj_id 0
%   gpioController = GpioControllerClient('com', com);
%   % Use the GPIO Controller object
%   modeRegister = gpioController.get('mode_register');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: GpioControllerClient.m
% Last update: 2023/05/08 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef GpioControllerClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = GpioControllerClient(varargin)
            args = varargin;
            args = [args, {'filename', 'gpio_controller.json'}];
            obj@Client(args{:});
        end
    end
end