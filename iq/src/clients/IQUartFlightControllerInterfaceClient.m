% IQUartFlightControllerInterfaceClient allows the user to control the armed state of the module with throttle commands 
% or manually and to configure specific behaviors to occur at armed state transitions.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a IQUART Flight Controller Interface object with obj_id 0
%   % IQUART Flight Controller Interface objects are always obj_id 0
%   iquartFlightControllerInterface = IQUartFlightControllerInterfaceClient('com', com);
%   % Use the IQUART Flight Controller Interface object
%   telemetry = iquartFlightControllerInterface.get('telemetry');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: IQUartFlightControllerInterfaceClient.m
% Last update: 2023/05/08 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef IQUartFlightControllerInterfaceClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = IQUartFlightControllerInterfaceClient(varargin)
            args = varargin;
            args = [args, {'filename', 'iquart_flight_controller_interface.json'}];
            obj@Client(args{:});
        end
    end
end