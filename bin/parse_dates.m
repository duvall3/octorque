function [ t TS ] = parse_dates( filename )
% parse_dates -- create an array of Octave timestamp objects
%   (TM_STRUCT) from a text file with the format specified below
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

% import file
[ DATES, DLM, HDR ] = importdata( filename );
N = length(DATES)-1;

% loop over entries
timestamp_str = "";
S_str = "";
S = 0.;
for k=1:N
  timestamp_str = DATES{k+1};
  [ TS(k,1) nchar(k,1) ] = strptime( timestamp_str, "%d-%b-%Y_%T" );
  [~, ~, ~, S_str] = regexp(timestamp_str, '\d+\.\d+');
  S = str2double(S_str);
  TS(k,1).sec = floor(S);
  TS(k,1).usec = mod(S,1) * 1.e6;
  t(k,1) = mktime(TS(k,1));
end

% % strptime checksum
% CHK = sum(nchar);
% if CHK ~= 0
%   printf('Warning: sum(nchar) = %i\n', CHK)
% endif

% offset to zero (default?)
t = t - t(1);

% all pau!   )
endfunction
