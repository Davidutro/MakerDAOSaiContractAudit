# MakerDAO Sai Contract Audit

Status: Work in progress

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

### 2017-12 Contracts

Name | Address | Code <br /> JS | Notes
--- | --- | --- | ---
dai-gem-2017-12<br />WETH9 | [0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2#code) | [WETH9Gem.sol](deployed-contracts/WETH9Gem-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.sol) <br /> [WETH9Gem.js](deployed-contracts/WETH9Gem-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.js) |
dai-gov-2017-12<br />DSToken | [0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2](https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2#code) | [DSTokenGov.sol](deployed-contracts/DSTokenGov-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.sol) <br /> [DSTokenGov.js](deployed-contracts/DSTokenGov-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.js) |
dai-pip-2017-12<br />Medianizer (10 May 17) | [0x729D19f657BD0614b4985Cf1D82531c67569197B](https://etherscan.io/address/0x729D19f657BD0614b4985Cf1D82531c67569197B#code) | [MedianizerPip.sol](deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.sol) <br /> [MedianizerPip.js](deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.js) |
dai-pep-2017-12<br />Medianizer | [0x99041F808D598B782D5a3e498681C2452A31da08](https://etherscan.io/address/0x99041F808D598B782D5a3e498681C2452A31da08#code) | [MedianizerPep.sol](deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.sol) <br /> [MedianizerPep.js](deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.js) |
dai-pit-2017-12<br />GemPit | [0x69076e44a9C70a67D5b79d95795Aba299083c275](https://etherscan.io/address/0x69076e44a9C70a67D5b79d95795Aba299083c275#code) | [GemPit.sol](deployed-contracts/GemPit-0x69076e44a9C70a67D5b79d95795Aba299083c275.sol) <br /> [GemPit.js](deployed-contracts/GemPit-0x69076e44a9C70a67D5b79d95795Aba299083c275.js) |
dai-adm-2017-12<br />DSChief | [0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152](https://etherscan.io/address/0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152#code) | [DSChiefAdm.sol](deployed-contracts/DSChiefAdm-0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152.sol) <br /> [DSChiefAdm.js](deployed-contracts/DSChiefAdm-0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152.js) |
dai-sai-2017-12<br />DSToken | [0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359](https://etherscan.io/address/0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359#code) | [DSTokenSai.sol](deployed-contracts/DSTokenSai-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.sol) <br /> [DSTokenSai.js](deployed-contracts/DSTokenSai-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.js) |
dai-sin-2017-12<br />DSToken | [0x79F6D0f646706E1261aCF0b93DCB864f357d4680](https://etherscan.io/address/0x79F6D0f646706E1261aCF0b93DCB864f357d4680#code) | [DSTokenSin.sol](deployed-contracts/DSTokenSin-0x79F6D0f646706E1261aCF0b93DCB864f357d4680.sol) <br /> [DSTokenSin.js](deployed-contracts/DSTokenSin-0x79F6D0f646706E1261aCF0b93DCB864f357d4680.js) |
dai-skr-2017-12<br />DSToken | [0xf53AD2c6851052A81B42133467480961B2321C09](https://etherscan.io/address/0xf53AD2c6851052A81B42133467480961B2321C09#code) | [DSTokenSkr.sol](deployed-contracts/DSTokenSkr-0xf53AD2c6851052A81B42133467480961B2321C09.sol) <br /> [DSTokenSkr.js](deployed-contracts/DSTokenSkr-0xf53AD2c6851052A81B42133467480961B2321C09.js) |
dai-dad-2017-12<br />DSGuard | [0x315cBb88168396D12e1a255f9Cb935408fe80710](https://etherscan.io/address/0x315cBb88168396D12e1a255f9Cb935408fe80710#code) | [DSGuardDad.sol](deployed-contracts/DSGuardDad-0x315cBb88168396D12e1a255f9Cb935408fe80710.sol) <br /> [DSGuardDad.js](deployed-contracts/DSGuardDad-0x315cBb88168396D12e1a255f9Cb935408fe80710.js) |
dai-mom-2017-12 | [0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C](https://etherscan.io/address/0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C#code) | [SaiMom.sol](deployed-contracts/SaiMom-0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C.sol) <br /> [SaiMom.js](deployed-contracts/SaiMom-0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C.js) |
dai-vox-2017-12 | [0x9B0F70Df76165442ca6092939132bBAEA77f2d7A](https://etherscan.io/address/0x9B0F70Df76165442ca6092939132bBAEA77f2d7A#code) | [SaiVox.sol](deployed-contracts/SaiVox-0x9B0F70Df76165442ca6092939132bBAEA77f2d7A.sol) <br /> [SaiVox.js](deployed-contracts/SaiVox-0x9B0F70Df76165442ca6092939132bBAEA77f2d7A.js) |
dai-tub-2017-12 | [0x448a5065aeBB8E423F0896E6c5D525C040f59af3](https://etherscan.io/address/0x448a5065aeBB8E423F0896E6c5D525C040f59af3#code) | [SaiTub.sol](deployed-contracts/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.sol) <br /> [SaiTub.js](deployed-contracts/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.js) |
dai-tap-2017-12 | [0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF](https://etherscan.io/address/0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF#code) | [SaiTap.sol](deployed-contracts/SaiTap-0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF.sol) <br /> [SaiTap.js](deployed-contracts/SaiTap-0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF.js) |
dai-top-2017-12 | [0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3](https://etherscan.io/address/0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3#code) | [SaiTop.sol](deployed-contracts/SaiTop-0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3.sol) <br /> [SaiTop.js](deployed-contracts/SaiTop-0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3.js) |
mkr-redeemer-2017-12 | [0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C](https://etherscan.io/address/0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C#code) | [Redeemer.sol](deployed-contracts/Redeemer-0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C.sol) <br /> [Redeemer.js](deployed-contracts/Redeemer-0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C.js) |
oasis-2017-12 | [0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425](https://etherscan.io/address/0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425#code) | [MatchingMarket.sol](deployed-contracts/MatchingMarket-0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425.sol) <br /> [MatchingMarket.js](deployed-contracts/MatchingMarket-0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425.js) |

Some of the contracts above were deployed from the DaiFab contract at [0xf07674f6ac6632e253c291b694f9c2e2ed69ebbb](https://etherscan.io/address/0xf07674f6ac6632e253c291b694f9c2e2ed69ebbb#code)

<br />

### Older Contracts

Not in scope:

* Old MKR - mkr-2016-03 @ [0xC66eA802717bFb9833400264Dd12c2bCeAa34a6d](https://etherscan.io/address/0xC66eA802717bFb9833400264Dd12c2bCeAa34a6d#code)
* weth-2016-06 @ [0xECF8F87f810EcF450940c9f60066b4a7a501d6A7](https://etherscan.io/address/0xECF8F87f810EcF450940c9f60066b4a7a501d6A7#code)
* oasis-2017-09 @ [0x3Aa927a97594c3ab7d7bf0d47C71c3877D1DE4A1](https://etherscan.io/address/0x3Aa927a97594c3ab7d7bf0d47C71c3877D1DE4A1#code)
* sai-2017-07 @ [0x59aDCF176ED2f6788A41B8eA4c4904518e62B6A4](https://etherscan.io/address/0x59aDCF176ED2f6788A41B8eA4c4904518e62B6A4#code)
* ?mkr-redeemer-2017-12?
* ?oasis-2017-12?

<br />

### Source Of Contracts
From [https://github.com/dapphub/nixpkgs-dapphub/blob/master/known-contracts.nix](https://github.com/dapphub/nixpkgs-dapphub/blob/master/known-contracts.nix)
only the 2017-12 contracts are in scope (comments added):

```javascript
{
  mkr-2016-03 = "0xC66eA802717bFb9833400264Dd12c2bCeAa34a6d"; // Old contract
  mkr-2017-11 = "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2"; // Same as dai-gov-2017-12
  weth-2016-06 = "0xECF8F87f810EcF450940c9f60066b4a7a501d6A7"; // Old contract
  weth-2017-12 = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2"; // Same as dai-gem-2017-12
  mkr-redeemer-2017-12 = "0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C"; // In scope
  oasis-2017-09 = "0x3Aa927a97594c3ab7d7bf0d47C71c3877D1DE4A1"; // Old contract
  oasis-2017-12 = "0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425"; // In scope?
  sai-2017-07 = "0x59aDCF176ED2f6788A41B8eA4c4904518e62B6A4"; // Old contract
  dai-2017-12 = "0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359"; // Same as dai-sai-2017-12

  dai-gem-2017-12 = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"; // In scope
  dai-gov-2017-12 = "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2"; // In scope
  dai-pip-2017-12 = "0x729D19f657BD0614b4985Cf1D82531c67569197B"; // In scope
  dai-pep-2017-12 = "0x99041F808D598B782D5a3e498681C2452A31da08"; // In scope
  dai-pit-2017-12 = "0x69076e44a9C70a67D5b79d95795Aba299083c275"; // In scope
  dai-adm-2017-12 = "0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152"; // In scope
  dai-sai-2017-12 = "0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359"; // In scope
  dai-sin-2017-12 = "0x79F6D0f646706E1261aCF0b93DCB864f357d4680"; // In scope
  dai-skr-2017-12 = "0xf53AD2c6851052A81B42133467480961B2321C09"; // In scope
  dai-dad-2017-12 = "0x315cBb88168396D12e1a255f9Cb935408fe80710"; // In scope
  dai-mom-2017-12 = "0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C"; // In scope
  dai-vox-2017-12 = "0x9B0F70Df76165442ca6092939132bBAEA77f2d7A"; // In scope
  dai-tub-2017-12 = "0x448a5065aeBB8E423F0896E6c5D525C040f59af3"; // In scope
  dai-tap-2017-12 = "0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF"; // In scope
  dai-top-2017-12 = "0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3"; // In scope
}
```

The addresses below are from [README.md#dai-v1-current-deployments](../README.md#dai-v1-current-deployments):

```sh
# sai deployment on ethlive from c2031c0f9f3a186e90b6a3c1905282f7cc58b9f5
# Mon 18 Dec 03:12:57 GMT 2017

export SAI_GEM=0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
export SAI_GOV=0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2
export SAI_PIP=0x729D19f657BD0614b4985Cf1D82531c67569197B
export SAI_PEP=0x99041F808D598B782D5a3e498681C2452A31da08
export SAI_PIT=0x69076e44a9c70a67d5b79d95795aba299083c275
export SAI_ADM=0x8e2a84d6ade1e7fffee039a35ef5f19f13057152
export SAI_SAI=0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359
export SAI_SIN=0x79f6d0f646706e1261acf0b93dcb864f357d4680
export SAI_SKR=0xf53ad2c6851052a81b42133467480961b2321c09
export SAI_DAD=0x315cbb88168396d12e1a255f9cb935408fe80710
export SAI_MOM=0xf2c5369cffb8ea6284452b0326e326dbfdcb867c
export SAI_VOX=0x9b0f70df76165442ca6092939132bbaea77f2d7a
export SAI_TUB=0x448a5065aebb8e423f0896e6c5d525c040f59af3
export SAI_TAP=0xbda109309f9fafa6dd6a9cb9f1df4085b27ee8ef
export SAI_TOP=0x9b0ccf7c8994e19f39b2b4cf708e0a7df65fa8a3
```

<br />

### See Also

* [https://github.com/dapphub/dappsys](https://github.com/dapphub/dappsys) and [https://dapp.tools/dappsys/](https://dapp.tools/dappsys/)

<br />

<hr />

## Components

Source code for the deployed contracts have been matched against the component contracts from the MakerDAO and DappSys source code repository.
[Scripts](checkComponents/checkAll.sh) and [results](checkComponents/results.txt) were used to confirm the match of the deployed
contracts against the component contracts.

* Gem ([weth9-b353893](code-review/makerdao/weth9-b353893.md)) is a standalone contract.
* SSS represents the Sai, Sin and Skr contracts that are all identical, except for the deployment parameters
* Pip - 10 May 2017. Rest Dec 2017

Component                                                          | Gov | Pip | Pep | Pit | Adm | SSS | Dad | Mom | Vox | Tub | Tap | Top
------------------------------------------------------------------ |:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:
[auth-52c6a32](code-review/dappsys/auth-52c6a32.md)                |  1  |     |  1  |  2  |  1  |  2  |  1  |  1  |  1  |  1  |  1  |  1
[auth-ce285fb](code-review/dappsys/auth-ce285fb.md)                |     |  1  |     |     |     |     |     |     |     |     |     |  
[base-e637e3f](code-review/dappsys/base-e637e3f.md)                |  7  |     |     |  6  |  8  |  6  |     |  7  |     |  7  |  7  |  7
[chief-a06b5e4](code-review/dappsys/chief-a06b5e4.md)              |     |     |     |     | 10  |     |     |     |     |     |     |  
[erc20-56f16b3](code-review/dappsys/erc20-56f16b3.md)              |  6  |     |     |     |     |     |     |     |     |     |     |  
[erc20-c4f5635](code-review/dappsys/erc20-c4f5635.md)              |     |     |     |  5  |  7  |  5  |     |  6  |     |  6  |  6  |  6
[guard-f8b7f58](code-review/dappsys/guard-f8b7f58.md)              |     |     |     |     |     |     |  2  |     |     |     |     |  
[math-a01112f](code-review/dappsys/math-a01112f.md)                |     |  3  |     |     |     |     |     |     |     |     |     |  
[math-d5acd9c](code-review/dappsys/math-d5acd9c.md)                |  2  |     |  2  |  1  |  3  |  1  |     |  3  |  3  |  3  |  3  |  3
[note-7170a08](code-review/dappsys/note-7170a08.md)                |  3  |  2  |  3  |  3  |  4  |  3  |     |  2  |  2  |  2  |  2  |  2
[roles-188b3dd](code-review/dappsys/roles-188b3dd.md)              |     |     |     |     |  2  |     |     |     |     |     |     |  
[stop-842e350](code-review/dappsys/stop-842e350.md)                |  5  |     |     |  4  |  6  |  4  |     |  5  |     |  5  |  5  |  5
[thing-35b2538](code-review/dappsys/thing-35b2538.md)              |  4  |     |  4  |     |     |     |     |     |     |     |     |  
[thing-4c86a53](code-review/dappsys/thing-4c86a53.md)              |     |     |     |     |  5  |     |     |  4  |  4  |  4  |  4  |  4
[thing-ea63fd3](code-review/dappsys/thing-ea63fd3.md)              |     |  4  |     |     |     |     |     |     |     |     |     |  
[token-e637e3f](code-review/dappsys/token-e637e3f.md)              |  8  |     |     |  7  |  9  |  7  |     |  8  |     |  8  |  8  |  8
[value-2027f97](code-review/dappsys/value-2027f97.md)              |     |  5  |     |     |     |     |     |     |     |     |     |  
[value-faae4cb](code-review/dappsys/value-faae4cb.md)              |     |     |  5  |     |     |     |     |  9  |     |  9  |  9  |  9
[medianizer-31cc0a8](code-review/medianizer/medianizer-31cc0a8.md) |     |  6  |     |     |     |     |     |     |     |     |     |  
[medianizer-6cb859c](code-review/medianizer/medianizer-6cb859c.md) |     |     |  6  |     |     |     |     |     |     |     |     |  
[pit-b353893](code-review/makerdao/pit-b353893.md)                 |     |     |     |  8  |     |     |     |     |     |     |     |  
[vox-b353893](code-review/makerdao/vox-b353893.md)                 |     |     |     |     |     |     |     | 10  |  5  | 10  | 10  | 10
[tub-b353893](code-review/makerdao/tub-b353893.md)                 |     |     |     |     |     |     |     | 11  |     | 11  | 11  | 11
[tap-b353893](code-review/makerdao/tap-b353893.md)                 |     |     |     |     |     |     |     | 12  |     |     | 12  | 12
[top-b353893](code-review/makerdao/top-b353893.md)                 |     |     |     |     |     |     |     | 13  |     |     |     | 13
[mom-b353893](code-review/makerdao/mom-b353893.md)                 |     |     |     |     |     |     |     | 14  |     |     |     |  

<br />

### DappSys

* [ ] [code-review/dappsys/auth-52c6a32.md](code-review/dappsys/auth-52c6a32.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
* [ ] [code-review/dappsys/auth-ce285fb.md](code-review/dappsys/auth-ce285fb.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
* [ ] [code-review/dappsys/base-e637e3f.md](code-review/dappsys/base-e637e3f.md)
  * [ ] contract DSTokenBase is ERC20, DSMath
* [ ] [code-review/dappsys/chief-a06b5e4.md](code-review/dappsys/chief-a06b5e4.md)
  * [ ] contract DSChiefApprovals is DSThing
  * [ ] contract DSChief is DSRoles, DSChiefApprovals
  * [ ] contract DSChiefFab
* [ ] [code-review/dappsys/erc20-56f16b3.md](code-review/dappsys/erc20-56f16b3.md)
  * [ ] contract ERC20
* [ ] [code-review/dappsys/erc20-c4f5635.md](code-review/dappsys/erc20-c4f5635.md)
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
* [ ] [code-review/dappsys/guard-f8b7f58.md](code-review/dappsys/guard-f8b7f58.md)
  * [ ] contract DSGuardEvents
  * [ ] contract DSGuard is DSAuth, DSAuthority, DSGuardEvents
  * [ ] contract DSGuardFactory
* [ ] [code-review/dappsys/math-a01112f.md](code-review/dappsys/math-a01112f.md)
  * [ ] contract DSMath
* [ ] [code-review/dappsys/math-d5acd9c.md](code-review/dappsys/math-d5acd9c.md)
  * [ ] contract DSMath
* [ ] [code-review/dappsys/note-7170a08.md](code-review/dappsys/note-7170a08.md)
  * [ ] contract DSNote
* [ ] [code-review/dappsys/roles-188b3dd.md](code-review/dappsys/roles-188b3dd.md)
  * [ ] contract DSRoles is DSAuth, DSAuthority
* [ ] [code-review/dappsys/stop-842e350.md](code-review/dappsys/stop-842e350.md)
  * [ ] contract DSStop is DSNote, DSAuth
* [ ] [code-review/dappsys/thing-35b2538.md](code-review/dappsys/thing-35b2538.md)
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
* [ ] [code-review/dappsys/thing-4c86a53.md](code-review/dappsys/thing-4c86a53.md)
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
* [ ] [code-review/dappsys/thing-ea63fd3.md](code-review/dappsys/thing-ea63fd3.md)
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
* [ ] [code-review/dappsys/token-e637e3f.md](code-review/dappsys/token-e637e3f.md)
  * [ ] contract DSToken is DSTokenBase(0), DSStop
* [ ] [code-review/dappsys/value-2027f97.md](code-review/dappsys/value-2027f97.md)
  * [ ] contract DSValue is DSThing
* [ ] [code-review/dappsys/value-faae4cb.md](code-review/dappsys/value-faae4cb.md)
  * [ ] contract DSValue is DSThing

<br />

### MakerDAO

* [ ] [code-review/makerdao/fab-b353893.md](code-review/makerdao/fab-b353893.md) **Where is this deployed to?**
  * [ ] contract GemFab
  * [ ] contract VoxFab
  * [ ] contract TubFab
  * [ ] contract TapFab
  * [ ] contract TopFab
  * [ ] contract MomFab
  * [ ] contract DadFab
  * [ ] contract DaiFab is DSAuth
* [ ] [code-review/makerdao/mom-b353893.md](code-review/makerdao/mom-b353893.md)
  * [ ] contract SaiMom is DSThing
* [ ] [code-review/makerdao/pit-b353893.md](code-review/makerdao/pit-b353893.md)
  * [ ] contract GemPit
* [ ] [code-review/makerdao/tap-b353893.md](code-review/makerdao/tap-b353893.md)
  * [ ] contract SaiTap is DSThing
* [ ] [code-review/makerdao/top-b353893.md](code-review/makerdao/top-b353893.md)
  * [ ] contract SaiTop is DSThing
* [ ] [code-review/makerdao/tub-b353893.md](code-review/makerdao/tub-b353893.md)
  * [ ] contract SaiTubEvents
  * [ ] contract SaiTub is DSThing, SaiTubEvents
* [ ] [code-review/makerdao/vox-b353893.md](code-review/makerdao/vox-b353893.md)
  * [ ] contract SaiVox is DSThing
* [ ] [code-review/makerdao/weth9-b353893.md](code-review/makerdao/weth9-b353893.md)
  * [ ] contract WETH9

<br />

### Medianizer

* [ ] [code-review/medianizer/medianizer-31cc0a8.md](code-review/medianizer/medianizer-31cc0a8.md)
  * [ ] contract Medianizer is DSValue
* [ ] [code-review/medianizer/medianizer-6cb859c.md](code-review/medianizer/medianizer-6cb859c.md)
  * [ ] contract MedianizerEvents
  * [ ] contract Medianizer is DSValue, MedianizerEvents

<br />

<hr />

## Code Review

* [x] [code-review/deployed-contracts/WETH9Gem-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.md](code-review/deployed-contracts/WETH9Gem-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.md)
  * [x] contract WETH9
* [ ] [code-review/deployed-contracts/DSTokenGov-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.md](code-review/deployed-contracts/DSTokenGov-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSMath
  * [ ] contract DSNote
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
* [ ] [code-review/deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.md](code-review/deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSNote
  * [ ] contract DSMath
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
  * [ ] contract DSValue is DSThing
  * [ ] contract Medianizer is DSValue
* [ ] [code-review/deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.md](code-review/deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSMath
  * [ ] contract DSNote
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
  * [ ] contract DSValue is DSThing
  * [ ] contract MedianizerEvents
  * [ ] contract Medianizer is DSValue, MedianizerEvents
* [ ] [code-review/deployed-contracts/GemPit-0x69076e44a9C70a67D5b79d95795Aba299083c275.md](code-review/deployed-contracts/GemPit-0x69076e44a9C70a67D5b79d95795Aba299083c275.md)
  * [ ] contract DSMath
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSNote
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
  * [ ] contract GemPit
* [ ] [code-review/deployed-contracts/DSChiefAdm-0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152.md](code-review/deployed-contracts/DSChiefAdm-0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSRoles is DSAuth, DSAuthority
  * [ ] contract DSMath
  * [ ] contract DSNote
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
  * [ ] contract DSChiefApprovals is DSThing
  * [ ] contract DSChief is DSRoles, DSChiefApprovals
  * [ ] contract DSChiefFab
* [ ] [code-review/deployed-contracts/DSTokenSai-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.md](code-review/deployed-contracts/DSTokenSai-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.md)
  * [ ] contract DSMath
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSNote
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
* [ ] [code-review/deployed-contracts/DSTokenSin-0x79F6D0f646706E1261aCF0b93DCB864f357d4680.md](code-review/deployed-contracts/DSTokenSin-0x79F6D0f646706E1261aCF0b93DCB864f357d4680.md)
  * [ ] contract DSMath
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSNote
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
* [ ] [code-review/deployed-contracts/DSTokenSkr-0xf53AD2c6851052A81B42133467480961B2321C09.md](code-review/deployed-contracts/DSTokenSkr-0xf53AD2c6851052A81B42133467480961B2321C09.md)
  * [ ] contract DSMath
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSNote
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
* [ ] [code-review/deployed-contracts/DSGuardDad-0x315cBb88168396D12e1a255f9Cb935408fe80710.md](code-review/deployed-contracts/DSGuardDad-0x315cBb88168396D12e1a255f9Cb935408fe80710.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSGuardEvents
  * [ ] contract DSGuard is DSAuth, DSAuthority, DSGuardEvents
  * [ ] contract DSGuardFactory
* [ ] [code-review/deployed-contracts/SaiMom-0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C.md](code-review/deployed-contracts/SaiMom-0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSNote
  * [ ] contract DSMath
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
  * [ ] contract DSValue is DSThing
  * [ ] contract SaiVox is DSThing
  * [ ] contract SaiTubEvents
  * [ ] contract SaiTub is DSThing, SaiTubEvents
  * [ ] contract SaiTap is DSThing
  * [ ] contract SaiTop is DSThing
  * [ ] contract SaiMom is DSThing
* [ ] [code-review/deployed-contracts/SaiVox-0x9B0F70Df76165442ca6092939132bBAEA77f2d7A.md](code-review/deployed-contracts/SaiVox-0x9B0F70Df76165442ca6092939132bBAEA77f2d7A.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSNote
  * [ ] contract DSMath
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
  * [ ] contract SaiVox is DSThing
* [ ] [code-review/deployed-contracts/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.md](code-review/deployed-contracts/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSNote
  * [ ] contract DSMath
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
  * [ ] contract DSValue is DSThing
  * [ ] contract SaiVox is DSThing
  * [ ] contract SaiTubEvents
  * [ ] contract SaiTub is DSThing, SaiTubEvents
* [ ] [code-review/deployed-contracts/SaiTap-0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF.md](code-review/deployed-contracts/SaiTap-0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSNote
  * [ ] contract DSMath
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
  * [ ] contract DSValue is DSThing
  * [ ] contract SaiVox is DSThing
  * [ ] contract SaiTubEvents
  * [ ] contract SaiTub is DSThing, SaiTubEvents
  * [ ] contract SaiTap is DSThing
* [ ] [code-review/deployed-contracts/SaiTop-0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3.md](code-review/deployed-contracts/SaiTop-0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSNote
  * [ ] contract DSMath
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
  * [ ] contract DSValue is DSThing
  * [ ] contract SaiVox is DSThing
  * [ ] contract SaiTubEvents
  * [ ] contract SaiTub is DSThing, SaiTubEvents
  * [ ] contract SaiTap is DSThing
  * [ ] contract SaiTop is DSThing
* [ ] [code-review/deployed-contracts/Redeemer-0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C.md](code-review/deployed-contracts/Redeemer-0x642AE78FAfBB8032Da552D619aD43F1D81E4DD7C.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSMath
  * [ ] contract DSNote
  * [ ] contract DSThing is DSAuth, DSNote, DSMath
  * [ ] contract DSStop is DSNote, DSAuth
  * [ ] contract ERC20
  * [ ] contract DSTokenBase is ERC20, DSMath
  * [ ] contract DSToken is DSTokenBase(0), DSStop
  * [ ] contract Redeemer is DSStop
* [ ] [code-review/deployed-contracts/MatchingMarket-0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425.md](code-review/deployed-contracts/MatchingMarket-0x14FBCA95be7e99C15Cc2996c6C9d841e54B79425.md)
  * [ ] contract DSAuthority
  * [ ] contract DSAuthEvents
  * [ ] contract DSAuth is DSAuthEvents
  * [ ] contract DSMath
  * [ ] contract ERC20Events
  * [ ] contract ERC20 is ERC20Events
  * [ ] contract EventfulMarket
  * [ ] contract SimpleMarket is EventfulMarket, DSMath
  * [ ] contract ExpiringMarket is DSAuth, SimpleMarket
  * [ ] contract DSNote
  * [ ] contract MatchingEvents
  * [ ] contract MatchingMarket is MatchingEvents, ExpiringMarket, DSNote

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

* [https://dai.makerdao.com/](https://dai.makerdao.com/)
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
* [An Overview Of Stablecoins](https://multicoin.capital/2018/01/17/an-overview-of-stablecoins/)
* [#006 - MakerDAO & the Dai stable coin - Founder Rune Christensen](https://blockzero.simplecast.fm/f455ccb1)

<br />

<hr />

## Previous Audit

* [Single-Collateral Dai source code and security reviews](https://medium.com/@MakerDAO/single-collateral-dai-source-code-and-security-reviews-523e1a01a3c8)
  * [SAI Coin Code Review](previous-audit/SAICoinCode_Review_v1_3.pdf)
  * [Sai Security Assessment](previous-audit/Sai_Final_Report.pdf)
