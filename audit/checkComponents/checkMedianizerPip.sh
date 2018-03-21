#!/bin/sh

MDDIR=../contracts/medianizer
DADIR=../contracts/dappsys
OUTPUT=medianizerPip.sol

cat > $OUTPUT << EOF
/// return median value of feeds

// Copyright (C) 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.8;
EOF

echo "" >> $OUTPUT
cat $DADIR/auth-ce285fb.sol | sed "1,13d" >> $OUTPUT

echo "" >> $OUTPUT
cat $DADIR/note-7170a08.sol | sed "1,17d" >> $OUTPUT

echo "" >> $OUTPUT
cat $DADIR/math-a01112f.sol  | sed "1,13d" >> $OUTPUT

echo "" >> $OUTPUT
cat $DADIR/thing-ea63fd3.sol | sed "1,17d" >> $OUTPUT

echo "" >> $OUTPUT
cat $DADIR/value-2027f97.sol | sed "1,15d" >> $OUTPUT

echo "" >> $OUTPUT
cat $MDDIR/medianizer-31cc0a8.sol | sed "1,4d" >> $OUTPUT

PIP=../deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.sol
echo "--- Checking the generated $OUTPUT against the deployed $PIP ---"
diff -b $OUTPUT $PIP && echo "Matching"

# diff -y -W 200 $OUTPUT $PIP