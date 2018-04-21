#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > redeemer.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/Redeemer-0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

var names = ["redeemer"];
names.forEach(function (name) {
  console.log("RESULT: ---------- " + name + " ----------");
  var address = getAddressFromName(name);
  var contract = eth.contract(redeemerAbi).at(address);
  console.log("RESULT: " + name + "Address=" + getAddressName(address));
  console.log("RESULT: " + name + ".owner=" + getAddressName(contract.owner()));
  console.log("RESULT: " + name + ".authority=" + getAddressName(contract.authority()));
  console.log("RESULT: " + name + ".from=" + getAddressName(contract.from()));
  console.log("RESULT: " + name + ".to=" + getAddressName(contract.to()));
  console.log("RESULT: " + name + ".undo_deadline=" + contract.undo_deadline() + " " + new Date(contract.undo_deadline() * 1000).toUTCString() + " " + new Date(contract.undo_deadline() * 1000).toString());

  var latestBlock = eth.blockNumber;
  // var fromBlock = parseInt(latestBlock) - 1000000;
  var fromBlock = 4620855;

  var i;

  var logSetAuthorityEvents = contract.LogSetAuthority({}, { fromBlock: fromBlock, toBlock: latestBlock });
  i = 0;
  logSetAuthorityEvents.watch(function (error, result) {
    console.log("RESULT: " + name + ".LogSetAuthority " + i++ + " #" + result.blockNumber + " authority=" + getAddressName(result.args.authority));
  });
  logSetAuthorityEvents.stopWatching();

  var logSetOwnerEvents = contract.LogSetOwner({}, { fromBlock: fromBlock, toBlock: latestBlock });
  i = 0;
  logSetOwnerEvents.watch(function (error, result) {
    console.log("RESULT: " + name + ".LogSetOwner " + i++ + " #" + result.blockNumber + " owner=" + getAddressName(result.args.owner));
  });
  logSetOwnerEvents.stopWatching();

  var logNoteEvents = contract.LogNote({}, { fromBlock: fromBlock, toBlock: latestBlock });
  i = 0;
  logNoteEvents.watch(function (error, result) {
    var sig = sigs[result.args.sig.substring(0, 10)];
    console.log("RESULT: sig=" + sig);
    console.log("RESULT: " + name + ".LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
  });
  logNoteEvents.stopWatching();
});

EOF