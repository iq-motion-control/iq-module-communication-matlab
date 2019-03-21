%StepDirectionInputClient Changes step/direction input parameters
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18',115200);
%   % Make a MultiTurnAngleControlClient object with obj_id 0
%   step_dir = StepDirectionInputClient('com',com);
%   % Use the StepDirectionInputClient object
%   angle_step = step_dir.get('angle_step');
%   step_dir.set('angle_step',2*pi/65536);
%   step_dir.save('angle_step');
%
% See also Client

% Copyright 2019 IQinetics Technologies, Inc support@iq-control.com
%
% This file is part of the IQ Matlab API.
%
% IQ Matlab API is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% IQ Matlab API is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.

% Name: StepDirectionInputClient.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

classdef StepDirectionInputClient < Client
    methods
        function obj = StepDirectionInputClient(varargin)
            args = varargin;
            args = [args, {'type', 'StepDirectionInput', 'filename', 'step_direction_input.json'}];
            obj@Client(args{:});
        end
    end
end