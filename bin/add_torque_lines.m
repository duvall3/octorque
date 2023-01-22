% function [ ~ ] = add_torque_lines()
% add_torque_lines -- for realtime / online data import
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
N_current = length(TS);
SYSCMD = sprintf("wc -l %s | awk '{print $1}'", filename);
[~, N_new] = system(SYSCMD);
[~, ~, ~, N_new] = regexp(N_new, "[[:digit:]]+");
N_new = str2num(N_new{1}) - 1;
N_add = N_new - N_current;

# adjust column numbers if needed
if (~exist("COL_NUM_ADJ") || COL_NUM_ADJ==false)
  COL_NUMS--;
  COL_NUM_ADJ = true;
endif

% main -- read
if N_add == 0 return endif
NEWDATA = dlmread(filename, ',', N_current+1, 1);
% COL_NUMS--;
SYSCMD = sprintf("awk -F ',' 'NR>%d {print $1}' %s", N_current+1, filename);
[~, NEWDATES] = system(SYSCMD);
NEWDATES_newlines = regexp(NEWDATES, "\n");
ind0=1;
for k = 1:N_add
  % printf("Adding line extra_%d\n", k);
  ind1 = NEWDATES_newlines(k) - 1;
  timestamp_str = NEWDATES(ind0:ind1);
  ind0 = ind1+2;
  TS = [ TS; strptime( timestamp_str, "%d-%b-%Y %T" ) ];
  [~, ~, ~, S_str] = regexp(timestamp_str, '\d+\.\d+');
  S = str2double(S_str);
  TS(end,1).sec = floor(S);
  TS(end,1).usec = mod(S,1) * 1.e6;
  t = [ t; mktime(TS(end))-mktime(TS(1)) ];
end

% main -- import
for k = 1:length(headers)-1
% for k = 2:4
  CMD = sprintf( "%s = [ %s; NEWDATA(:,COL_NUMS(%d)) ];", headers{k}, headers{k}, k );
  % disp(CMD); %debug
  eval(CMD);
end

% main -- update

% all pau!   )
% endfunction
