#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > dad.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/DSGuardDad-0x315cBb88168396D12e1a255f9Cb935408fe80710.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- Dad ----------");
console.log("RESULT: dadAddress=" + getAddressName(dsGuardDadAddress));
console.log("RESULT: dad.owner=" + getAddressName(dsGuardDad.owner()));
console.log("RESULT: dad.authority=" + getAddressName(dsGuardDad.authority()));

var latestBlock = eth.blockNumber;
var fromBlockPip = parseInt(latestBlock) - 2000000;
// var fromBlockPip = 4755932;

var logSetAuthorityEvents = dsGuardDad.LogSetAuthority({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
i = 0;
logSetAuthorityEvents.watch(function (error, result) {
  console.log("RESULT: dad.LogSetAuthority " + i++ + " #" + result.blockNumber + " authority=" + getAddressName(result.args.authority));
});
logSetAuthorityEvents.stopWatching();

var logSetOwnerEvents = dsGuardDad.LogSetOwner({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
i = 0;
logSetOwnerEvents.watch(function (error, result) {
  console.log("RESULT: dad.LogSetOwner " + i++ + " #" + result.blockNumber + " owner=" + getAddressName(result.args.owner));
});
logSetOwnerEvents.stopWatching();

var logNoteEvents = dsGuardDad.LogNote({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
i = 0;
logNoteEvents.watch(function (error, result) {
  console.log("RESULT: dad.LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
});
logNoteEvents.stopWatching();

var logPermitEvents = dsGuardDad.LogPermit({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
i = 0;
logPermitEvents.watch(function (error, result) {
  var sig = sigs[result.args.sig.substring(0, 10)];
  var src = "0x" + result.args.src.substring(26);
  var dst = "0x" + result.args.dst.substring(26);
  if (sig !== undefined) {
    console.log("RESULT: Permit from " + getAddressName(src) + " to " + getAddressName(dst) + " for " + sig + " #" + result.blockNumber + " " + result.transactionHash);
  } else {
    console.log("RESULT: dad.LogPermit " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
  }
});
logPermitEvents.stopWatching();

var logForbidEvents = dsGuardDad.LogForbid({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
i = 0;
logForbidEvents.watch(function (error, result) {
  console.log("RESULT: dad.LogForbid " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
});
logForbidEvents.stopWatching();


EOF
