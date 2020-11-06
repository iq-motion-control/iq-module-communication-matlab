%SerialInterfaceClient Changes serial (UART) parameters
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18',115200);
%   % Make a Serial Interface object with obj_id 0
%   serial_interface = SerialInterfaceClient('com',com);
%   % Use the Serial Interface object
%   old_baud = serial_interface.get('baud_rate'); // should be 115200
%   serial_interface.set('baud_rate', 9600);
%   % Note: the baud rate is now 9600. This com object uses 115200
%   % Make a new com object at 9600 baud to continue communication
%   com = MessageInterface('COM18',9600);
%   serial_interface = SerialInterfaceClient('com',com);
%   new_baud = serial_interface.get('baud_rate'); // should be 9600
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

% Name: SerialInterfaceClient.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

classdef SerialInterfaceClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = SerialInterfaceClient(varargin)
            args = varargin;
            args = [args, {'filename', 'serial_interface.json'}];
            obj@Client(args{:});
        end
            
    end
end