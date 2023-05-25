% UavcanNodeClient allows the user to communicate with a Vertiq module over a CAN bus.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a UAVCAN Node object with obj_id 0
%   % UAVCAN Node objects are always obj_id 0
%   uavcanNode = UavcanNodeClient('com', com);
%   % Use the UAVCAN Node object
%   uavcanNodeId = uavcanNode.get('uavcan_node_id');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: UavcanNodeClient.m
% Last update: 2023/05/08 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef UavcanNodeClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = UavcanNodeClient(varargin)
            args = varargin;
            args = [args, {'filename', 'uavcan_node.json'}];
            obj@Client(args{:});
        end
    end
end