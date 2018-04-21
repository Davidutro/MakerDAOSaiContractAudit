#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > saiSinSkr.txt
// geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

loadScript("lookups.js");
loadScript("../deployed-contracts/DSTokenSai-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

var names = ["sai", "sin", "skr"];
names.forEach(function (name) {
  console.log("RESULT: ---------- " + name + " ----------");
  var address = getAddressFromName(name);
  var contract = eth.contract(dsTokenSaiAbi).at(address);
  console.log("RESULT: " + name + "Address=" + getAddressName(address));
  console.log("RESULT: " + name + ".owner=" + getAddressName(contract.owner()));
  console.log("RESULT: " + name + ".authority=" + getAddressName(contract.authority()));

  var latestBlock = eth.blockNumber;
  // var fromBlock = parseInt(latestBlock) - 1000000;
  var fromBlock = 4752008;

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
    console.log("RESULT: " + name + ".LogNote " + i++ + " #" + result.blockNumber + " " + result.transactionHash + " " + JSON.stringify(result.args));
  });
  logNoteEvents.stopWatching();

  var approvalEvents = contract.Approval({}, { fromBlock: fromBlock, toBlock: latestBlock });
  i = 0;
  approvalEvents.watch(function (error, result) {
    console.log("RESULT: " + name + ".Approval " + i++ + " #" + result.blockNumber + " src=" + getAddressName(result.args.src) + " guy=" + getAddressName(result.args.guy) + " wad=" + result.args.wad.shift(-18));
  });
  approvalEvents.stopWatching();

  var transferEvents = contract.Transfer({}, { fromBlock: fromBlock, toBlock: latestBlock });
  i = 0;
  transferEvents.watch(function (error, result) {
    console.log("RESULT: " + name + ".Transfer " + i++ + " #" + result.blockNumber + " src=" + getAddressName(result.args.src) +" dst=" + getAddressName(result.args.dst) + " wad=" + result.args.wad.shift(-18));
  });
  transferEvents.stopWatching();

  var mintEvents = contract.Mint({}, { fromBlock: fromBlock, toBlock: latestBlock });
  i = 0;
  mintEvents.watch(function (error, result) {
    console.log("RESULT: " + name + ".Mint " + i++ + " #" + result.blockNumber + " guy=" + getAddressName(result.args.guy) + " wad=" + result.args.wad.shift(-18));
  });
  mintEvents.stopWatching();

  var burnEvents = contract.Burn({}, { fromBlock: fromBlock, toBlock: latestBlock });
  i = 0;
  burnEvents.watch(function (error, result) {
    console.log("RESULT: " + name + ".Burn " + i++ + " #" + result.blockNumber + " guy=" + getAddressName(result.args.guy) + " wad=" + result.args.wad.shift(-18));
  });
  burnEvents.stopWatching();
});

EOF