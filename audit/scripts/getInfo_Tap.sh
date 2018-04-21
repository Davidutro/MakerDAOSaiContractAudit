#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > tap.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/SaiTap-0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- Dad ----------");
console.log("RESULT: tapAddress=" + getAddressName(saiTapAddress));
console.log("RESULT: tap.owner=" + getAddressName(saiTap.owner()));
console.log("RESULT: tap.authority=" + getAddressName(saiTap.authority()));

var latestBlock = eth.blockNumber;

var logSetAuthorityEvents = saiTap.LogSetAuthority({}, { fromBlock: saiTapFromBlock, toBlock: latestBlock });
i = 0;
logSetAuthorityEvents.watch(function (error, result) {
  console.log("RESULT: tap.LogSetAuthority " + i++ + " #" + result.blockNumber + " authority=" + getAddressName(result.args.authority));
});
logSetAuthorityEvents.stopWatching();

var logSetOwnerEvents = saiTap.LogSetOwner({}, { fromBlock: saiTapFromBlock, toBlock: latestBlock });
i = 0;
logSetOwnerEvents.watch(function (error, result) {
  console.log("RESULT: tap.LogSetOwner " + i++ + " #" + result.blockNumber + " owner=" + getAddressName(result.args.owner));
});
logSetOwnerEvents.stopWatching();

var logNoteEvents = saiTap.LogNote({}, { fromBlock: saiTapFromBlock, toBlock: latestBlock });
i = 0;
logNoteEvents.watch(function (error, result) {
  var sig = sigs[result.args.sig.substring(0, 10)];
  var foo = new BigNumber(result.args.foo.substring(2), 16).shift(-18).toString();
  var guy = getAddressName(result.args.guy);
  console.log("RESULT: sig=" + sig + " guy=" + guy + " foo=" + foo);
  // console.log("RESULT: tap.LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
});
logNoteEvents.stopWatching();

EOF
