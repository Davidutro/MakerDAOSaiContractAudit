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
console.log("RESULT: tub.axe=" + saiTub.axe().toFixed(0) + " " + saiTub.axe().shift(-27) + " ray");
console.log("RESULT: tub.cap=" + saiTub.cap().toFixed(0) + " " + saiTub.cap().shift(-18) + " sai");
console.log("RESULT: tub.mat=" + saiTub.mat().toFixed(0) + " " + saiTub.mat().shift(-27) + " ray");
console.log("RESULT: tub.tax=" + saiTub.tax().toFixed(0) + " " + saiTub.tax().shift(-27) + " ray");
console.log("RESULT: tub.fee=" + saiTub.fee().toFixed(0) + " " + saiTub.fee().shift(-27) + " ray");
console.log("RESULT: tub.gap=" + saiTub.gap().toFixed(0) + " " + saiTub.gap().shift(-18) + " wad");
console.log("RESULT: tub.off=" + saiTub.off());
console.log("RESULT: tub.out=" + saiTub.out());
console.log("RESULT: tub.fit=" + saiTub.fit() + " wad");
console.log("RESULT: tub.rho=" + saiTub.rho() + " " + new Date(saiTub.rho() * 1000).toUTCString() + " " + new Date(saiTub.rho() * 1000).toString());
console.log("RESULT: tub.rum=" + saiTub.rum().toFixed(0) + " " + saiTub.rum().shift(-27) + " ray");
console.log("RESULT: tub.cupi=" + saiTub.cupi());
var wad = new BigNumber(1).shift(18);
console.log("RESULT: tub.air=" + saiTub.air().toFixed(0) + " " + saiTub.air().shift(-18) + " SKR");
console.log("RESULT: tub.pie=" + saiTub.pie().toFixed(0) + " " + saiTub.pie().shift(-18) + " WETH");
console.log("RESULT: tub.per=" + saiTub.per().toFixed(0) + " " + saiTub.per().shift(-27) + " ray");
console.log("RESULT: tub.ask(1e18)=" + saiTub.ask(wad).toFixed(0) + " " + saiTub.ask(wad).shift(-18) + " wad");
console.log("RESULT: tub.bid(1e18)=" + saiTub.bid(wad).toFixed(0) + " " + saiTub.bid(wad).shift(-18) + " wad");
console.log("RESULT: tub.tag=" + saiTub.tag().toFixed(0) + " " + saiTub.tag().shift(-18) + " wad");


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
  var foo = new BigNumber(result.args.foo.substring(2), 16);
  var bar = new BigNumber(result.args.bar.substring(2), 16);
  var guy = getAddressName(result.args.guy);
  console.log("RESULT: sig=" + sig + " guy=" + guy + " foo=" + foo.toFixed(0) + " " + foo.shift(-18) + " bar=" + bar.toFixed(0) + " " + bar.shift(-18));
  console.log("RESULT: tub.LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
});
logNoteEvents.stopWatching();

var logNewCupEvents = saiTub.LogNewCup({}, { fromBlock: saiTubFromBlock, toBlock: latestBlock });
i = 0;
logNewCupEvents.watch(function (error, result) {
  console.log("RESULT: tub.LogNewCup " + i++ + " #" + result.blockNumber+ " " + JSON.stringify(result.args));
  var ink = saiTub.ink(result.args.cup);
  console.log("RESULT:   - current ink=" + ink.toFixed(0) + " " + ink.shift(-18) + " SKR");
});
logNewCupEvents.stopWatching();

EOF