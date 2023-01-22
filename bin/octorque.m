% octorque -- MAIN script for Octorque repository (see README)
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

% MAIN
printf("\n~~~ Starting Octorque ~~~\n\n")
run import_torque_data

% first plot -- HC: Engine_RPM_rpm
f = figure;
ax = axes;
p = plot(t, Engine_RPM_rpm);
grid on
grid minor on
set(ax, 'fontsize', 24)
set(p, 'marker', '*')
title 'OBD Data'
xlabel 'Time (s)'
ylabel 'Engine Revs (RPM)'
% xlim([0 60])
% ylim([1 max(Engine_RPM_rpm(1:60))*1.2])
xlim([0 t(end)])
ylim([1 max(Engine_RPM_rpm)*1.2])
NLIVE = 5;

% all pau!   )
% printf("\n~~~ Octorque Finished ~~~\n\n")
printf("\n~~~ Octorque Import Finished ~~~\n")
printf("\n# To start Live Mode, run the command `run obd_live` #\n\n");
