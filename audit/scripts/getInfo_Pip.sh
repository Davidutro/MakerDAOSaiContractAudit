#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > pip.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.js");
var nullBytes32 = "0x0000000000000000000000000000000000000000000000000000000000000000";
var priceFeedAbi = [{"constant":false,"inputs":[{"name":"owner_","type":"address"}],"name":"setOwner","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"read","outputs":[{"name":"","type":"bytes32"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"peek","outputs":[{"name":"","type":"bytes32"},{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"val_","type":"uint128"},{"name":"zzz_","type":"uint32"},{"name":"med_","type":"address"}],"name":"post","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"authority_","type":"address"}],"name":"setAuthority","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"zzz","outputs":[{"name":"","type":"uint32"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"void","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"authority","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":true,"inputs":[{"indexed":true,"name":"sig","type":"bytes4"},{"indexed":true,"name":"guy","type":"address"},{"indexed":true,"name":"foo","type":"bytes32"},{"indexed":true,"name":"bar","type":"bytes32"},{"indexed":false,"name":"wad","type":"uint256"},{"indexed":false,"name":"fax","type":"bytes"}],"name":"LogNote","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"authority","type":"address"}],"name":"LogSetAuthority","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"owner","type":"address"}],"name":"LogSetOwner","type":"event"}];

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- MedianizerPip ----------");
console.log("RESULT: medianizerPipAddress=" + getAddressName(medianizerPipAddress));
console.log("RESULT: medianizerPip.owner=" + getAddressName(medianizerPip.owner()));
console.log("RESULT: medianizerPip.authority=" + getAddressName(medianizerPip.authority()));
console.log("RESULT: medianizerPip.min=" + medianizerPip.min());
console.log("RESULT: medianizerPip.next=" + medianizerPip.next());

var latestBlock = eth.blockNumber;
// var fromBlockPip = parseInt(latestBlock) - 2000000;
var fromBlockPip = 3684349;

var logSetAuthorityEvents = medianizerPip.LogSetAuthority({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
i = 0;
logSetAuthorityEvents.watch(function (error, result) {
  console.log("RESULT: pip.LogSetAuthority " + i++ + " #" + result.blockNumber + " authority=" + getAddressName(result.args.authority));
});
logSetAuthorityEvents.stopWatching();

var logSetOwnerEvents = medianizerPip.LogSetOwner({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
i = 0;
logSetOwnerEvents.watch(function (error, result) {
  console.log("RESULT: pip.LogSetOwner " + i++ + " #" + result.blockNumber + " owner=" + getAddressName(result.args.owner));
});
logSetOwnerEvents.stopWatching();

var logNoteEvents = medianizerPip.LogNote({}, { fromBlock: fromBlockPip, toBlock: latestBlock });
// var logNoteEvents = medianizerPip.LogNote({}, { fromBlock: fromBlockPip, toBlock: parseInt(fromBlockPip) + 100000 });
i = 0;
logNoteEvents.watch(function (error, result) {
  // console.log("RESULT: pip.LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
  var sig = sigs[result.args.sig.substring(0, 10)];
  var data = "";
  if (sig == "poke()") {
    var pf = eth.contract(priceFeedAbi).at(result.args.guy);
    // Node missing trie - web3.eth.defaultBlock = result.blockNumber;
    var peek = pf.peek();
    if (peek[0].length > 10) {
      data = peek[0] + "=" + new BigNumber(peek[0].substring(2), 16).shift(-18).toString() + ", " + peek[1];
    } else {
      data = peek;
    }
  }
  console.log("RESULT: pip.LogNote " + i++ + " sig=" + sig + " guy=" + getAddressName(result.args.guy) +
    " [" + data + "]" +
    (result.args.foo == nullBytes32 ? "" : " foo=" + result.args.foo) +
    (result.args.bar == nullBytes32 ? "" : " bar=" + result.args.bar) +
    " #" + result.blockNumber + " " + result.transactionHash);
});
logNoteEvents.stopWatching();

EOF
