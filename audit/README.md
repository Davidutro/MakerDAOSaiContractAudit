# MakerDAO Sai Contract Audit

## Summary

<br />

<hr />

## Table Of Contents

* [Scope](#scope)
* [Previous Audit](#previous-audit)

<br />

<hr />

## Scope

From [https://github.com/dapphub/nixpkgs-dapphub/blob/master/known-contracts.nix](https://github.com/dapphub/nixpkgs-dapphub/blob/master/known-contracts.nix)
only the 2017-12 contracts are in scope:

### 2017-12 Contracts
* [weth-2017-12](deployed-contracts/WETH9-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.sol) @ [0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2](https://etherscan.io/address/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2#code)
* [mkr-redeemer-2017-12](deployed-contracts/Redeemer-0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C.sol) @ [0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C](https://etherscan.io/address/0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C#code)
* [oasis-2017-12](deployed-contracts/MatchingMarket-0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425.sol) @ [0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425](https://etherscan.io/address/0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425#code)
* [dai-2017-12](DaiStableCoin-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.sol) @ [0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359](https://etherscan.io/address/0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359#code)
* dai-gem-2017-12 @ [0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2#code)
* [dai-gov-2017-12](deployed-contracts/MakerToken-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.sol) @ [0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2](https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2#code)
* [dai-pip-2017-12](deployed-contracts/Medianizer-0x729D19f657BD0614b4985Cf1D82531c67569197B.sol) @ [0x729D19f657BD0614b4985Cf1D82531c67569197B](https://etherscan.io/address/0x729D19f657BD0614b4985Cf1D82531c67569197B#code)
* dai-pep-2017-12 @ [0x99041F808D598B782D5a3e498681C2452A31da08](https://etherscan.io/address/0x99041F808D598B782D5a3e498681C2452A31da08#code)
* dai-pit-2017-12 @ [0x69076e44a9C70a67D5b79d95795Aba299083c275](https://etherscan.io/address/0x69076e44a9C70a67D5b79d95795Aba299083c275#code)
* dai-adm-2017-12 @ [0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152](https://etherscan.io/address/0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152#code)
* dai-sai-2017-12 @ [0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359](https://etherscan.io/address/0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359#code)
* dai-sin-2017-12 @ [0x79F6D0f646706E1261aCF0b93DCB864f357d4680](https://etherscan.io/address/0x79F6D0f646706E1261aCF0b93DCB864f357d4680#code)
* dai-skr-2017-12 @ [0xf53AD2c6851052A81B42133467480961B2321C09](https://etherscan.io/address/0xf53AD2c6851052A81B42133467480961B2321C09#code)
* dai-dad-2017-12 @ [0x315cBb88168396D12e1a255f9Cb935408fe80710](https://etherscan.io/address/0x315cBb88168396D12e1a255f9Cb935408fe80710#code)
* dai-mom-2017-12 @ [0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C](https://etherscan.io/address/0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C#code)
* dai-vox-2017-12 @ [0x9B0F70Df76165442ca6092939132bBAEA77f2d7A](https://etherscan.io/address/0x9B0F70Df76165442ca6092939132bBAEA77f2d7A#code)
* dai-tub-2017-12 @ [0x448a5065aeBB8E423F0896E6c5D525C040f59af3](https://etherscan.io/address/0x448a5065aeBB8E423F0896E6c5D525C040f59af3#code)
* dai-tap-2017-12 @ [0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF](https://etherscan.io/address/0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF#code)
* dai-top-2017-12 @ [0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3](https://etherscan.io/address/0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3#code)

### Older Contracts
* mkr-2016-03 @ [0xC66eA802717bFb9833400264Dd12c2bCeAa34a6d](https://etherscan.io/address/#code)
* mkr-2017-11 @ [0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2](https://etherscan.io/address/#code)
* weth-2016-06 @ [0xECF8F87f810EcF450940c9f60066b4a7a501d6A7](https://etherscan.io/address/#code)
* oasis-2017-09 @ [0x3Aa927a97594c3ab7d7bf0d47C71c3877D1DE4A1](https://etherscan.io/address/#code)
* sai-2017-07 @ [0x59aDCF176ED2f6788A41B8eA4c4904518e62B6A4](https://etherscan.io/address/#code)

<br />

<hr />

## Previous Audit

* [Single-Collateral Dai source code and security reviews](https://medium.com/@MakerDAO/single-collateral-dai-source-code-and-security-reviews-523e1a01a3c8)
  * [SAI Coin Code Review](previous-audit/SAICoinCode_Review_v1_3.pdf)
  * [Sai Security Assessment](previous-audit/Sai_Final_Report.pdf)
