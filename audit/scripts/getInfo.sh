#!/bin/sh

JSDIR=../deployed-contracts
TUB=$JSDIR/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.js

echo $TUB

# geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //" > info.txt
# geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
geth attach << EOF
loadScript("$TUB");

// console.log(JSON.stringify(saiTub));

console.log("RESULT: ---------- SaiTub ----------");
console.log("RESULT: saiTub.address=" + saiTubAddress);
console.log("RESULT: saiTub.sai=" + saiTub.sai());
console.log("RESULT: saiTub.sin=" + saiTub.sin());
console.log("RESULT: saiTub.skr=" + saiTub.skr());
console.log("RESULT: saiTub.gem=" + saiTub.gem());
console.log("RESULT: saiTub.gov=" + saiTub.gov());
console.log("RESULT: saiTub.vox=" + saiTub.vox());
console.log("RESULT: saiTub.pip=" + saiTub.pip());
console.log("RESULT: saiTub.pep=" + saiTub.pep());
console.log("RESULT: saiTub.tap=" + saiTub.tap());
console.log("RESULT: saiTub.pit=" + saiTub.pit());
console.log("RESULT: saiTub.axe=" + saiTub.axe());
console.log("RESULT: saiTub.cap=" + saiTub.cap());
console.log("RESULT: saiTub.mat=" + saiTub.mat());
console.log("RESULT: saiTub.tax=" + saiTub.tax());
console.log("RESULT: saiTub.fee=" + saiTub.fee());
console.log("RESULT: saiTub.gap=" + saiTub.gap());
console.log("RESULT: saiTub.off=" + saiTub.off());
console.log("RESULT: saiTub.out=" + saiTub.out());
console.log("RESULT: saiTub.fit=" + saiTub.fit());
console.log("RESULT: saiTub.rho=" + saiTub.rho());
// console.log("RESULT: saiTub.chi=" + saiTub.chi());
// console.log("RESULT: saiTub.rhi=" + saiTub.rhi());
console.log("RESULT: saiTub.rum=" + saiTub.rum());
console.log("RESULT: saiTub.din=" + saiTub.din());
console.log("RESULT: saiTub.air=" + saiTub.air() + " " + saiTub.air().shift(-18));
console.log("RESULT: saiTub.era=" + saiTub.era() + " " + new Date(saiTub.era() * 1000).toUTCString() + " " + new Date(saiTub.era() * 1000).toString());

console.log("RESULT: saiTub.cupi=" + saiTub.cupi());
for (var i = 0 /*saiTub.cupi() - 20*/; i < saiTub.cupi(); i++) {
  var h = "0x" + web3.padLeft(web3.toHex(i).substring(2), 64);
  var data = saiTub.cups(h);
  if (data[0] != "0x0000000000000000000000000000000000000000") {
    console.log("RESULT: saiTub.cups(" + i + ")=" + JSON.stringify(data));
  }
}


EOF

exit;

    DSToken  public  sai;  // Stablecoin
    DSToken  public  sin;  // Debt (negative sai)

    DSToken  public  skr;  // Abstracted collateral
    ERC20    public  gem;  // Underlying collateral

    DSToken  public  gov;  // Governance token

    SaiVox   public  vox;  // Target price feed
    DSValue  public  pip;  // Reference price feed
    DSValue  public  pep;  // Governance price feed

    address  public  tap;  // Liquidator
    address  public  pit;  // Governance Vault

    uint256  public  axe;  // Liquidation penalty
    uint256  public  cap;  // Debt ceiling
    uint256  public  mat;  // Liquidation ratio
    uint256  public  tax;  // Stability fee
    uint256  public  fee;  // Governance fee
    uint256  public  gap;  // Join-Exit Spread

    bool     public  off;  // Cage flag
    bool     public  out;  // Post cage exit

    uint256  public  fit;  // REF per SKR (just before settlement)

    uint256  public  rho;  // Time of last drip
    uint256         _chi;  // Accumulated Tax Rates
    uint256         _rhi;  // Accumulated Tax + Fee Rates
    uint256  public  rum;  // Total normalised debt

    uint256                   public  cupi;
    mapping (bytes32 => Cup)  public  cups;



exit;

loadScript("../deployed-contracts/WETH9Gem-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.js");
loadScript("../deployed-contracts/DSTokenGov-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.js");
loadScript("../deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.js");
loadScript("../deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.js");
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

console.log("RESULT: ---------- MedianizerPip ----------");
console.log("RESULT: medianizerPipAddress=" + medianizerPipAddress);
console.log("RESULT: medianizerPip.owner=" + medianizerPip.owner());
console.log("RESULT: medianizerPip.authority=" + medianizerPip.authority());

console.log("RESULT: ---------- MedianizerPep ----------");
console.log("RESULT: medianizerPepAddress=" + medianizerPepAddress);
console.log("RESULT: medianizerPep.owner=" + medianizerPep.owner());
console.log("RESULT: medianizerPep.authority=" + medianizerPep.authority());

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
