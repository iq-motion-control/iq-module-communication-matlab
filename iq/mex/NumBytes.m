%NumBytes Takes a string type and returns is size in bytes
%   NumBytes returns empty if it does not recognize the size type.
%   Using hard coded values is fast, and IS legal because the matlab
%   documentation indicates types are consistent across platform/chipsets.

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

% Name: NumBytes.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: James Paulos
% Contributors: Raphael Van Hoffelen

function [ num_bytes ] = NumBytes( type_string )

switch type_string 
    case {'int8', 'uint8'}
        num_bytes = 1;
    case {'int16','uint16'}
        num_bytes = 2;
    case {'single', 'int32', 'uint32'}
        num_bytes = 4;
    case {'double','int64','uint64'}
        num_bytes = 8;
    otherwise
        num_bytes = [];
end

