%BuzzerControlClient handles all beeps and songs on IQ devices
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18',115200);
%   % Make a BuzzerControlClient object with obj_id 0
%   buz = BuzzerControlClient('com',com);
%   % Use the BuzzerControlClient object
%   buz.set('hz',440); % A4
%   buz.set('volume',127); % Max volume
%   buz.set('duration',500); % 500ms
%   buz.set('ctrl_note');
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

% Name: BuzzerControlClient.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

classdef BuzzerControlClient < Client

    methods

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters

        function obj = BuzzerControlClient(varargin)
            args = varargin;
            args = [args, {'filename', 'buzzer_control.json'}];
            obj@Client(args{:});
        end
    end
end