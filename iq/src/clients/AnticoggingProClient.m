%AnticoggingProClient allows advanced control over the anticogging feature
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18',115200);
%   % Make an AnticoggingProClient object with obj_id 0
%   anticoggingPro = AnticoggingProClient('com',com);
%   % Use the AnticoggingProClient object
%   isEnabled = anticoggingPro.get('enabled');
%

% Copyright 2023 Vertiq support@vertiq.co 
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

% Name: AnticoggingProClient.m
% Last update: 2023/06/28 by Ben Quan 
% Author: Ben Quan 
% Contributors: 

classdef AnticoggingProClient < Client
    
    methods
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Constructor, from JSON Parameters
        
        function obj = AnticoggingProClient(varargin)
            args = varargin;
            args = [args,{'filename', 'anticogging_pro.json'}];
            obj@Client(args{:});
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end