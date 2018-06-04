#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > adm.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/DSChiefAdm-0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- Dad ----------");
console.log("RESULT: admAddress=" + getAddressName(dsChiefAdmAddress));
console.log("RESULT: adm.owner=" + getAddressName(dsChiefAdm.owner()));
console.log("RESULT: adm.authority=" + getAddressName(dsChiefAdm.authority()));
console.log("RESULT: adm.GOV=" + getAddressName(dsChiefAdm.GOV()));
console.log("RESULT: adm.IOU=" + getAddressName(dsChiefAdm.IOU()));
console.log("RESULT: adm.hat=" + getAddressName(dsChiefAdm.hat()));
console.log("RESULT: adm.MAX_YAYS=" + dsChiefAdm.MAX_YAYS());

var latestBlock = eth.blockNumber;

var logSetAuthorityEvents = dsChiefAdm.LogSetAuthority({}, { fromBlock: dsChiefAdmFromBlock, toBlock: latestBlock });
i = 0;
logSetAuthorityEvents.watch(function (error, result) {
  console.log("RESULT: adm.LogSetAuthority " + i++ + " #" + result.blockNumber + " authority=" + getAddressName(result.args.authority));
});
logSetAuthorityEvents.stopWatching();

var logSetOwnerEvents = dsChiefAdm.LogSetOwner({}, { fromBlock: dsChiefAdmFromBlock, toBlock: latestBlock });
i = 0;
logSetOwnerEvents.watch(function (error, result) {
  console.log("RESULT: adm.LogSetOwner " + i++ + " #" + result.blockNumber + " owner=" + getAddressName(result.args.owner));
});
logSetOwnerEvents.stopWatching();

var logNoteEvents = dsChiefAdm.LogNote({}, { fromBlock: dsChiefAdmFromBlock, toBlock: latestBlock });
i = 0;
logNoteEvents.watch(function (error, result) {
  var sig = sigs[result.args.sig.substring(0, 10)];
  var foo = new BigNumber(result.args.foo.substring(2), 16).shift(-18).toString();
  var guy = getAddressName(result.args.guy);
  var block = eth.getBlock(result.blockNumber);
  console.log("RESULT: sig=" + sig + " guy=" + guy + " foo=" + foo);
  console.log("RESULT: adm.LogNote " + i++ + " #" + result.blockNumber + " " + new Date(block.timestamp * 1000).toUTCString() + " " + result.transactionHash + " " + JSON.stringify(result.args));
  console.log("RESULT: ");
});
logNoteEvents.stopWatching();

var logPermitEvents = dsChiefAdm.LogPermit({}, { fromBlock: dsChiefAdmFromBlock, toBlock: latestBlock });
i = 0;
logPermitEvents.watch(function (error, result) {
  var sig = sigs[result.args.sig.substring(0, 10)];
  var src = "0x" + result.args.src.substring(26);
  var dst = "0x" + result.args.dst.substring(26);
  if (sig !== undefined) {
    console.log("RESULT: Permit from " + getAddressName(src) + " to " + getAddressName(dst) + " for " + sig + " #" + result.blockNumber + " " + result.transactionHash);
  } else {
    console.log("RESULT: adm.LogPermit " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
  }
});
logPermitEvents.stopWatching();

var logForbidEvents = dsChiefAdm.LogForbid({}, { fromBlock: dsChiefAdmFromBlock, toBlock: latestBlock });
i = 0;
logForbidEvents.watch(function (error, result) {
  console.log("RESULT: adm.LogForbid " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
});
logForbidEvents.stopWatching();

var etchEvents = dsChiefAdm.Etch({}, { fromBlock: dsChiefAdmFromBlock, toBlock: latestBlock });
i = 0;
etchEvents.watch(function (error, result) {
  console.log("RESULT: adm.Etch " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
});
etchEvents.stopWatching();

EOF
