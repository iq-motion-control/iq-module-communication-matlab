%RampToVolts ramps from present command voltage to final value in V in time t.

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

% Name: RampToVolts.m
% Last update: 3/20/2019 by Matthew Piccoli
% Author: James Paulos
% Contributors: Raphael Van Hoffelen

function RampToVolts(motor, final, t)

% get present value as starting value
motor.com.Flush();
init = [];
while isempty(init)
    if(isa(motor,'BrushlessDriveClient'))
        init = motor.get('drive_volts');
    else
        error('motor is an unrecognized class');
    end
end

% if present value is nan, let be zero
if isnan(init)
    init = 0;
end

% generate time series of values, and execute
N = round(1000*t/20); % 20ms step time
vect = linspace(init, final, N);
t_vect = linspace(0, t, N);
start_time = toc;
for k=1:N
    while toc < start_time + t_vect(k); end    % wait here until time
        motor.set('drive_spin_volts', vect(k));       % give next command
end
pause(0.020);
end