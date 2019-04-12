%PersistentMemoryClient Controls defaults and non-volatile memory
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18',115200);
%   % Make a PersistentMemoryClient object with obj_id 0
%   mem = PersistentMemoryClient('com',com);
%   % Use the PersistentMemoryClient object
%   mem.set('revert_to_default');
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

% Name: PersistentMemoryClient.m
% Last update: 4/12/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

classdef PersistentMemoryClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = PersistentMemoryClient(varargin)
            args = varargin;
            args = [args, {'filename', 'persistent_memory.json'}];
            obj@Client(args{:});
        end
            
    end
end
