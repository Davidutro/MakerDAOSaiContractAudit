var sigs = {};

function addSig(sig) {
  var bytes4 = web3.sha3(sig).substring(0, 10);
  sigs[bytes4] = sig;
}

// From DaiFab
addSig("configAuth(DSAuthority)");
addSig("configAuth(address)");
addSig("cage(uint256,uint256)");
addSig("flow()");
addSig("cage(uint256)");
addSig("mint(address,uint256)");
addSig("burn(address,uint256)");
addSig("burn(uint256)");
addSig("mint(uint256)");
addSig("mold(bytes32,uint256)");
addSig("tune(uint256)");
addSig("mold(bytes32,uint256)");
addSig("setPip(address)");
addSig("setPep(address)");
addSig("setVox(address)");


var addressNames = {};

function addAddressNames(address, name) {
  var a = address.toLowerCase();
  addressNames[a] = name;
}

function getAddressName(address) {
  var a = address.toLowerCase();
  var n = addressNames[a];
  if (n !== undefined) {
    return n + " (" + address + ")";
  } else {
    return address;
  }
}

// Additional list
addAddressNames("0x01C1103d765f62a0D909499d7b615C382Cdb072d", "dadFab");
addAddressNames("0xF07674F6AC6632e253C291B694f9C2e2ED69eBBB", "fab");

// Original list
addAddressNames("0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2", "gem");
addAddressNames("0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2", "gov");
addAddressNames("0x729D19f657BD0614b4985Cf1D82531c67569197B", "pip");
addAddressNames("0x99041F808D598B782D5a3e498681C2452A31da08", "pep");
addAddressNames("0x69076e44a9c70a67d5b79d95795aba299083c275", "pit");
addAddressNames("0x8e2a84d6ade1e7fffee039a35ef5f19f13057152", "adm");
addAddressNames("0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359", "sai");
addAddressNames("0x79f6d0f646706e1261acf0b93dcb864f357d4680", "sin");
addAddressNames("0xf53ad2c6851052a81b42133467480961b2321c09", "skr");
addAddressNames("0x315cbb88168396d12e1a255f9cb935408fe80710", "dad");
addAddressNames("0xf2c5369cffb8ea6284452b0326e326dbfdcb867c", "mom");
addAddressNames("0x9b0f70df76165442ca6092939132bbaea77f2d7a", "vox");
addAddressNames("0x448a5065aebb8e423f0896e6c5d525c040f59af3", "tub");
addAddressNames("0xbda109309f9fafa6dd6a9cb9f1df4085b27ee8ef", "tap");
addAddressNames("0x9b0ccf7c8994e19f39b2b4cf708e0a7df65fa8a3", "top");
