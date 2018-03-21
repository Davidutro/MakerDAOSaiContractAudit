#!/bin/sh

MDDIR=../contracts/makerdao
DADIR=../contracts/dappsys
OUTPUT=dsTokenGov.sol

echo "// MKR Token" > $OUTPUT
echo "" >> $OUTPUT
echo "// hevm: flattened sources of src/mkr-499.sol" >> $OUTPUT
echo "pragma solidity ^0.4.15;" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-roles/lib/ds-auth/src/auth.sol" >> $OUTPUT
cat $DADIR/auth-52c6a32.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-thing/lib/ds-math/src/math.sol" >> $OUTPUT
cat $DADIR/math-d5acd9c.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-thing/lib/ds-note/src/note.sol" >> $OUTPUT
cat $DADIR/note-7170a08.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-thing/src/thing.sol" >> $OUTPUT
cat $DADIR/thing-35b2538.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-token/lib/ds-stop/src/stop.sol" >> $OUTPUT
cat $DADIR/stop-842e350.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-token/lib/erc20/src/erc20.sol" >> $OUTPUT
cat $DADIR/erc20-56f16b3.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-token/src/base.sol" >> $OUTPUT
cat $DADIR/base-e637e3f.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-token/src/token.sol" >> $OUTPUT
cat $DADIR/token-e637e3f.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

GOV=../deployed-contracts/DSTokenGov-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.sol
echo "--- Checking the generated $OUTPUT against the deployed $GOV ---"
diff $OUTPUT $GOV && echo "Matching"

# diff -y -W 200 $OUTPUT $GOV