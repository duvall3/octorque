% import_torque_data -- EWISotT
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

% init
filename = input("Enter filename: ", "s");
filename = deblank(filename);
# default filename search
if length(filename) == 0
  FILELIST = ls("-tr");
  FILENAME_REGEX = "trackLog.*\.csv";
  for k = 1:length(FILELIST)
    if regexp(FILELIST(k,:), FILENAME_REGEX)
      filename = FILELIST(k,:);
      break
    endif
  end
endif
[~, ~, ~, ext] = regexp(filename, "\.[^\.]+$");
basename = regexprep(filename, ext, "");
% d_file = sprintf("%s_d.dat", basename);
% n_file = sprintf("%s_n.dat", basename);
% aux_file = sprintf("%s_aux.dat", basename);
d_file = sprintf("%s/%s_d.dat", basename, basename);
n_file = sprintf("%s/%s_n.dat", basename, basename);
aux_file = sprintf("%s/%s_aux.dat", basename, basename);

% call shell script
if exist("OTBD")
  OTBDS = sprintf("%s/", OTBD);
else
  OTBDS = "";
endif
sys_cmd = sprintf("%sprepare_torque_data.sh %s", OTBDS, filename);
system(sys_cmd);

% call timestamp script d_file
[ t TS ] = parse_dates(d_file);

% call import_labeled_data for n_file
FILENAME = n_file;
import_labeled_data
N = length(t);
% dt = t(2:end) - t(1:end-1);
% mdt = mean(dt);
% t = [t t(end)+mdt]';
% clear dt mdt

% call dlmread for aux_file (column nos.)
COL_NUMS = dlmread(aux_file)';
COL_NUMS(1) = []; % delete entry for time column

% all pau!   )
