%PauseWithPoll is the same as a pause(t) except sends blank messages to prevent timeouts

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

% Name: PauseWithPoll.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: James Paulos
% Contributors: Raphael Van Hoffelen

function PauseWithPoll(com, t)
    kSpecPoll = struct('Type', 14, 'Fields', struct());
    msg = struct();

    end_time = toc + t;
    while toc < end_time
        com.SendMsg(kSpecPoll, msg);
        while true
            com.GetBytes();
            [rx_type, ~] = com.PeekPacket();	% check for messages
            if isempty(rx_type)                 % throw away messages
                break;
            end
        end
        pause(0.02);
    end
end