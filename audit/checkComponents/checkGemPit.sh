#!/bin/sh

MDDIR=../contracts/makerdao
DADIR=../contracts/dappsys
OUTPUT=gemPit.sol

echo "pragma solidity ^0.4.13;" > $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-math/src/math.sol" >> $OUTPUT
cat $DADIR/math-d5acd9c.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-stop/lib/ds-auth/src/auth.sol" >> $OUTPUT
cat $DADIR/auth-52c6a32.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-stop/lib/ds-note/src/note.sol" >> $OUTPUT
cat $DADIR/note-7170a08.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-stop/src/stop.sol" >> $OUTPUT
cat $DADIR/stop-842e350.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/erc20/src/erc20.sol" >> $OUTPUT
cat $DADIR/erc20-c4f5635.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// src/base.sol" >> $OUTPUT
cat $DADIR/base-e637e3f.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// src/token.sol" >> $OUTPUT
cat $DADIR/token-e637e3f.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
cat $MDDIR/pit-b353893.sol | sed "/pragma/d;/import/d;/\/\//d;/^\s*$/d" >> $OUTPUT

PIT=../deployed-contracts/GemPit-0x69076e44a9C70a67D5b79d95795Aba299083c275.sol
echo "--- Checking the generated $OUTPUT against the deployed $PIT ---"
diff $OUTPUT $PIT && echo "Matching"

# diff -y -W 200 $OUTPUT $PIT