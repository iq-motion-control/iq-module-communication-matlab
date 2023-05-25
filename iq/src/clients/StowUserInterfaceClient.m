% StowUserInterfaceClient allows a Vertiq module to return to a configurable position on a transition 
% from armed to disarmed, on timeouts, or when given an explicit command to stow.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a Stow User Interface object with obj_id 0
%   % Stow User Interface objects are always obj_id 0
%   stowUserInterface = StowUserInterfaceClient('com', com);
%   % Use the Stow User Interface object
%   zeroAngle = stowUserInterface.get('zero_angle');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: StowUserInterfaceClient.m
% Last update: 2023/05/08 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef StowUserInterfaceClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = StowUserInterfaceClient(varargin)
            args = varargin;
            args = [args, {'filename', 'stow_user_interface.json'}];
            obj@Client(args{:});
        end
    end
end