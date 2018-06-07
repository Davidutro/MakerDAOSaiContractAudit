#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > top.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/SaiTop-0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- Top ----------");
console.log("RESULT: topAddress=" + getAddressName(saiTopAddress));
console.log("RESULT: top.owner=" + getAddressName(saiTop.owner()));
console.log("RESULT: top.authority=" + getAddressName(saiTop.authority()));
console.log("RESULT: top.vox=" + getAddressName(saiTop.vox()));
console.log("RESULT: top.tub=" + getAddressName(saiTop.tub()));
console.log("RESULT: top.tap=" + getAddressName(saiTop.tap()));
console.log("RESULT: top.sai=" + getAddressName(saiTop.sai()));
console.log("RESULT: top.sin=" + getAddressName(saiTop.sin()));
console.log("RESULT: top.skr=" + getAddressName(saiTop.skr()));
console.log("RESULT: top.gem=" + getAddressName(saiTop.gem()));
console.log("RESULT: top.fix=" + saiTop.fix() + " " + saiTop.fix().shift(-27));
console.log("RESULT: top.fit=" + saiTop.fit() + " " + saiTop.fit().shift(-27));
console.log("RESULT: top.caged=" + saiTop.caged());
console.log("RESULT: top.cooldown=" + saiTop.cooldown());

var latestBlock = eth.blockNumber;

var logSetAuthorityEvents = saiTop.LogSetAuthority({}, { fromBlock: saiTopFromBlock, toBlock: latestBlock });
i = 0;
logSetAuthorityEvents.watch(function (error, result) {
  console.log("RESULT: top.LogSetAuthority " + i++ + " #" + result.blockNumber + " authority=" + getAddressName(result.args.authority));
});
logSetAuthorityEvents.stopWatching();

var logSetOwnerEvents = saiTop.LogSetOwner({}, { fromBlock: saiTopFromBlock, toBlock: latestBlock });
i = 0;
logSetOwnerEvents.watch(function (error, result) {
  console.log("RESULT: top.LogSetOwner " + i++ + " #" + result.blockNumber + " owner=" + getAddressName(result.args.owner));
});
logSetOwnerEvents.stopWatching();

var logNoteEvents = saiTop.LogNote({}, { fromBlock: saiTopFromBlock, toBlock: latestBlock });
i = 0;
logNoteEvents.watch(function (error, result) {
  // var sig = sigs[result.args.sig.substring(0, 10)];
  // var foo = new BigNumber(result.args.foo.substring(2), 16).shift(-18).toString();
  // var guy = getAddressName(result.args.guy);
  // console.log("RESULT: sig=" + sig + " guy=" + guy + " foo=" + foo);
  console.log("RESULT: top.LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
});
logNoteEvents.stopWatching();

EOF
