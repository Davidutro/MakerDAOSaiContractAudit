# GetSaiTubValues

## Web3 Deploy #1

```javascript
var getsaitubvaluesContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"rhi","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"cup","outputs":[{"name":"","type":"bytes32"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"saiTub","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_cup","type":"bytes32"}],"name":"updateTabRap","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"chi","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"updateRest","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"tab","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"din","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"rap","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"}]);
var getsaitubvalues = getsaitubvaluesContract.new(
   {
     from: web3.eth.accounts[0],
     data: '0x608060405260008054600160a060020a03191673448a5065aebb8e423f0896e6c5d525c040f59af317905534801561003657600080fd5b506104de806100466000396000f3006080604052600436106100985763ffffffff7c0100000000000000000000000000000000000000000000000000000000600035041663338a0261811461009d5780633ad10beb146100c457806389dcd64f146100d95780639edcebbb1461010a578063c92aecc414610124578063ca76e54814610139578063db9cd8d31461014e578063e0ae96e914610163578063ecd08bc314610178575b600080fd5b3480156100a957600080fd5b506100b261018d565b60408051918252519081900360200190f35b3480156100d057600080fd5b506100b2610193565b3480156100e557600080fd5b506100ee610199565b60408051600160a060020a039092168252519081900360200190f35b34801561011657600080fd5b506101226004356101a8565b005b34801561013057600080fd5b506100b26102de565b34801561014557600080fd5b506101226102e4565b34801561015a57600080fd5b506100b26104a0565b34801561016f57600080fd5b506100b26104a6565b34801561018457600080fd5b506100b26104ac565b60065481565b60015481565b600054600160a060020a031681565b600181905560008054604080517ff7c8d634000000000000000000000000000000000000000000000000000000008152600481018590529051600160a060020a039092169263f7c8d634926024808401936020939083900390910190829087803b15801561021557600080fd5b505af1158015610229573d6000803e3d6000fd5b505050506040513d602081101561023f57600080fd5b505160025560008054604080517f6f78ee0d000000000000000000000000000000000000000000000000000000008152600481018590529051600160a060020a0390921692636f78ee0d926024808401936020939083900390910190829087803b1580156102ac57600080fd5b505af11580156102c0573d6000803e3d6000fd5b505050506040513d60208110156102d657600080fd5b505160035550565b60055481565b6000809054906101000a9004600160a060020a0316600160a060020a031663e0ae96e96040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b15801561034f57600080fd5b505af1158015610363573d6000803e3d6000fd5b505050506040513d602081101561037957600080fd5b5051600490815560008054604080517fc92aecc40000000000000000000000000000000000000000000000000000000081529051600160a060020a039092169363c92aecc493828201936020939092908390030190829087803b1580156103df57600080fd5b505af11580156103f3573d6000803e3d6000fd5b505050506040513d602081101561040957600080fd5b505160055560008054604080517f338a02610000000000000000000000000000000000000000000000000000000081529051600160a060020a039092169263338a0261926004808401936020939083900390910190829087803b15801561046f57600080fd5b505af1158015610483573d6000803e3d6000fd5b505050506040513d602081101561049957600080fd5b5051600655565b60025481565b60045481565b600354815600a165627a7a723058200c0efbd43fc5483730b5bbe90d4834fb51779a168b3f011396f9eb6fd0caed2c0029',
     gas: '1000000',
     gasPrice: web3.toWei(6, "gwei")
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })

INFO [06-10|02:12:15] Submitted contract creation              fullhash=0x10dd653907cf0b13f22a26ed344cd237f1dbb9e6d292f9b66ab4afaf820c052e contract=0x2f5C4a85d7E133C4FeFa5a0C0ba1447A1AF86996

Contract mined! address: 0x2f5c4a85d7e133c4fefa5a0c0ba1447a1af86996 transactionHash: 0x10dd653907cf0b13f22a26ed344cd237f1dbb9e6d292f9b66ab4afaf820c052e

var cup = "0x0000000000000000000000000000000000000000000000000000000000000889";
var tx1 = getsaitubvalues.updateTabRap(cup, {from: eth.accounts[0], gas: "1000000", gasPrice: web3.toWei(6, "gwei")});

INFO [06-10|02:15:43] Submitted transaction                    fullhash=0xc2a0bc4ee10700de7e5ced018d9adfafa9064683f336a1610d1566fb7b42b114 recipient=0x2f5C4a85d7E133C4FeFa5a0C0ba1447A1AF86996

var tx2 = getsaitubvalues.updateRest({from: eth.accounts[0], gas: "1000000", gasPrice: web3.toWei(6, "gwei")});

INFO [06-10|02:16:16] Submitted transaction                    fullhash=0xf04bb83ccb6da2df738eb2c21f5bfbb163714516e8877710954f33174e72514c recipient=0x2f5C4a85d7E133C4FeFa5a0C0ba1447A1AF86996
```

<br />

## Values

```javascript
var tab = getsaitubvalues.tab();
var rap = getsaitubvalues.rap();
var din = getsaitubvalues.din();
var chi = getsaitubvalues.chi();
var rhi = getsaitubvalues.rhi();
console.log("tab=" + tab.toFixed(0) + " " + tab.shift(-18) + " " + tab.shift(-27));
console.log("rap=" + rap.toFixed(0) + " " + rap.shift(-18) + " " + rap.shift(-27));
console.log("din=" + din.toFixed(0) + " " + din.shift(-18) + " " + din.shift(-27));
console.log("chi=" + chi.toFixed(0) + " " + chi.shift(-18) + " " + chi.shift(-27));
console.log("rhi=" + rhi.toFixed(0) + " " + rhi.shift(-18) + " " + rhi.shift(-27));

var cup = "0x0000000000000000000000000000000000000000000000000000000000000889";
> new BigNumber("889", 16).toString()
"2185"

// tab is wad
> console.log("tab=" + tab.toFixed(0) + " " + tab.shift(-18) + " " + tab.shift(-27));
tab=30000000000000000000000 30000 0.00003
undefined

// rap is wad
> console.log("rap=" + rap.toFixed(0) + " " + rap.shift(-18) + " " + rap.shift(-27));
rap=1535202848492061918 1.535202848492061918 1.535202848492061918e-9
undefined

// tub.rum=42327618538450982377855082 42327618.538450982377855082 wad
// function din() public returns (uint) {
//     return rmul(rum, chi());
// }

// din is wad
> console.log("din=" + din.toFixed(0) + " " + din.shift(-18) + " " + din.shift(-27));
din=42329124538450982377855082 42329124.538450982377855082 0.042329124538450982377855082
undefined

// chi is ray
> console.log("chi=" + chi.toFixed(0) + " " + chi.shift(-18) + " " + chi.shift(-27));
chi=1000000000000000000000000000 1000000000 1
undefined

// rhi is ray
> console.log("rhi=" + rhi.toFixed(0) + " " + rhi.shift(-18) + " " + rhi.shift(-27));
rhi=1002374232345434705158023099 1002374232.345434705158023099 1.002374232345434705158023099
undefined
```

## Web3 Deploy #2

```javascript
var getsaitubvaluesContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"tag","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"saiTub","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"update","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]);
var getsaitubvalues = getsaitubvaluesContract.new(
   {
     from: web3.eth.accounts[0], 
     data: '0x608060405260008054600160a060020a03191673448a5065aebb8e423f0896e6c5d525c040f59af317905534801561003657600080fd5b506101db806100466000396000f3006080604052600436106100565763ffffffff7c010000000000000000000000000000000000000000000000000000000060003504166351f91066811461005b57806389dcd64f14610082578063a2e62045146100c0575b600080fd5b34801561006757600080fd5b506100706100d7565b60408051918252519081900360200190f35b34801561008e57600080fd5b506100976100dd565b6040805173ffffffffffffffffffffffffffffffffffffffff9092168252519081900360200190f35b3480156100cc57600080fd5b506100d56100f9565b005b60015481565b60005473ffffffffffffffffffffffffffffffffffffffff1681565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166351f910666040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b15801561017e57600080fd5b505af1158015610192573d6000803e3d6000fd5b505050506040513d60208110156101a857600080fd5b50516001555600a165627a7a723058206baa0fcebcf40f16b8e989d8aee427c12467e4f87307af2e73d4188c24c11c190029', 
     gas: '1000000',
     gasPrice: web3.toWei(6, "gwei")
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })

// INFO [06-10|02:59:09] Submitted contract creation              fullhash=0x61cfa0de21401f9bc30fd92204e6f1d43b1204111c9755d0998670c62a9a65bf contract=0x0c3A309bB8d8541EE4F519C8bbc17294b23a462B
// Contract mined! address: 0x0c3a309bb8d8541ee4f519c8bbc17294b23a462b transactionHash: 0x61cfa0de21401f9bc30fd92204e6f1d43b1204111c9755d0998670c62a9a65bf


var tx = getsaitubvalues.update({from: eth.accounts[0], gas: "1000000", gasPrice: web3.toWei(6, "gwei")});
// INFO [06-10|03:00:37] Submitted transaction                    fullhash=0x05691b044dc43069398be31573ddec5dd6c38a67c2c1cbfdea2775c72e32c834 recipient=0x0c3A309bB8d8541EE4F519C8bbc17294b23a462B

var tag = getsaitubvalues.tag();
console.log("tag=" + tag.toFixed(0) + " " + tag.shift(-18) + " " + tag.shift(-27));

> var tag = getsaitubvalues.tag();
undefined
> console.log("tag=" + tag.toFixed(0) + " " + tag.shift(-18) + " " + tag.shift(-27));
tag=609407526508371291433306584991 609407526508.371291433306584991 609.407526508371291433306584991
undefined
```