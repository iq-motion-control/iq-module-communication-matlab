% CoilTemperatureEstimatorClient is a convection and conduction based thermal model 
% to estimate the temperature of motor coils when they are not directly sensed.
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18', 115200);
%   % Make a Coil Temperature Estimator object with obj_id 0
%   % Coil Temperature Estimator objects are always obj_id 0
%   coilTemperatureEstimator = CoilTemperatureEstimatorClient('com', com);
%   % Use the Coil Temperature Estimator object
%   tCoil = coilTemperatureEstimator.get('t_coil');
%
% Copyright 2023 Vertiq support@vertiq.com
%
% This file is part of the Vertiq Matlab API.
%
% This code is licensed under the MIT license (see LICENSE or https://opensource.org/licenses/MIT for details)
%
% Name: CoilTemperatureEstimatorClient.m
% Last update: 2023/05/11 by Ben Quan
% Author: Ben Quan
% Contributors:

classdef CoilTemperatureEstimatorClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = CoilTemperatureEstimatorClient(varargin)
            args = varargin;
            args = [args, {'filename', 'coil_temperature_estimator.json'}];
            obj@Client(args{:});
        end
    end
end