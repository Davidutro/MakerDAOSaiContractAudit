#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > pep.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.js");
var nullBytes32 = "0x0000000000000000000000000000000000000000000000000000000000000000";
var priceFeedAbi = [{"constant":false,"inputs":[{"name":"owner_","type":"address"}],"name":"setOwner","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"read","outputs":[{"name":"","type":"bytes32"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"peek","outputs":[{"name":"","type":"bytes32"},{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"val_","type":"uint128"},{"name":"zzz_","type":"uint32"},{"name":"med_","type":"address"}],"name":"post","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"authority_","type":"address"}],"name":"setAuthority","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"zzz","outputs":[{"name":"","type":"uint32"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"void","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"authority","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":true,"inputs":[{"indexed":true,"name":"sig","type":"bytes4"},{"indexed":true,"name":"guy","type":"address"},{"indexed":true,"name":"foo","type":"bytes32"},{"indexed":true,"name":"bar","type":"bytes32"},{"indexed":false,"name":"wad","type":"uint256"},{"indexed":false,"name":"fax","type":"bytes"}],"name":"LogNote","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"authority","type":"address"}],"name":"LogSetAuthority","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"owner","type":"address"}],"name":"LogSetOwner","type":"event"}];

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- MedianizerPep ----------");
console.log("RESULT: medianizerPepAddress=" + getAddressName(medianizerPepAddress));
console.log("RESULT: medianizerPep.owner=" + getAddressName(medianizerPep.owner()));
console.log("RESULT: medianizerPep.authority=" + getAddressName(medianizerPep.authority()));
console.log("RESULT: medianizerPep.min=" + medianizerPep.min());
console.log("RESULT: medianizerPep.next=" + medianizerPep.next());

var latestBlock = eth.blockNumber;
// var fromBlockPep = parseInt(latestBlock) - 1000000;
var fromBlockPep = 4742900;

var logSetAuthorityEvents = medianizerPep.LogSetAuthority({}, { fromBlock: fromBlockPep, toBlock: latestBlock });
i = 0;
logSetAuthorityEvents.watch(function (error, result) {
  console.log("RESULT: pep.LogSetAuthority " + i++ + " #" + result.blockNumber + " authority=" + getAddressName(result.args.authority));
});
logSetAuthorityEvents.stopWatching();

var logSetOwnerEvents = medianizerPep.LogSetOwner({}, { fromBlock: fromBlockPep, toBlock: latestBlock });
i = 0;
logSetOwnerEvents.watch(function (error, result) {
  console.log("RESULT: pep.LogSetOwner " + i++ + " #" + result.blockNumber + " owner=" + getAddressName(result.args.owner));
});
logSetOwnerEvents.stopWatching();

var logNoteEvents = medianizerPep.LogNote({}, { fromBlock: fromBlockPep, toBlock: latestBlock });
i = 0;
logNoteEvents.watch(function (error, result) {
  // console.log("RESULT: pep.LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
  var sig = sigs[result.args.sig.substring(0, 10)];
  var data = "";
  if (sig == "poke()") {
    var pf = eth.contract(priceFeedAbi).at(result.args.guy);
    // Node missing trie - web3.eth.defaultBlock = result.blockNumber;
    var peek = pf.peek();
    data = peek[0] + "=" + new BigNumber(peek[0].substring(2), 16).shift(-18).toString() + ", " + peek[1];
  }
  console.log("RESULT: pep.LogNote " + i++ + " sig=" + sig + " guy=" + getAddressName(result.args.guy) +
    " [" + data + "]" +
    (result.args.foo == nullBytes32 ? "" : " foo=" + result.args.foo) +
    (result.args.bar == nullBytes32 ? "" : " bar=" + result.args.bar) +
    " #" + result.blockNumber + " " + result.transactionHash);
});
logNoteEvents.stopWatching();

var logValueEvents = medianizerPep.LogValue({}, { fromBlock: fromBlockPep, toBlock: latestBlock });
i = 0;
logValueEvents.watch(function (error, result) {
  console.log("RESULT: pep.LogValue " + i++ + " #" + result.blockNumber + " val=" + new BigNumber(result.args.val.substring(2), 16).shift(-18).toString());
});
logValueEvents.stopWatching();

EOF