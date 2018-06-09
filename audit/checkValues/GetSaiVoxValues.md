# GetSaiVoxValues

## Web3 Deploy

```javascript
var getsaivoxvaluesContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"saiVox","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"par","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"way","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"update","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]);
var getsaivoxvalues = getsaivoxvaluesContract.new(
   {
     from: web3.eth.accounts[0], 
     data: '0x608060405260008054600160a060020a031916739b0f70df76165442ca6092939132bbaea77f2d7a17905534801561003657600080fd5b5061029e806100466000396000f3006080604052600436106100615763ffffffff7c0100000000000000000000000000000000000000000000000000000000600035041663071c802b8114610066578063495d32cb146100a45780635d6542af146100cb578063a2e62045146100e0575b600080fd5b34801561007257600080fd5b5061007b6100f7565b6040805173ffffffffffffffffffffffffffffffffffffffff9092168252519081900360200190f35b3480156100b057600080fd5b506100b9610113565b60408051918252519081900360200190f35b3480156100d757600080fd5b506100b9610119565b3480156100ec57600080fd5b506100f561011f565b005b60005473ffffffffffffffffffffffffffffffffffffffff1681565b60015481565b60025481565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663495d32cb6040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b1580156101a457600080fd5b505af11580156101b8573d6000803e3d6000fd5b505050506040513d60208110156101ce57600080fd5b505160015560008054604080517f5d6542af000000000000000000000000000000000000000000000000000000008152905173ffffffffffffffffffffffffffffffffffffffff90921692635d6542af926004808401936020939083900390910190829087803b15801561024157600080fd5b505af1158015610255573d6000803e3d6000fd5b505050506040513d602081101561026b57600080fd5b50516002555600a165627a7a72305820349beef8abc7deb91618713c213777fcf6194f772cbf64e6940e3227358951bb0029', 
     gas: '1000000'
     gasPrice: web3.toWei(6, "gwei")
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })

// INFO [06-10|02:35:32] Submitted contract creation              fullhash=0x4285940b6544742169a161a2d299854029a962a287feb26dd8fa622fc6c9244f contract=0x57eb0fE9BE26e62673033aE0BB38C23647a68867
// Contract mined! address: 0x57eb0fe9be26e62673033ae0bb38c23647a68867 transactionHash: 0x4285940b6544742169a161a2d299854029a962a287feb26dd8fa622fc6c9244f


var tx2 = getsaivoxvalues.update({from: eth.accounts[0], gas: "1000000", gasPrice: web3.toWei(6, "gwei")});
// INFO [06-10|02:39:26] Submitted transaction                    fullhash=0xa0e53f1fb69f78fcdd190964d43db4d4bc5b3ffc176afa17d2f9e29cece1b107 recipient=0x57eb0fE9BE26e62673033aE0BB38C23647a68867
undefined

var par = getsaivoxvalues.par();
var way = getsaivoxvalues.way();
console.log("par=" + par.toFixed(0) + " " + par.shift(-18) + " " + par.shift(-27));
console.log("way=" + way.toFixed(0) + " " + way.shift(-18) + " " + way.shift(-27));

> var par = getsaivoxvalues.par();
undefined
> var way = getsaivoxvalues.way();
undefined
> console.log("par=" + par.toFixed(0) + " " + par.shift(-18) + " " + par.shift(-27));
par=1000000000000000000000000000 1000000000 1
undefined
> console.log("way=" + way.toFixed(0) + " " + way.shift(-18) + " " + way.shift(-27));
way=1000000000000000000000000000 1000000000 1
undefined

```