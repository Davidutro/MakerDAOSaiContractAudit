# GetSaiTapValues

## Web3 Deploy

```javascript
var getsaitapvaluesContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"bid","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"ask","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"s2s","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"wad","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_wad","type":"uint256"}],"name":"update","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"saiTap","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"}]);
var getsaitapvalues = getsaitapvaluesContract.new(
   {
     from: web3.eth.accounts[0], 
     data: '0x608060405260008054600160a060020a03191673bda109309f9fafa6dd6a9cb9f1df4085b27ee8ef17905534801561003657600080fd5b506103a0806100466000396000f3006080604052600436106100775763ffffffff7c01000000000000000000000000000000000000000000000000000000006000350416631998aeef811461007c5780634a896384146100a357806365d1df24146100b85780637df38c5b146100cd57806382ab890a146100e25780639bc64cc8146100fc575b600080fd5b34801561008857600080fd5b5061009161013a565b60408051918252519081900360200190f35b3480156100af57600080fd5b50610091610140565b3480156100c457600080fd5b50610091610146565b3480156100d957600080fd5b5061009161014c565b3480156100ee57600080fd5b506100fa600435610152565b005b34801561010857600080fd5b50610111610358565b6040805173ffffffffffffffffffffffffffffffffffffffff9092168252519081900360200190f35b60035481565b60045481565b60025481565b60015481565b806001819055506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166365d1df246040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b1580156101de57600080fd5b505af11580156101f2573d6000803e3d6000fd5b505050506040513d602081101561020857600080fd5b505160025560008054604080517f454a2ab300000000000000000000000000000000000000000000000000000000815260048101859052905173ffffffffffffffffffffffffffffffffffffffff9092169263454a2ab3926024808401936020939083900390910190829087803b15801561028257600080fd5b505af1158015610296573d6000803e3d6000fd5b505050506040513d60208110156102ac57600080fd5b505160035560008054604080517fe47e7e6600000000000000000000000000000000000000000000000000000000815260048101859052905173ffffffffffffffffffffffffffffffffffffffff9092169263e47e7e66926024808401936020939083900390910190829087803b15801561032657600080fd5b505af115801561033a573d6000803e3d6000fd5b505050506040513d602081101561035057600080fd5b505160045550565b60005473ffffffffffffffffffffffffffffffffffffffff16815600a165627a7a7230582085097fb028ea7a931c41b2e004b14e470c0e66a6b276902ef1542a219fa252c50029', 
     gas: '1000000',
     gasPrice: web3.toWei(6, "gwei")
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
// INFO [06-10|02:47:16] Submitted contract creation              fullhash=0x909e4691781c485a84c0cf4bd10eaad7740c2911d00e55db8f692e8f74e23e16 contract=0x6cE12021D13AFF57f5c35844efd3353dB0189D2f
// Contract mined! address: 0x6ce12021d13aff57f5c35844efd3353db0189d2f transactionHash: 0x909e4691781c485a84c0cf4bd10eaad7740c2911d00e55db8f692e8f74e23e16

// 1000000.000000000 000000000
 var tx2 = getsaitapvalues.update("1000000000000000000000000", {from: eth.accounts[0], gas: "1000000", gasPrice: web3.toWei(6, "gwei")});
// INFO [06-10|02:49:52] Submitted transaction                    fullhash=0xcc137766725f0d792ba7acd839b228d37f50437e22137edd28d260fe03aadc5f recipient=0x6cE12021D13AFF57f5c35844efd3353dB0189D2f

var wad = getsaitapvalues.wad();
var s2s = getsaitapvalues.s2s();
var bid = getsaitapvalues.bid();
var ask = getsaitapvalues.ask();
console.log("wad=" + wad.toFixed(0) + " " + wad.shift(-18) + " " + wad.shift(-27));
console.log("s2s=" + s2s.toFixed(0) + " " + s2s.shift(-18) + " " + s2s.shift(-27));
console.log("bid=" + bid.toFixed(0) + " " + bid.shift(-18) + " " + bid.shift(-27));
console.log("ask=" + ask.toFixed(0) + " " + ask.shift(-18) + " " + ask.shift(-27));

> var wad = getsaitapvalues.wad();
undefined
> var s2s = getsaitapvalues.s2s();
undefined
> var bid = getsaitapvalues.bid();
undefined
> var ask = getsaitapvalues.ask();
undefined
> console.log("wad=" + wad.toFixed(0) + " " + wad.shift(-18) + " " + wad.shift(-27));
wad=1000000000000000000000000 1000000 0.001
undefined
> console.log("s2s=" + s2s.toFixed(0) + " " + s2s.shift(-18) + " " + s2s.shift(-27));
s2s=609407526508371291433306584991 609407526508.371291433306584991 609.407526508371291433306584991
undefined
> console.log("bid=" + bid.toFixed(0) + " " + bid.shift(-18) + " " + bid.shift(-27));
bid=627689752303622430176305783 627689752.303622430176305783 0.627689752303622430176305783
undefined
> console.log("ask=" + ask.toFixed(0) + " " + ask.shift(-18) + " " + ask.shift(-27));
ask=591125300713120152690307387 591125300.713120152690307387 0.591125300713120152690307387
undefined

 ```