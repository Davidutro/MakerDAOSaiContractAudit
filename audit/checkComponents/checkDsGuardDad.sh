#!/bin/sh

MDDIR=../../src
DADIR=../dappsys-contracts
OUTPUT=dsGuardDad.sol

echo "// hevm: flattened sources of src/guard.sol" > $OUTPUT
echo "pragma solidity ^0.4.13;" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// lib/ds-auth/src/auth.sol" >> $OUTPUT
cat $DADIR/auth-52c6a32.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

echo "" >> $OUTPUT
echo "////// src/guard.sol" >> $OUTPUT
cat $DADIR/guard-f8b7f58.sol | sed "/pragma/s/^/\/\* /;/pragma/s/$/ \*\//;/import/s/^/\/\* /;/import/s/$/ \*\//" >> $OUTPUT

DAD=../deployed-contracts/DSGuardDad-0x315cBb88168396D12e1a255f9Cb935408fe80710.sol
echo "--- Checking $DAD ---"
diff $OUTPUT $DAD && echo "Good"

# diff -y -W 200 $OUTPUT $DAD