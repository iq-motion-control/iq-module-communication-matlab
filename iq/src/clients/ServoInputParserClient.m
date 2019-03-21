%ServoInputParserClient Changes servo input parameters
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18',115200);
%   % Make a ServoInputParserClient object with obj_id 0
%   svo = ServoInputParserClient('com',com);
%   % Use the ServoInputParserClient object
%   svo.set('mode', 3); // Position control mode
%   svo.save('mode');
%   svo.set('unit_min', -pi);
%   svo.save('unit_min');
%   svo.set('unit_max', pi);
%   svo.save('unit_max');
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

% Name: ServoInputParserClient.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

classdef ServoInputParserClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = ServoInputParserClient(varargin)
            args = varargin;
            args = [args, {'filename', 'servo_input_parser.json'}];
            obj@Client(args{:});
        end
            
    end
end