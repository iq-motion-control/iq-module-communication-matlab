%MessageInterface Handles messages over serial
%	Ex: com = MessageInterface(com_port,data_rate);
%	com is the returned object handle
%	com_port is the string port descriptor ('COM8', '/dev/ttyusb0', etc.)
%	data_rate is serial data rate (virtual if using usb)

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

% Name: MessageInterface.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: James Paulos
% Contributors: Raphael Van Hoffelen

classdef MessageInterface < handle
    % The following properties can be set only by class methods
    properties (SetAccess = private)
        serial_handle
        input_buffer
        opened
    end
    % The following properties can be used by class methods
    properties (SetAccess = private, GetAccess = private)
        serial_jobject
    end
    
    methods
        % Constructor
        function self = MessageInterface( port_name, baudrate )
            [ self.serial_handle, self.opened] = InitializeSerial(port_name, baudrate);
            self.input_buffer = uint8([]);
            % Stores the java serial object for faster use later
            self.serial_jobject = igetfield(self.serial_handle, 'jobject');
            try
                uselessVar = toc;
            catch
                tic;
            end % try catch
        end
        
        function delete( self )
            % clean up the serial object
            if(self.opened)
                fclose(self.serial_handle);
                delete(self.serial_handle);
            end
        end
        
        % Destructor
        function Flush( self )
            % clear the parser buffers and state
            clear mexPeekPacket;
            % clear the serial device state
            while true
                % getting bytes_available via java is faster than matlab
                bytes_available = self.serial_jobject.BytesAvailable;
                % bytes_available = get(self.serial_handle, 'BytesAvailable');
                if ~bytes_available
                    self.input_buffer = uint8([]);
                    break;
                end
                fread(self.serial_jobject, bytes_available, 5, 0);
            end
        end
        
        % getBytes from serial
        function GetBytes( self )
            % Makes sure the serial events get handled
            drawnow update;
            
            % getting bytes_available via java is faster than matlab
            bytes_available = self.serial_jobject.BytesAvailable;
            % Similar java and matlab implementations are:
            % bytes_available = get(self.serial_jobject, 'BytesAvailable');
            % bytes_available = get(self.serial_handle, 'BytesAvailable');
            
            if ~bytes_available
                return
            end
            
            % fread via java is faster than matlab
            out = fread(self.serial_jobject, bytes_available, 5, 0);
            self.input_buffer = [self.input_buffer; ...
                typecast(out(1), 'uint8')];
%             disp(self.input_buffer);

            % A similar matlab version would be:
            % self.input_buffer = [self.input_buffer; ...
            %     fread(self.serial_handle, bytes_available)];
        end
        
        % peekPacket to see if there is an available packet
        function [msg_type, pkt] = PeekPacket( self )
            msg_type = [];
            pkt = [];
            % Chopping buffer into 100 byte segments if too large
            % to accommodate mexPeekPacket below
            buf = self.input_buffer;
            if ~isempty(buf)
                if length(buf) <= 100
                    buffer = buf;
                    self.input_buffer = uint8([]);
                else % length(buf) > 100
                    buffer = buf(1:100);
                    self.input_buffer = buf(100:end);
                end
            else % buffer is empty
                buffer = uint8([]);
            end
            
            pkt_data = mexPeekPacket( buffer );
            if isempty(pkt_data)
                return;
            end
            
            msg_type = pkt_data(1);
            pkt = pkt_data(2:end);
            
            %% Display in hex
%             pkt_hex = cellstr(dec2hex(pkt_data,2))';
%             disp(['R: ' cat(2,pkt_hex{:})]);
        end
        
        % sendPacket
        function SendPacket( self, pkt )
            try
                % fwrite via java is faster than matlab
                fwrite(self.serial_jobject, pkt, length(pkt), 5, 0, 0);
                % A similar matlab version would be:
                % fwrite(self.serial_handle,pkt)
            catch ex
            end
        end
        
        % sendMsg, wrapper around pack_msg
        function SendMsg( self, msg_spec, msg )
            pkt = PackMsg( msg_spec, msg );
            self.SendPacket( pkt );
            
            %% Display in hex
            % Strip header/crc
%             pkt(1) = [];
%             pkt(1) = [];
%             pkt(end) = [];
%             pkt(end) = [];
%             pkt_hex = cellstr(dec2hex(pkt,2))';
%             disp(['S: ' cat(2,pkt_hex{:})]);
        end
        
        % unpackMsg, wrapper around unpack_msg
        function msg = UnpackMsg( self, msg_spec, pkt_data )
            msg = UnpackMsg( msg_spec, pkt_data );
        end
    end
end




