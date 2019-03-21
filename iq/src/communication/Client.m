%Client handles get/set/save functions for subclass clients

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

% Name: Client.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: James Paulos
% Contributors: Raphael Van Hoffelen

classdef Client < handle

    properties (Access=public, Hidden)
        com
        timeout
    end

    properties (Access=public, Constant, Hidden)
        % access type enumeration
        kGet = 0;
        kSet = 1;
        kSave = 2;
        kReply = 3;
    end

    properties (Access=private)
        obj_id
        filename
        disp_entry
        inbox
        outbox
        is_deprecated
    end

    properties (Access=private, Constant)
        % message specifications for typed setters and replies
        fspec = struct('Type', 0,...
            'Fields', struct('sub','uint8','access','uint8','value','single'));
        Ispec = struct('Type', 0,...
            'Fields', struct('sub','uint8','access','uint8','value','uint32'));
        Hspec = struct('Type', 0,...
            'Fields', struct('sub','uint8','access','uint8','value','uint16'));
        Bspec = struct('Type', 0,...
            'Fields', struct('sub','uint8','access','uint8','value','uint8'));
        ispec = struct('Type', 0,...
            'Fields', struct('sub','uint8','access','uint8','value','int32'));
        hspec = struct('Type', 0,...
            'Fields', struct('sub','uint8','access','uint8','value','int16'));
        bspec = struct('Type', 0,...
            'Fields', struct('sub','uint8','access','uint8','value','int8'));
        vspec = struct('Type', 0,...
            'Fields', struct('sub','uint8','access','uint8'));
    end

    methods

        function obj = Client(varargin)
        % Constructor for Client2 class.  Requires a MessageInterface
        % object and a .json filename containing a listing of parameters.
        % An object ID is optional and defaults to zero. The object id is
        % only required when the embedded target hosts multiple instances
        % of an object type.
        %
        % Required named parameters:
        %   com, MessageInterface object
        %   filename, .json file name string declaring parameters
        % Optional named parameters:
        %   obj_id, object identifier with default 0

            % parse named arguments
            p = inputParser();
            p.KeepUnmatched = true;
            addParameter(p, 'com', []);
            addParameter(p, 'filename', '', @(x)validateattributes(x,{'char'},{'nonempty'}));
            addParameter(p, 'obj_id', 0);
            addParameter(p, 'timeout', .2);
            parse(p, varargin{:});

            % assert required arguments
            required = {'com', 'filename'};
            for k=1:numel(required)
                if(ismember(p.UsingDefaults, required{k}))
                    error('Name-value pair ''%s'' is required.', required{k});
                end
            end

            obj.com     = p.Results.com;
            obj.filename = p.Results.filename;
            obj.obj_id = p.Results.obj_id;
            obj.timeout = p.Results.timeout;

            % Load parameter list file.
            input = loadjson(obj.filename);

            % Fill ordered list of disp_entry objects.
            % Display entries are ordered as in json file.
            obj.disp_entry = struct('param', '', 'unit', '');
            for k = 1:numel(input)
                in = input{k};
                s = [];
                s.param = in.param;
                s.unit = in.unit;
                if isempty(in.unit)
                    s.unit = ' ';
                end
                obj.disp_entry(k) = s;
            end

            % Fill map for checking whether param names are deprecated.
            obj.is_deprecated  = containers.Map('KeyType', 'char', 'ValueType', 'any');
            for k = 1:numel(input)
                in = input{k};
                if isfield(in, 'is_deprecated') && in.is_deprecated
                    obj.is_deprecated(in.param) = true;
                end
            end

            % Fill inbox map with mail_entry objects.
            % The inbox map is keyed by type_idn/param_idn, and there is an
            % exact one-to-one correspondance between keys and objects.
            obj.inbox  = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
            for k = 1:numel(input)
                in = input{k};

                s = [];
                s.type_idn  = uint8(in.type_idn);
                s.param_idn = uint8(in.param_idn);
                s.format    = in.format;
                if isempty(in.format)
                    s.format = ' ';
                end
                if(s.format(1) == 'f')
                    s.value         = single(0);
                elseif(s.format(1) == 'I')
                    s.value = uint32(0);
                end
                s.is_fresh = false;

                s = Wrapper(s);
                long_idn = bitshift(uint32(s.data.type_idn), 8) + uint32(s.data.param_idn);
                if ~obj.inbox.isKey(long_idn)
                    obj.inbox(long_idn) = s;
                end
            end

            % Fill outbox map with mail_entry objects.
            % The outbox map is keyed by parameter name. Keys are unique,
            % but multiple keys may retrieve the same object.
            obj.outbox = containers.Map('KeyType', 'char',  'ValueType',  'any');
            for k = 1:numel(input)
                in = input{k};
                if ~obj.outbox.isKey(in.param)
                    long_idn = bitshift(uint32(in.type_idn), 8) + uint32(in.param_idn);
                    value = obj.inbox(long_idn);
                    obj.outbox(in.param) = value;
                else
                    error('Parameter list file invalid. Param name is repeated.')
                end
            end
        end

        function list(obj)
        % List available parameters and their properties.
            fprintf('Parameter set loaded from: %s\n', obj.filename);
            fprintf('This object ID: %i\n', obj.obj_id);
            for k = 1:numel(obj.disp_entry)
                d = obj.disp_entry(k);
                m = obj.outbox(d.param); m = m.data;
                fprintf('    %3i %2i: %32s  %4s  %s\n', m.type_idn, m.param_idn, d.param, m.format, d.unit);
            end
        end

        function val = get(obj, param)
        % Retrieve a value by parameter name.
        %
        % val = obj.get(param)
        % val = obj.get('speed_kp')

            item = obj.outbox(param);

            msg.sub = item.data.param_idn;
            msg.access = Client.kGet + obj.obj_id*4;

            % message specifications for generic getter
            spec = struct('Type', item.data.type_idn,...
                'Fields', struct('sub','uint8','access','uint8'));
            obj.com.Flush();
            obj.com.SendMsg(spec, msg);

            item.data.is_fresh = false;
            val = [];
            end_time = toc + obj.timeout;
            while toc < end_time
                obj.update();
                if(item.data.is_fresh)
                    val = item.data.value;
                    return;
                end
            end
        end
        
        function val = get_retry(obj, param, retries)
            %Retrieve a value by paramter name.  Retry if nothing is
            %received.
            for i = 1:retries
                val = get(obj,param);
                if(~isempty(val))
                    break;
                end
            end
        end

        function s = get_all(obj)
        % Retrieve all values as a struct.
        %
        % val = obj.get_all()

            s = [];
            for d = obj.disp_entry
                s.(d.param) = obj.get(d.param);
            end
        end

        function set(obj, param, varargin)
        % Set a value by parameter name.
        %
        % obj.set(param, value)
        % obj.set('speed_kp', 0.01)

            item = obj.outbox(param);

            msg.sub = item.data.param_idn;
            msg.access = Client.kSet + obj.obj_id*4;
            if(numel(varargin) >= 1)
                msg.value = varargin{1};
                if(isempty(msg.value))
                    return; % value must not be empty; abort/skip
                end
            end

            if(item.data.format == 'f')
                spec = obj.fspec;
            elseif (item.data.format == 'I')
                spec = obj.Ispec;
            elseif (item.data.format == 'H')
                spec = obj.Hspec;
            elseif (item.data.format == 'B')
                spec = obj.Bspec;
            elseif (item.data.format == 'i')
                spec = obj.ispec;
            elseif (item.data.format == 'h')
                spec = obj.hspec;
            elseif (item.data.format == 'b')
                spec = obj.bspec;
            elseif (item.data.format == ' ')
                spec = obj.vspec;
            else
                error('Format not yet supported.');
            end
            spec.Type = item.data.type_idn;
            obj.com.SendMsg(spec, msg);
        end

        function set_all(obj, s)
        % Set many values by a struct.
        %
        % obj.set_all(datastruct)

            % for each field in s, check if it is a param in type
            struct_fields = fields(s);
            for k = 1:numel(struct_fields)
                param = struct_fields{k};
                if ~obj.outbox.isKey(param)
                    fprintf('Skipping ''%s'', does not exist in parameter list.\n', param);
                    continue;
                end
                if isempty(s.(param))
                    fprintf('Skipping ''%s'', struct field is empty.\n', param);
                    continue;
                end
                obj.set(param, s.(param));
                fprintf('Set ''%s''.\n', param);
                pause(0.001);
            end
        end
        
        function set_verify_all(obj, s)
            % Set many values by a struct and check them.
            %
            % obj.set_verify_all(datastruct)

            % for each field in s, check if it is a param in type
            struct_fields = fields(s);
            for k = 1:numel(struct_fields)
                param = struct_fields{k};
                if ~obj.outbox.isKey(param)
                    fprintf('Skipping ''%s'', does not exist in parameter list.\n', param);
                    continue;
                end
                if isempty(s.(param))
                    fprintf('Skipping ''%s'', struct field is empty.\n', param);
                    continue;
                end
                obj.set_verify(param, s.(param));
                fprintf('Set ''%s''.\n', param);
                pause(0.001);
            end
        end

        function set_verify(obj, param, varargin)
        % Set a value by parameter name, retry until success.
        %
        % obj.set_verify(param, value)
        % obj.set_verify('speed_kp', 0.01)
            if numel(varargin) ~= 1
                warning('Function set_verify requires one param string and one set value.');
                return;
            end

            val = varargin{1};
            for k = 1:10
                obj.set(param, val);
                pause(0.01);
                retval = obj.get_retry(param,10);
                val_error = abs(val - retval);
                if val_error < 2e-5 || (isnan(val) && isnan(retval))
                    return;
                end
                pause(0.01);
            end
            warning(['set_verify failed after 10 retries on ' param '. Val in = %d, val ret = %d'],val,retval);
        end

        function save(obj, param)
        % Save a parameter to flash by parameter name.
        %
        % obj.save(param)
        % obj.save('speed_kp')

            item = obj.outbox(param);

            spec = struct('Type', item.data.type_idn,...
            'Fields', struct('sub','uint8','access','uint8'));

            msg.sub = item.data.param_idn;
            msg.access = Client.kSave + obj.obj_id*4;
            obj.com.SendMsg(spec, msg);
        end

        function save_all(obj)
        % Save all parameters to flash. An object ID is optional and
        % defaults to zero.
        %
        % obj.save_all()
            params = obj.outbox.keys();
            for p = params
                obj.save(p{1});
                pause(0.001);
            end
        end

        function update(obj)
        % Read in from device and update parameter table.

            obj.com.GetBytes();
            [type_idn, packet] = obj.com.PeekPacket();  % check for messages
            if ~isempty(type_idn) && ~isempty(packet)   % if we got a message, and that message is not empty
                param_idn = packet(1);
                long_idn = uint32(type_idn)*256 + uint32(param_idn);
                if(obj.inbox.isKey(long_idn))
                    item = obj.inbox(long_idn);
                    msg_obj_id = bitshift(packet(2),-2); % high six bits
                    access = packet(2) - 4*msg_obj_id;     % low two bits
                    if(access == Client.kReply && msg_obj_id == obj.obj_id)
                        if(item.data.format == 'f')
                            spec = obj.fspec;
                        elseif (item.data.format == 'I')
                            spec = obj.Ispec;
                        elseif (item.data.format == 'H')
                            spec = obj.Hspec;
                        elseif (item.data.format == 'B')
                            spec = obj.Bspec;
                        elseif (item.data.format == 'i')
                            spec = obj.ispec;
                        elseif (item.data.format == 'h')
                            spec = obj.hspec;
                        elseif (item.data.format == 'b')
                            spec = obj.bspec;
                        elseif (item.data.format == ' ')
                            spec = obj.vspec;
                        else
                            error('Format not yet supported.');
                        end
                        spec.Type = item.data.type_idn;
                        msg = UnpackMsg(spec, packet);
                        item.data.value = msg.value;
                        item.data.is_fresh = true;
                    end
                end
            end
        end

        function retval = isDeprecated(obj, param)
            retval = obj.is_deprecated.isKey(param);
        end
    end
end