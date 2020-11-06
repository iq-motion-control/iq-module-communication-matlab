%EncodeSerial creates a serial packet
% Creates a packet of containing a message type and data.  The crc is
% calculated and appended using CRC-16-CCITT.
% 
% Packet format:
% Packet: | 0x55 | count | type | ---data--- | crcL | crcH |
% State:     0       1      2      3     4      5      6

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

% Name: EncodeSerial.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

function [ packet ] = EncodeSerial( type, data )

packet = AppendCRC([length(data); type; data(:)]);

packet = [uint8(85); packet];
end
