#!/bin/sh

MDDIR=../contracts/makerdao
DADIR=../contracts/dappsys
OUTPUT=saiTub.sol

echo "// hevm: flattened sources of src/tub.sol" > $OUTPUT
echo "pragma solidity ^0.4.18;" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-guard/lib/ds-auth/src/auth.sol" >> $OUTPUT
cat $DADIR/auth-52c6a32.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-spell/lib/ds-note/src/note.sol" >> $OUTPUT
cat $DADIR/note-7170a08.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-thing/lib/ds-math/src/math.sol" >> $OUTPUT
cat $DADIR/math-d5acd9c.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-thing/src/thing.sol" >> $OUTPUT
cat $DADIR/thing-4c86a53.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-token/lib/ds-stop/src/stop.sol" >> $OUTPUT
cat $DADIR/stop-842e350.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-token/lib/erc20/src/erc20.sol" >> $OUTPUT
cat $DADIR/erc20-c4f5635.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-token/src/base.sol" >> $OUTPUT
cat $DADIR/base-e637e3f.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-token/src/token.sol" >> $OUTPUT
cat $DADIR/token-e637e3f.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-value/src/value.sol" >> $OUTPUT
cat $DADIR/value-faae4cb.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// src/vox.sol" >> $OUTPUT
cat $MDDIR/vox-b353893.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// src/tub.sol" >> $OUTPUT
cat $MDDIR/tub-b353893.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

TUB=../deployed-contracts/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.sol
echo "--- Checking $TUB ---"
diff $OUTPUT $TUB && echo "Good"

# diff -y -W 200 $OUTPUT $TUB