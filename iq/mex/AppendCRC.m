% AppendCRC sppends the CRC-16-CCITT to message
% It returns the complete message in amsg, and the individual bytes in
% crc.

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

% Name: AppendCRC.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

function [amsg, crc] = AppendCRC(message)

message = uint8(message);
crc = uint16(65535); %hex2dec('ffff');

for i = 1:length(message)
    x = bitxor(bitshift(crc,-8),uint16(message(i)));
    x = bitxor(x,bitshift(x,-4));
    crc = bitxor(bitxor(bitxor(bitshift(crc,8),bitshift(x,12)),bitshift(x,5)),x);
end

crc = [bitand(crc,255); bitshift(crc,-8)];

amsg = [message; cast(crc,'uint8')];

end
