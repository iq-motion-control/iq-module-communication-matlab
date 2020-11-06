%DecodeSerial enables extraction of well formed, crc-verified packets from a 
%  byte stream. It is a specialized queue/buffer which takes in raw bytes and 
%  returns packet data. The returned packet data is a byte array consisting of 
%  a type byte followed by data bytes.
% 
%  General Packet Format:
%  | 0x55 | length | type | ---data--- | crcL | crcH |
%    'length' is the (uint8) number of bytes in 'data'
%    'type' is the (uint8) message type
%    'data' is a series of (uint8) bytes, serialized Little-Endian
%    'crc' is the (uint16) CRC value for 'length'+'type'+'data', Little-Endian

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

% Name: DecodeSerial.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

function [ type, data, buffer ] = DecodeSerial( buffer )

try
startByte = 85; % 0x55
type = [];
data = [];

starts = find(buffer == startByte); 
if isempty(starts)
    return;
end
startind = 1;
endLoc = 0;

while startind < length(starts)
    start = starts(startind);
    if length(buffer) > start+2% && buffer(start + 1) == startByte
        count = double(buffer(start+1));
        % find crc
        if length(buffer) >= start+2+count 
            [dummy_variable, crc] = AppendCRC(buffer(start+1:start+2+count));
            % compare calculated crc to input crc
            if (crc(1) == buffer(start+3+count) && crc(2) == buffer(start+4+count))
                % successful message!
                type(end+1) = buffer(start+2);
                data{end+1} = buffer(start+3:start+2+count);
                startind = startind + 1;
                endLoc = start+5+count;
            else
                % bad message!
                startind = startind + 1;
%                 disp('bad crc');
            end
        else
            startind = startind + 1;
%             disp('bad length');
        end
    else
        % bad message!
        startind = startind + 1;
%         disp('bad start');
    end
end
buffer = buffer(max(starts(end),endLoc):end);
catch
    type = [];
    data = [];
    buffer = [];
end