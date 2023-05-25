% ArmingHandlerClient allows the user to control the armed state of the module with throttle commands 
% or manually and to configure specific behaviors to occur at armed state transitions.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a Arming Handler object with obj_id 0
%   % Arming Handler objects are always obj_id 0
%   armingHandler = ArmingHandlerClient('com', com);
%   % Use the Arming Handler object
%   alwaysArmed = armingHandler.get('always_armed');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: ArmingHandlerClient.m
% Last update: 2023/05/08 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef ArmingHandlerClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = ArmingHandlerClient(varargin)
            args = varargin;
            args = [args, {'filename', 'arming_handler.json'}];
            obj@Client(args{:});
        end
    end
end