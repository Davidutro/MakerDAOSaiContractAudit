#!/bin/sh

MDDIR=../medianizer
DADIR=../dappsys-contracts
OUTPUT=medianizerPep.sol

cat > $OUTPUT << EOF
// Medianizer
// Copyright (C) 2017 Dapphub

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// hevm: flattened sources of src/medianizer.sol
pragma solidity ^0.4.18;
EOF

echo "" >> $OUTPUT
echo "////// lib/ds-value/lib/ds-thing/lib/ds-auth/src/auth.sol" >> $OUTPUT
cat $DADIR/auth-52c6a32.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-value/lib/ds-thing/lib/ds-math/src/math.sol" >> $OUTPUT
cat $DADIR/math-d5acd9c.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-value/lib/ds-thing/lib/ds-note/src/note.sol" >> $OUTPUT
cat $DADIR/note-7170a08.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-value/lib/ds-thing/src/thing.sol" >> $OUTPUT
cat $DADIR/thing-35b2538.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-value/src/value.sol" >> $OUTPUT
cat $DADIR/value-faae4cb.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// src/medianizer.sol" >> $OUTPUT
cat $MDDIR/medianizer-6cb859c.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

PEP=../deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.sol
echo "--- Checking $PEP ---"
diff $OUTPUT $PEP && echo "Good"

# diff -y -W 200 $OUTPUT $PEP