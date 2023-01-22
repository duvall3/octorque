#!/bin/bash
# prepare_torque_data -- EWISotT
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

# help check
USAGE="Usage: prepare_torque_data.sh [FILENAME]"
if [[ $1 =~ "-h" ]]; then
  echo $USAGE
  exit 10
fi

# program check / alias correction
ECHO=$(which echo)
LS=$(which ls)
HEAD=$(which head)
TAIL=$(which tail)
GREP=$(which grep)
BASENAME_PROG=$(which basename)
AWK=$(which awk)
AWK=${AWK:=$(which gawk)}
AWK=${AWK:=$(which mawk)}
SED=$(which sed)
TR=$(which tr)
PRINTF=$(which printf)
RM=$(which rm) #KEEPME

# init
FILENAME=${1:-$($LS -t trackLog*.csv | $HEAD -1)}
EXT=$($ECHO $FILENAME | $GREP -Eo "\.[^\.]+$")
BASENAME=$($BASENAME_PROG $FILENAME $EXT)
TMPFILE="$BASENAME".tmp
OUTFILE_D="$BASENAME"_d.dat
OUTFILE_N="$BASENAME"_n.dat
OUTFILE_AUX="$BASENAME"_aux.dat
HEADERS_FULL=( $(\
  $HEAD -1 $FILENAME \
  | $AWK -v RS=',' '{\
    gsub("^ ",""); \
    gsub(" ","_"); \
    gsub("\\(","_"); \
    gsub("\\)",""); \
    print}' \
  | $SED 's/%/pct/g' \
  | $SED 's/__/_/g' \
  | $SED 's/²/2/g' \
  | $SED 's/:1//g' \
  | $TR -d '°/' \
  | $TR '/' '_') )
DATA_COLS=($( $TAIL -n 1 $FILENAME | $AWK -v RS=',' '$0 !~ /^-$/ {print NR}'))

# write (new) header line
HEADERS=()
for k in ${DATA_COLS[*]}; do
  HEADERS=(${HEADERS[*]} ${HEADERS_FULL[$((k-1))]})
done
$ECHO ${HEADERS[*]} > $TMPFILE
$ECHO ${DATA_COLS[*]} > $OUTFILE_AUX

# main
AWK_COLS=$(for COL in ${DATA_COLS[*]}; do $PRINTF "$%s\" \"" $COL; done)
AWK_CMD="$AWK -F ',' 'NR>1 {print $AWK_COLS}' $FILENAME"
eval $AWK_CMD | $SED 's/\ /_/' >> $TMPFILE

# split and cleanup
$AWK '{print $1}' $TMPFILE > $OUTFILE_D
$AWK '{$1=""; print}' $TMPFILE > $OUTFILE_N
$RM $TMPFILE #KEEPME
# /usr/bin/rm $TMPFILE #LOCAL
DIR=$BASENAME
mkdir $DIR
mv -t $DIR $OUTFILE_D $OUTFILE_N $OUTFILE_AUX

# all pau!   )
exit 0
