var gemPitAddress="0x69076e44a9C70a67D5b79d95795Aba299083c275";
var gemPitAbi=[{"constant":false,"inputs":[{"name":"gem","type":"address"}],"name":"burn","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}];
var gemPit=web3.contract(gemPitAbi).at(gemPitAddress);