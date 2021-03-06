%FindCom finds the comport of a connected device.
% The device must have a SystemControl object.
%
% Ex.
% com = FindCom();
% com = FindCom('id',1);

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

% Name: FindCom.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

function [com] = FindCom(varargin)
    p = inputParser;
    addOptional(p,'id',[]);
    addOptional(p,'timeout',.2);
    parse(p,varargin{:});

    % Sets up a com
    id = p.Results.id;
    
    com = [];

    %% Find/make com
    coms = seriallist;
    for i = 1:length(coms)
        try
            com = MessageInterface(coms{i}, 115200);
            sys = SystemControlClient('com',com,'timeout',p.Results.timeout);
            id_in = sys.get('module_id');
            clear sys
            if(~isempty(id))
                if(id == id_in)
                    disp(['Using MessageInterface on ', coms{i}]);
                    break;
                else
                    disp(['No response on ' coms{i}]);
                end
            elseif(~isempty(id_in))
                disp(['Using MessageInterface on ', coms{i}]);
                break;
            else
                disp(['No response on ' coms{i}]);
            end
        catch ME
            if (~strcmp(ME.identifier, 'MATLAB:serial:fopen:opfailed'))
                rethrow(ME);
            else
                disp(['Could not open ' coms{i}]);
            end
        end
    end
end

