%unpack_msg fills a msg struct of the appropriate form given a packet of bytes and a msgSpec 

% Note: this function does not know how to unpack arrays
% inside of messages, a more powerful message definition
% is required. 
%

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

% Name: UnpackMsg.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: James Paulos
% Contributors: Raphael Van Hoffelen

function msg = UnpackMsg( msg_spec, pkt )
    if ~isa(pkt, 'uint8')
        error('pkt must be of type "uint8"');
    end
    spec_fields = msg_spec.Fields;
    field_names = fieldnames(spec_fields);
    ind = 1;
    msg = struct();
    for i = 1:length(field_names)
        field = field_names{i};
        numerical_type = spec_fields.(field);
        % Get sizeof numerical type
        nbytes = NumBytes(numerical_type);
        % typecast bytes in packet to correct type
        val = typecast( pkt(ind:(ind+nbytes-1)), numerical_type );
        % pop elements from packet corresponding to val
        ind = ind+nbytes;
        % populate msg struct with correct value
        msg.(field) = val;
    end
end

