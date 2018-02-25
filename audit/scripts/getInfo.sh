#!/bin/sh

# geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > info.txt
geth attach << EOF 

loadScript("../deployed-contracts/WETH9Gem-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.js");
loadScript("../deployed-contracts/DSTokenGov-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.js");
// MedianizerPip
// MedianizerPep
// GemPit - no functions except burn(...)
loadScript("../deployed-contracts/DSChiefAdm-0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152.js");
loadScript("../deployed-contracts/DSTokenSai-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.js");

console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

console.log("RESULT: ---------- WETH9Gems ----------");
console.log("RESULT: weth9Gem.address=" + weth9GemAddress);
console.log("RESULT: weth9Gem.symbol=" + weth9Gem.symbol());
console.log("RESULT: weth9Gem.name=" + weth9Gem.name());
console.log("RESULT: weth9Gem.decimals=" + weth9Gem.decimals());
console.log("RESULT: weth9Gem.totalSupply=" + weth9Gem.totalSupply() + " " + weth9Gem.totalSupply().shift(-weth9Gem.decimals()));

console.log("RESULT: ---------- DSTokenGov ----------");
console.log("RESULT: dsTokenGovAddress=" + dsTokenGovAddress);
console.log("RESULT: dsTokenGov.owner=" + dsTokenGov.owner());
console.log("RESULT: dsTokenGov.authority=" + dsTokenGov.authority());
console.log("RESULT: dsTokenGov.symbol=" + web3.toAscii(dsTokenGov.symbol()));
console.log("RESULT: dsTokenGov.name=" + web3.toAscii(dsTokenGov.name()));
console.log("RESULT: dsTokenGov.decimals=" + dsTokenGov.decimals());
console.log("RESULT: dsTokenGov.totalSupply=" + dsTokenGov.totalSupply() + " " + dsTokenGov.totalSupply().shift(-dsTokenGov.decimals()));

console.log("RESULT: ---------- DSChiefAdm ----------");
console.log("RESULT: dsChiefAdmAddress=" + dsChiefAdmAddress);
console.log("RESULT: dsChiefAdm.owner=" + dsChiefAdm.owner());
console.log("RESULT: dsChiefAdm.authority=" + dsChiefAdm.authority());
console.log("RESULT: dsChiefAdm.GOV=" + dsChiefAdm.GOV());
console.log("RESULT: dsChiefAdm.IOU=" + dsChiefAdm.IOU());
console.log("RESULT: dsChiefAdm.hat=" + dsChiefAdm.hat());
console.log("RESULT: dsChiefAdm.MAX_YAYS=" + dsChiefAdm.MAX_YAYS());

console.log("RESULT: ---------- DSTokenSai ----------");
console.log("RESULT: dsTokenSaiAddress=" + dsTokenSaiAddress);
console.log("RESULT: dsTokenSai.owner=" + dsTokenSai.owner());
console.log("RESULT: dsTokenSai.authority=" + dsTokenSai.authority());
console.log("RESULT: dsTokenSai.symbol=" + web3.toAscii(dsTokenSai.symbol()));
console.log("RESULT: dsTokenSai.name=" + web3.toAscii(dsTokenSai.name()));
console.log("RESULT: dsTokenSai.decimals=" + dsTokenSai.decimals());
console.log("RESULT: dsTokenSai.totalSupply=" + dsTokenSai.totalSupply() + " " + dsTokenSai.totalSupply().shift(-dsTokenSai.decimals()));




EOF
