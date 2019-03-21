%PackMsg takes in a msgSpec, checks that user created msg is valid and 
% converts that msg into a buffer into something that encodeSerial
% can use

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

% Name: PackMsg.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

function pkt_out = PackMsg( msg_spec, msg )
    [spec, pkt] = BundleMsg(msg_spec, msg);
    [ pkt_out ] = EncodeSerial( spec, pkt );
end
