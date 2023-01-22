% function [ ] = obd_live(N)
% obd_live -- EWISotT
% -- will run for N minutes
% ~ Mark J. Duvall ~ duvall3.git@gmail.com ~ 01/2023 ~ %

%Copyright (C) 2022 Mark J. Duvall / T. Rocks Science
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.

if ~exist("NLIVE") NLIVE = 1; endif
printf("\n# Beginnig Live Mode #\nPress <Ctrl-C> to exit.\n");
for LIVECOUNT = 1:(NLIVE*60)
  add_torque_lines
  set(p, 'xdata', t)
  set(p, 'ydata', Engine_RPM_rpm)
  % xlim([0 t(end)])
  xlim([t(end)-60 t(end)])
  pause(1)
end

% all pau!   )
printf("# Exiting Live Mode #\n\n");
