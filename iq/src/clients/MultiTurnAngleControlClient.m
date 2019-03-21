%MultiTurnAngleControlClient Modifies and commands the position controller
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18',115200);
%   % Make a MultiTurnAngleControlClient object with obj_id 0
%   angle_ctrl = MultiTurnAngleControlClient('com',com);
%   % Use the MultiTurnAngleControlClient object
%   velocity_filtered = angle_ctrl.get('obs_angular_displacement');
%   angle_ctrl.set('ctrl_angle',0);
%   angle_ctrl.SendTrajectory(1,pi);
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

% Name: MultiTurnAngleControlClient.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

classdef MultiTurnAngleControlClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = MultiTurnAngleControlClient(varargin)
            args = varargin;
            args = [args, {'filename', 'multi_turn_angle_control.json'}];
            obj@Client(args{:});
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function SendTrajectory(obj,tf,xf,xdf,xddf)
            obj.set('trajectory_angular_displacement',xf);
            if(nargin > 3)
                obj.set('trajectory_angular_velocity',xdf);
                if(nargin > 4)
                    obj.set('trajectory_angular_acceleration',xddf);
                end
            end
            obj.set('trajectory_duration',tf);
        end
    end
end