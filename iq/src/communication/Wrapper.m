%Wrapper wraps data in a handle type object

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

% Name: Wrapper.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: James Paulos
% Contributors: Raphael Van Hoffelen

classdef Wrapper < handle
	properties
		data
	end
	methods
		function h = Wrapper(data)
		  h.data = data	;
		end
	end
end