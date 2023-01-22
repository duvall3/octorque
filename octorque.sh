#!/bin/bash
# octorque.sh -- MAIN invocation script for running Octorque
# ~ Mark J. Duvall ~ duvall3.git@gmail.com ~ 01/2023 ~ #

#Copyright (C) 2022 Mark J. Duvall / T. Rocks Science
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# set up paths (OTD = Octorque directory, OTBD = Octorque bin/ directory)
# OTD="~/octorque" # DEFAULT (KEEP)
OTD="~/octorque" # CHANGE THIS LINE IF NEEDED
OTBD="$OTD/bin"

# start Octave and Octorque
octave -q -p $OTD -p $OTBD --eval "OTD=\"$OTD\"; OTBD=\"$OTBD\"; run octorque" --persist

# all pau!   )
exit $?
