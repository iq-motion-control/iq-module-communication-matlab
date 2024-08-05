% WhiteLedClient allows the user to control the white LED on an LED board connected to a Vertiq module.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM3', 115200);
%   % Make a WhiteLedClient object with obj_id 0
%   whiteLed = WhiteLedClient('com', com);
%   % Use the WhiteLedClient object
%   whiteLedIntensity = whiteLed.get('intensity');
%
% Copyright 2024 Vertiq support@vertiq.co
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: WhiteLedClient.m
% Last update: 2024/08/05 by Fred Kummer
% Author: Fred Kummer
% Contributors:

classdef WhiteLedClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = WhiteLedClient(varargin)
            args = varargin;
            args = [args, {'filename', 'white_led.json'}];
            obj@Client(args{:});
        end
    end
end