#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > pit.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/GemPit-0x69076e44a9C70a67D5b79d95795Aba299083c275.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- Pit ----------");
console.log("RESULT: pitAddress=" + getAddressName(gemPitAddress));

var latestBlock = eth.blockNumber;

EOF
