%InitializeSerial sets up a serial port with an optional baud rate
%
% Example
%   [serial_handle, opened] = InitializeSerial(port_name, 115200);

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

% Name: InitializeSerial.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

function [ serialHandle, opened ] = InitializeSerial( comPort , varargin)

opened = 0;

if nargin == 2 % baud rate specified
    baudRate = varargin{1};
else
    baudRate = 115200;
end % nargin == 2 % baud rate specified

serialHandle = instrfind('Port',comPort,'Status','open');
if isempty(serialHandle)
    serialHandle = serial(comPort,'BAUD',baudRate);
    serialHandle.BytesAvailableFcnMode = 'byte';
    fopen(serialHandle);
    opened = 1;
end % isempty(serialHandle)

end

