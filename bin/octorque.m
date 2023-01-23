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
% ax = axes;
ax = plotyy(t, Engine_RPM_rpm, t, Engine_Coolant_Temperature_F);
p = [get(ax,'children'){1}; get(ax,'children'){2}];
grid on
grid minor on
set(f, 'units', 'normalized', 'position', [0 0 1 1])
set(ax, 'fontsize', 24) %TODO adjust <[outer]position>?
set(p, 'marker', '*', 'linewidth', 3)
T = title('OBD Data');
xla = xlabel('Time (s)');
yla(1) = ylabel(ax(1),'Engine_RPM_rpm');
yla(2) = ylabel(ax(2),'Engine_Coolant_Temperature_F');
set(yla, 'interpreter', 'none')
% xlim([0 60])
% ylim([1 max(Engine_RPM_rpm(1:60))*1.2])
xlim([0 t(end)])
% ylim([1 max(Engine_RPM_rpm)*1.2])
NLIVE = 5;

% all pau!   )
% printf("\n~~~ Octorque Finished ~~~\n\n")
printf("\n~~~ Octorque Import Finished ~~~\n\n")
printf("# To start Live Mode: Run the command `obd_live` #\n");
printf("# To exit  Live Mode:      Type  <Ctrl-C>        #\n\n");

% all pau!   )
