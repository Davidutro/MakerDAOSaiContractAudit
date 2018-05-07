#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > vox.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/SaiVox-0x9B0F70Df76165442ca6092939132bBAEA77f2d7A.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- Dad ----------");
console.log("RESULT: voxAddress=" + getAddressName(saiVoxAddress));
console.log("RESULT: vox.owner=" + getAddressName(saiVox.owner()));
console.log("RESULT: vox.authority=" + getAddressName(saiVox.authority()));
console.log("RESULT: vox.fix=" + saiVox.fix() + " " + saiVox.fix().shift(-27));
console.log("RESULT: vox.how=" + saiVox.how());
console.log("RESULT: vox.tau=" + saiVox.tau() + " " + new Date(saiVox.tau() * 1000).toUTCString() + " " + new Date(saiVox.tau() * 1000).toString());

var latestBlock = eth.blockNumber;

var logSetAuthorityEvents = saiVox.LogSetAuthority({}, { fromBlock: saiVoxFromBlock, toBlock: latestBlock });
i = 0;
logSetAuthorityEvents.watch(function (error, result) {
  console.log("RESULT: vox.LogSetAuthority " + i++ + " #" + result.blockNumber + " authority=" + getAddressName(result.args.authority));
});
logSetAuthorityEvents.stopWatching();

var logSetOwnerEvents = saiVox.LogSetOwner({}, { fromBlock: saiVoxFromBlock, toBlock: latestBlock });
i = 0;
logSetOwnerEvents.watch(function (error, result) {
  console.log("RESULT: vox.LogSetOwner " + i++ + " #" + result.blockNumber + " owner=" + getAddressName(result.args.owner));
});
logSetOwnerEvents.stopWatching();

var logNoteEvents = saiVox.LogNote({}, { fromBlock: saiVoxFromBlock, toBlock: latestBlock });
i = 0;
logNoteEvents.watch(function (error, result) {
  var sig = sigs[result.args.sig.substring(0, 10)];
  var foo = new BigNumber(result.args.foo.substring(2), 16).shift(-18).toString();
  var guy = getAddressName(result.args.guy);
  console.log("RESULT: sig=" + sig + " guy=" + guy + " foo=" + foo);
  console.log("RESULT: vox.LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
});
logNoteEvents.stopWatching();

EOF
