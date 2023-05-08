% StoppingHandlerClient A Vertiq module is considered stopped when it has been below its stopping speed continuously for some stopping time. 
% Anytime the module’s velocity goes above the stopping speed, it will reset the countdown on the stopping time.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a Stopping Handler object with obj_id 0
%   % Stopping Handler objects are always obj_id 0
%   stoppingHandler = StoppingHandlerClient('com', com);
%   % Use the Stopping Handler object
%   stoppedSpeed = stoppingHandler.get('stopped_speed');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: StoppingHandlerClient.m
% Last update: 2023/05/08 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef StoppingHandlerClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = StoppingHandlerClient(varargin)
            args = varargin;
            args = [args, {'filename', 'stopping_handler.json'}];
            obj@Client(args{:});
        end
    end
end