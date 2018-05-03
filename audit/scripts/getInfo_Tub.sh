#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > tub.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- Dad ----------");
console.log("RESULT: tubAddress=" + getAddressName(saiTubAddress));
console.log("RESULT: tub.owner=" + getAddressName(saiTub.owner()));
console.log("RESULT: tub.authority=" + getAddressName(saiTub.authority()));

console.log("RESULT: tub.sai=" + getAddressName(saiTub.sai()));
console.log("RESULT: tub.sin=" + getAddressName(saiTub.sin()));
console.log("RESULT: tub.skr=" + getAddressName(saiTub.skr()));
console.log("RESULT: tub.gem=" + getAddressName(saiTub.gem()));
console.log("RESULT: tub.gov=" + getAddressName(saiTub.gov()));
console.log("RESULT: tub.vox=" + getAddressName(saiTub.vox()));
console.log("RESULT: tub.pip=" + getAddressName(saiTub.pip()));
console.log("RESULT: tub.pep=" + getAddressName(saiTub.pep()));
console.log("RESULT: tub.tap=" + getAddressName(saiTub.tap()));
console.log("RESULT: tub.pit=" + getAddressName(saiTub.pit()));
console.log("RESULT: tub.axe=" + saiTub.axe());
console.log("RESULT: tub.cap=" + saiTub.cap());
console.log("RESULT: tub.mat=" + saiTub.mat());
console.log("RESULT: tub.tax=" + saiTub.tax());
console.log("RESULT: tub.fee=" + saiTub.fee());
console.log("RESULT: tub.gap=" + saiTub.gap());
console.log("RESULT: tub.off=" + saiTub.off());
console.log("RESULT: tub.out=" + saiTub.out());
console.log("RESULT: tub.fit=" + saiTub.fit());
console.log("RESULT: tub.rho=" + saiTub.rho());
console.log("RESULT: tub.rum=" + saiTub.rum());
console.log("RESULT: tub.cupi=" + saiTub.cupi());

var latestBlock = eth.blockNumber;

var logSetAuthorityEvents = saiTub.LogSetAuthority({}, { fromBlock: saiTubFromBlock, toBlock: latestBlock });
i = 0;
logSetAuthorityEvents.watch(function (error, result) {
  console.log("RESULT: tub.LogSetAuthority " + i++ + " #" + result.blockNumber + " authority=" + getAddressName(result.args.authority));
});
logSetAuthorityEvents.stopWatching();

var logSetOwnerEvents = saiTub.LogSetOwner({}, { fromBlock: saiTubFromBlock, toBlock: latestBlock });
i = 0;
logSetOwnerEvents.watch(function (error, result) {
  console.log("RESULT: tub.LogSetOwner " + i++ + " #" + result.blockNumber + " owner=" + getAddressName(result.args.owner));
});
logSetOwnerEvents.stopWatching();

var logNoteEvents = saiTub.LogNote({}, { fromBlock: saiTubFromBlock, toBlock: latestBlock });
i = 0;
logNoteEvents.watch(function (error, result) {
  var sig = sigs[result.args.sig.substring(0, 10)];
  var fooAsNumber = new BigNumber(result.args.foo.substring(2), 16).shift(-18).toString();
  var barAsNumber = new BigNumber(result.args.bar.substring(2), 16).shift(-18).toString();
  var guy = getAddressName(result.args.guy);
  console.log("RESULT: sig=" + sig + " guy=" + guy + " foo=" + fooAsNumber + " bar=" + barAsNumber);
  console.log("RESULT: tub.LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
});
logNoteEvents.stopWatching();

var logNewCupEvents = saiTub.LogNewCup({}, { fromBlock: saiTubFromBlock, toBlock: latestBlock });
i = 0;
logNewCupEvents.watch(function (error, result) {
  console.log("RESULT: tub.LogNewCup " + i++ + " #" + result.blockNumber+ " " + JSON.stringify(result.args));
});
logNewCupEvents.stopWatching();

EOF