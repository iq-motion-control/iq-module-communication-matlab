%BundleMsg takes in a msgSpec, checks that user created msg is valid and 
%        converts that msg into a buffer.  The buffer could then be passed
%        into EncodeSerial

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

% Name: BundleMsg.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: James Paulos
% Contributors: Raphael Van Hoffelen

function [spec_type, data] = BundleMsg( msg_spec, msg )
    spec_type = msg_spec.Type;
    spec_fields = msg_spec.Fields;
    field_names = fieldnames(spec_fields);
    data = uint8([]);
    for i = 1:length(field_names)
        field = field_names{i};
        if ~isfield(msg, field)
            disp(['msg does not have field: ' field]);
            error('');
            data = [];
            return;
        end
        data = [data typecast(cast( msg.(field), spec_fields.(field) ), 'uint8')];
    end
end
