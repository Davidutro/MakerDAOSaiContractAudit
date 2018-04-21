#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > pip.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("../deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.js");
loadScript("../deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- MedianizerPip ----------");
console.log("RESULT: medianizerPipAddress=" + medianizerPipAddress);
console.log("RESULT: medianizerPip.owner=" + medianizerPip.owner());
console.log("RESULT: medianizerPip.authority=" + medianizerPip.authority());

var latestBlock = eth.blockNumber;
var fromBlockPip = parseInt(latestBlock) - 2000000;
// var fromBlockPip = 4755932;

var logSetAuthorityEvents = medianizerPip.LogSetAuthority({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
i = 0;
logSetAuthorityEvents.watch(function (error, result) {
  console.log("RESULT: pip.LogSetAuthority " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
});
logSetAuthorityEvents.stopWatching();

var logSetOwnerEvents = medianizerPip.LogSetOwner({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
i = 0;
logSetOwnerEvents.watch(function (error, result) {
  console.log("RESULT: pip.LogSetOwner " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
});
logSetOwnerEvents.stopWatching();

var logNoteEvents = medianizerPip.LogNote({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
i = 0;
logNoteEvents.watch(function (error, result) {
  console.log("RESULT: pip.LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
});
logNoteEvents.stopWatching();


// console.log("RESULT: ---------- MedianizerPep ----------");
// console.log("RESULT: medianizerPepAddress=" + medianizerPepAddress);
// console.log("RESULT: medianizerPep.owner=" + medianizerPep.owner());
// console.log("RESULT: medianizerPep.authority=" + medianizerPep.authority());



EOF
