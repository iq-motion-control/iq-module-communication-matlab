%PowerMonitorClient measure power input to IQ devices
%
% Example:
%   % Make a communication interface object
%   com = MessageInterface('COM18',115200);
%   % Make a PowerMontitorClient object with obj_id 0
%   pwr = PowerMontitorClient('com',com);
%   % Use the PowerMontitorClient object
%   volts = pwr.get('volts');
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

% Name: PowerMonitorClient.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: Matthew Piccoli
% Contributors: Raphael Van Hoffelen

classdef PowerMonitorClient < Client
    
    methods
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Basic Parameters
        
        function obj = PowerMonitorClient(varargin)
            args = varargin;
            args = [args, {'type', 'PowerMonitor', 'filename', 'power_monitor.json'}];
            obj@Client(args{:});
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Convenience Functions

        function [gain] = calcVoltsGain(~, meas1, raw1)
            gain = meas1/raw1*65536;
        end

        function [gain, bias] = calcAmpsGainAndBias(~, meas1, raw1, meas2, raw2)
            gain = (meas2 - meas1)/(raw2 - raw1);
            bias = (meas1/gain - raw1);
        end

        function raw = get_volts_raw_mean(obj, nSamples)
            raw = [];
            for k=nSamples:-1:1
                raw_now = double(obj.get('volts_raw'));
                if ~isempty(raw_now)
                    raw(k) = raw_now; 
                end
            end
            raw = mean(raw);
        end
        
        function raw = get_amps_raw_mean(obj, nSamples)
            raw = [];
            for k=nSamples:-1:1
                raw_now = double(obj.get('amps_raw'));
                if ~isempty(raw_now)
                    raw(k) = raw_now; 
                end
            end
            raw = mean(raw);
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Private
    
    methods (Access = private)
        
        % Get bytes from serial until target type_idn is
        % receieved.  Return type and packet.
        function [rx_type, rx_packet] = WaitForType(obj, type_idn)
            rx_type = [];
            rx_packet = [];
            com = obj.com;
            end_time = toc + 0.1;
            while(toc < end_time)
                com.GetBytes();
                while true
                    [msg_type, pkt] = com.PeekPacket();                 % check for messages
                    if ~isempty(msg_type)                               % if we got a message
                        if msg_type == type_idn
                            rx_type = msg_type;
                            rx_packet = pkt;
                            return;
                        end
                    else
                        break;
                    end
                end
            end
        end
    end
end