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
addSig("verifyParams()");


// Pep
addSig("set(address)");
addSig("set(bytes12,address)");
addSig("setMin(uint96)");
addSig("setNext(bytes12)");
addSig("unset(bytes12)");
addSig("unset(address)");
addSig("poke()");
addSig("poke(bytes32)");
addSig("void()");
addSig("setVox(address)");
addSig("post(uint128,uint32,address)");

// Redeemer
addSig("stop()");
addSig("start()");

// Tap
addSig("heal()");
addSig("bust(uint256)");
addSig("boom(uint256)");
addSig("cage(uint256)");
addSig("cash(uint256)");
addSig("mock(uint256)");
addSig("vent()");

// Mom
addSig("setCap(uint256)");
addSig("setMat(uint256)");
addSig("setTax(uint256)");
addSig("setFee(uint256)");
addSig("setAxe(uint256)");
addSig("setTubGap(uint256)");
addSig("setPip(address)");
addSig("setPep(address)");
addSig("setVox(address)");
addSig("setTapGap(uint256)");
addSig("setWay(uint256)");
addSig("setHow(uint256)");

// Tub
addSig("turn(address)");
addSig("join(uint256)");
addSig("exit(uint256)");
addSig("drip()");
addSig("open()");
addSig("give(bytes32,address)");
addSig("lock(bytes32,uint256)");
addSig("free(bytes32,uint256)");
addSig("draw(bytes32,uint256)");
addSig("wipe(bytes32,uint256)");
addSig("shut(bytes32)");
addSig("bite(bytes32)");
addSig("cage(uint256,uint256)");

// Top
addSig("cage()");
addSig("join(uint256)");

// Vox
addSig("tell(uint256)");
addSig("prod()");
addSig("par()");
addSig("way()");

// Adm
addSig("lock(uint256)");
addSig("etch(address[])");
addSig("free(uint256)");
addSig("vote(address[])");
addSig("vote(bytes32)");
addSig("lift(address)");


var addressNames = {};
var nameAddresses = {};

function addAddressNames(address, name) {
  var a = address.toLowerCase();
  addressNames[a] = name;
  nameAddresses[name] = a;
}

function getAddressName(address) {
  var a = address.toLowerCase();
  var n = addressNames[a];
  if (n !== undefined) {
    return n + ":" + address;
  } else {
    return address;
  }
}

function getNameFromAddress(address) {
  var a = address.toLowerCase();
  var n = addressNames[a];
  if (n !== undefined) {
    return address;
  } else {
    return "";
  }
}

function getAddressFromName(name) {
  var a = nameAddresses[name];
  if (a !== undefined) {
    return a;
  } else {
    return "";
  }
}

// Additional list
addAddressNames("0x01C1103d765f62a0D909499d7b615C382Cdb072d", "dadFab");
addAddressNames("0xF07674F6AC6632e253C291B694f9C2e2ED69eBBB", "fab");
addAddressNames("0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C", "redeemer");
addAddressNames("0x347e94e12c623d7b9d51b3f143ff42b73d619773", "spell");
addAddressNames("0x7bb0b08587b8a6b8945e09f1baca426558b0f06a", "community4of6multisig");
addAddressNames("0x9aed7a25f2d928225e6fb2388055c7363ad6727b", "IOU");

var pipPriceFeeds = [
  "0x137fdd00e9a866631d8daf1a2116fb8df1ed07a7", "0x20ed77585be1b2bfd6056c64aebad41341e35907", "0x0d0ca466b85bae24ad9680840de07b094799b99f",
  "0x5e5430b97b4797cbc7adba329d7740fb31a09a11", "0x4a87875774799e2d3f15733bdab511092057d222", "0xbe4a09d4661f631f7e13aa2d5719efc476fb211c",
  "0xf63a899daf5f486131600ea31cbdd55c186b2e8b", "0xe3774af455602c5a0eacc1b0f93e3ce0f65236ce", "0x7b01f2e680eeb3c7aac02eb3e47bb5ea9a555e12",
  "0xda4cc8c36e6abef5d309e9fc3ae0209cabd078c0", "0xab6f43607f6551cdf96b95b90b44a0b7445e8934", "0xae79b12205d8d35720fff4b89584e986ccd7607a",
  "0x222eddf60e3af681dc4cf4290f95efa78237ba4a", "0xf723251896454458d4a78f1026d0155f23e853b9"
];
var iPipPriceFeeds = 0;
pipPriceFeeds.forEach(function (e) {
  iPipPriceFeeds++;
  addAddressNames(e, "pipPriceFeed-" + iPipPriceFeeds);
});

var pepPriceFeeds = ["0x8a4774fe82c63484afef97ca8d89a6ea5e21f973", "0xc442f165d9cd3ef30c555742cfb20897040ff72a", "0x712539f3491ef4dcf99f4a9b3cacd695631407cd"];
var iPepPriceFeeds = 0;
pepPriceFeeds.forEach(function (e) {
  iPepPriceFeeds++;
  addAddressNames(e, "pepPriceFeed-" + iPepPriceFeeds);
});

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
