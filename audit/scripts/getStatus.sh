#!/bin/sh

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > status.txt

loadScript("lookups.js");
loadScript("../deployed-contracts/DSTokenSai-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.js");
loadScript("../deployed-contracts/DSTokenSin-0x79F6D0f646706E1261aCF0b93DCB864f357d4680.js");
loadScript("../deployed-contracts/DSTokenSkr-0xf53AD2c6851052A81B42133467480961B2321C09.js");
loadScript("../deployed-contracts/WETH9Gem-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.js");
loadScript("../deployed-contracts/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.js");


console.log("RESULT: ---------- State ----------");
console.log("RESULT: eth.blockNumber=" + eth.blockNumber);
var block = eth.getBlock(eth.blockNumber);
var timestamp = new Date(block.timestamp * 1000);
console.log("RESULT: eth.block.timestamp=" + timestamp.toString());

// air = skr.balanceOf(tub);
var airCalculated = dsTokenSkr.balanceOf(getAddressFromName("tub"));
console.log("RESULT: airCalculated=skr.balanceOf(tub)=" + airCalculated.toFixed(0) + " " + airCalculated.shift(-18));

var skrTotalSupply = dsTokenSkr.totalSupply();
console.log("RESULT: skr.totalSupply=" + skrTotalSupply.toFixed(0) + " " + skrTotalSupply.shift(-18));

// pie = gem.balanceOf(tub);
var pieCalculated = weth9Gem.balanceOf(getAddressFromName("tub"));
console.log("RESULT: pieCalculated=gem.balanceOf(tub)=" + pieCalculated.toFixed(0) + " " + pieCalculated.shift(-18));

var perCalculated = pieCalculated.shift(27).div(skrTotalSupply);
console.log("RESULT: perCalculated=pie/skr.totalSupply=" + perCalculated.toFixed(0) + " " + perCalculated.shift(-27).toFixed(27));

var per = saiTub.per();
console.log("RESULT: per=pie/skr.totalSupply=" + per.toFixed(0) + " " + per.shift(-27).toFixed(27));


EOF