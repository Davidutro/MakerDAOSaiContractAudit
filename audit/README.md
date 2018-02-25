# MakerDAO Sai Contract Audit

Status: Just starting to look into the MakerDAO system

## Summary

<br />

<hr />

## Table Of Contents

* [Scope](#scope)
* [Terminology](#terminology)
* [References](#references)
* [Previous Audit](#previous-audit)

<br />

<hr />

## Scope

From [https://github.com/dapphub/nixpkgs-dapphub/blob/master/known-contracts.nix](https://github.com/dapphub/nixpkgs-dapphub/blob/master/known-contracts.nix)
only the 2017-12 contracts are in scope:

```javascript
{
  mkr-2016-03 = "0xC66eA802717bFb9833400264Dd12c2bCeAa34a6d";
  mkr-2017-11 = "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2";
  weth-2016-06 = "0xECF8F87f810EcF450940c9f60066b4a7a501d6A7";
  weth-2017-12 = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2";
  mkr-redeemer-2017-12 = "0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C";
  oasis-2017-09 = "0x3Aa927a97594c3ab7d7bf0d47C71c3877D1DE4A1";
  oasis-2017-12 = "0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425";
  sai-2017-07 = "0x59aDCF176ED2f6788A41B8eA4c4904518e62B6A4";
  dai-2017-12 = "0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359";

  dai-gem-2017-12 = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2";
  dai-gov-2017-12 = "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2";
  dai-pip-2017-12 = "0x729D19f657BD0614b4985Cf1D82531c67569197B";
  dai-pep-2017-12 = "0x99041F808D598B782D5a3e498681C2452A31da08";
  dai-pit-2017-12 = "0x69076e44a9C70a67D5b79d95795Aba299083c275";
  dai-adm-2017-12 = "0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152";
  dai-sai-2017-12 = "0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359";
  dai-sin-2017-12 = "0x79F6D0f646706E1261aCF0b93DCB864f357d4680";
  dai-skr-2017-12 = "0xf53AD2c6851052A81B42133467480961B2321C09";
  dai-dad-2017-12 = "0x315cBb88168396D12e1a255f9Cb935408fe80710";
  dai-mom-2017-12 = "0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C";
  dai-vox-2017-12 = "0x9B0F70Df76165442ca6092939132bBAEA77f2d7A";
  dai-tub-2017-12 = "0x448a5065aeBB8E423F0896E6c5D525C040f59af3";
  dai-tap-2017-12 = "0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF";
  dai-top-2017-12 = "0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3";
}
```

<br />

```javascript
  mkr-2016-03 = "0xC66eA802717bFb9833400264Dd12c2bCeAa34a6d";
  mkr-2017-11 = "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2"; // dai-gov-2017-12
  weth-2016-06 = "0xECF8F87f810EcF450940c9f60066b4a7a501d6A7";
  weth-2017-12 = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2"; // dai-gem-2017-12
  mkr-redeemer-2017-12 = "0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C";
  oasis-2017-09 = "0x3Aa927a97594c3ab7d7bf0d47C71c3877D1DE4A1";
  oasis-2017-12 = "0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425";
  sai-2017-07 = "0x59aDCF176ED2f6788A41B8eA4c4904518e62B6A4";
  dai-2017-12 = "0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359"; // dai-sai-2017-12
```

### 2017-12 Contracts

Name | Address | Code | JS
--- | --- | --- | ---
dai-gem-2017-12<br />WETH9 | [0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2#code) | [WETH9Gem.sol](deployed-contracts/WETH9Gem-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.sol) | [WETH9Gem.js](deployed-contracts/WETH9Gem-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.js)
dai-gov-2017-12<br />DSToken | [0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2](https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2#code) | [DSTokenGov.sol](deployed-contracts/DSTokenGov-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.sol) | [DSTokenGov.js](deployed-contracts/DSTokenGov-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.js)
dai-pip-2017-12<br />Medianizer (May 15) | [0x729D19f657BD0614b4985Cf1D82531c67569197B](https://etherscan.io/address/0x729D19f657BD0614b4985Cf1D82531c67569197B#code) | [MedianizerPip.sol](deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.sol) | [MedianizerPip.js](deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.js)
dai-pep-2017-12<br />Medianizer | [0x99041F808D598B782D5a3e498681C2452A31da08](https://etherscan.io/address/0x99041F808D598B782D5a3e498681C2452A31da08#code) | [MedianizerPep.sol](deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.sol) | [MedianizerPep.js](deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.js)
dai-pit-2017-12<br />GemPit | [0x69076e44a9C70a67D5b79d95795Aba299083c275](https://etherscan.io/address/0x69076e44a9C70a67D5b79d95795Aba299083c275#code) | [GemPit.sol](deployed-contracts/GemPit-0x69076e44a9C70a67D5b79d95795Aba299083c275.sol) | [GemPit.js](deployed-contracts/GemPit-0x69076e44a9C70a67D5b79d95795Aba299083c275.js)
dai-adm-2017-12<br />DSChief | [0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152](https://etherscan.io/address/0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152#code) | [DSChiefAdm.sol](deployed-contracts/DSChiefAdm-0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152.sol) | [DSChiefAdm.js](deployed-contracts/DSChiefAdm-0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152.js)
dai-sai-2017-12<br />DSToken | [0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359](https://etherscan.io/address/0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359#code) | [DSTokenSai.sol](deployed-contracts/DSTokenSai-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.sol) | [DSTokenSai.js](deployed-contracts/DSTokenSai-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.js)
dai-sin-2017-12<br />DSToken | [0x79F6D0f646706E1261aCF0b93DCB864f357d4680](https://etherscan.io/address/0x79F6D0f646706E1261aCF0b93DCB864f357d4680#code) | [DSTokenSin.sol](deployed-contracts/DSTokenSin-0x79F6D0f646706E1261aCF0b93DCB864f357d4680.sol) | [DSTokenSin.js](deployed-contracts/DSTokenSin-0x79F6D0f646706E1261aCF0b93DCB864f357d4680.js)
dai-skr-2017-12<br />DSToken | [0xf53AD2c6851052A81B42133467480961B2321C09](https://etherscan.io/address/0xf53AD2c6851052A81B42133467480961B2321C09#code) | [DSTokenSkr.sol](deployed-contracts/DSTokenSkr-0xf53AD2c6851052A81B42133467480961B2321C09.sol) | [DSTokenSkr.js](deployed-contracts/DSTokenSkr-0xf53AD2c6851052A81B42133467480961B2321C09.js)
dai-dad-2017-12<br />DSGuard | [0x315cBb88168396D12e1a255f9Cb935408fe80710](https://etherscan.io/address/0x315cBb88168396D12e1a255f9Cb935408fe80710#code) | [DSGuardDad.sol](deployed-contracts/DSGuardDad-0x315cBb88168396D12e1a255f9Cb935408fe80710.sol) | [DSGuardDad.js](deployed-contracts/DSGuardDad-0x315cBb88168396D12e1a255f9Cb935408fe80710.js)
dai-mom-2017-12 | [0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C](https://etherscan.io/address/0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C#code) | [SaiMom.sol](deployed-contracts/SaiMom-0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C.sol) | [SaiMom.js](deployed-contracts/SaiMom-0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C.js)
dai-vox-2017-12 | [0x9B0F70Df76165442ca6092939132bBAEA77f2d7A](https://etherscan.io/address/0x9B0F70Df76165442ca6092939132bBAEA77f2d7A#code) | [SaiVox.sol](deployed-contracts/SaiVox-0x9B0F70Df76165442ca6092939132bBAEA77f2d7A.sol) | [SaiVox.js](deployed-contracts/SaiVox-0x9B0F70Df76165442ca6092939132bBAEA77f2d7A.js)
dai-tub-2017-12 | [0x448a5065aeBB8E423F0896E6c5D525C040f59af3](https://etherscan.io/address/0x448a5065aeBB8E423F0896E6c5D525C040f59af3#code) | [SaiTub.sol](deployed-contracts/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.sol) | [SaiTub.js](deployed-contracts/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.js)
dai-tap-2017-12 | [0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF](https://etherscan.io/address/0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF#code) | [SaiTap.sol](deployed-contracts/SaiTap-0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF.sol) | [SaiTap.js](deployed-contracts/SaiTap-0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF.js)
dai-top-2017-12 | [0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3](https://etherscan.io/address/0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3#code) | [SaiTop.sol](deployed-contracts/SaiTop-0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3.sol) | [SaiTop.js](deployed-contracts/SaiTop-0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3.js)

<br />

### Older Contracts
* Old MKR - mkr-2016-03 @ [0xC66eA802717bFb9833400264Dd12c2bCeAa34a6d](https://etherscan.io/address/0xC66eA802717bFb9833400264Dd12c2bCeAa34a6d#code)
* New MKR - mkr-2017-11 @ [0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2](https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2#code)
* weth-2016-06 @ [0xECF8F87f810EcF450940c9f60066b4a7a501d6A7](https://etherscan.io/address/0xECF8F87f810EcF450940c9f60066b4a7a501d6A7#code)
* oasis-2017-09 @ [0x3Aa927a97594c3ab7d7bf0d47C71c3877D1DE4A1](https://etherscan.io/address/0x3Aa927a97594c3ab7d7bf0d47C71c3877D1DE4A1#code)
* sai-2017-07 @ [0x59aDCF176ED2f6788A41B8eA4c4904518e62B6A4](https://etherscan.io/address/0x59aDCF176ED2f6788A41B8eA4c4904518e62B6A4#code)

<br />

### See Also

* [https://github.com/dapphub/dappsys](https://github.com/dapphub/dappsys)

<br />

<hr />

## Terminology

See page 20 of [The Dai Stablecoin System Whitepaper](https://makerdao.com/whitepaper/DaiDec17WP.pdf).

* CDP - Collateralised Debt Position
* PETH - Pooled Ether (supported in the initial Single-Collateral Dai vs the Multi-Collateral Dai coming later)
* TRFM - Target Rate Feedback Mechanism
* Target Rate
* Target Price
* TRFM’s Sensitivity Parameter - determines the magnitude of Target Rate change in response to Dai target/market price deviation
* Keepers
* Oracles
* Global Settlers
* Debt Auctions
* Collateral Auctions
* Price Feed Sensitivity Parameter

<br />

<hr />

## References

* [Sai Developer Documentation](../DEVELOPING.md)
* [MakerDAO](https://makerdao.com/)
* [What is MKR?](https://medium.com/@MakerDAO/what-is-mkr-e6915d5ca1b3)
* [The Dai Stablecoin System Whitepaper](https://makerdao.com/whitepaper/DaiDec17WP.pdf)
* [MKR token upgrade and Oasis redeployment](https://medium.com/@MakerDAO/mkr-token-upgrade-and-oasis-redeployment-2445482437d6)
* [Redeem New MKR](https://makerdao.com/redeem/)
  * [Redeemer](https://etherscan.io/address/0x642ae78fafbb8032da552d619ad43f1d81e4dd7c#code)
  * [MKR token](https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2#code)
  * [DAI Stablecoin v1.0 token](https://etherscan.io/address/0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359#code)
* [Oasis DEX](https://oasisdex.com/)
  * [matching_market.sol](https://github.com/makerdao/maker-otc/blob/master/src/matching_market.sol)
  * [simple_market.sol](https://github.com/makerdao/maker-otc/blob/master/src/simple_market.sol)
* [MakerDAO and the Dai Stablecoin](https://www.youtube.com/watch?v=ybMFi5UseEs)

<br />

<hr />

## Previous Audit

* [Single-Collateral Dai source code and security reviews](https://medium.com/@MakerDAO/single-collateral-dai-source-code-and-security-reviews-523e1a01a3c8)
  * [SAI Coin Code Review](previous-audit/SAICoinCode_Review_v1_3.pdf)
  * [Sai Security Assessment](previous-audit/Sai_Final_Report.pdf)
