#!/bin/sh

OUTPUT=results.txt

./checkDaiFab.sh > $OUTPUT
./checkDsChiefAdm.sh >> $OUTPUT
./checkDsGuardDad.sh >> $OUTPUT
./checkDsTokenGov.sh >> $OUTPUT
./checkDsTokenSaiSinSkr.sh >> $OUTPUT
./checkGemPit.sh >> $OUTPUT
./checkMedianizerPep.sh >> $OUTPUT
./checkMedianizerPip.sh >> $OUTPUT
./checkSaiMom.sh >> $OUTPUT
./checkSaiTap.sh >> $OUTPUT
./checkSaiTop.sh >> $OUTPUT
./checkSaiTub.sh >> $OUTPUT
./checkSaiVox.sh >> $OUTPUT

