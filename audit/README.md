# MakerDAO Sai Contract Audit

## Summary

[MakerDAO](https://makerdao.com/)'s Sai stable currency is currently in use on the Ethereum mainnet, with a USD 50 million cap on the amount of Sai currency on issue. This cap was raised to USD 100 million on Jun 30 2018 in transaction [0x9da57d15](https://etherscan.io/tx/0x9da57d15a59eba4bc130e5bf4044990636cf65fed9494a30a2765b522a20d960).

Bok Consulting Pty Ltd was commissioned to perform an audit on MakerDAO's Sai Ethereum smart contracts.

An audit of MakerDAO's deployed contract has been conducted and no potential vulnerabilities have been identified in the smart contracts.

<br />

<hr />

## Table Of Contents

* [Scope](#scope)
* [Methodology](#methodology)
* [Results](#results)
* [Tokens](#tokens)
  * [Gem](#gem)
  * [Gov](#gov)
  * [Sai, Sin And Skr](#sai-sin-and-skr)
* [Pip And Pep Price Feeds](#pip-and-pep-price-feeds)
* [Vox Target Price Feed](#vox-target-price-feed)
* [Tub Collateral Debt Position](#tub-collateral-debt-position)
* [Tap Liquidator](#tap-liquidator)
* [Top Global Settlement Manager](#top-global-settlement-manager)
* [Contract Permissions](#contract-permissions)
  * [Dad](#dad)
  * [Mom](#mom)
  * [Adm](#adm)
* [Other](#other)
  * [Pit Token Burner](#pit-token-burner)
* [Code Review Of Components](#code-review-of-components)

<br />

<hr />

## Scope

This audit is into the technical aspects of the MakerDAO's Sai stable currency contracts. The primary aim of this audit is to ensure that funds represented by these contracts are not easily attacked or stolen by third parties. The secondary aim of this audit is to ensure the coded algorithms work as expected. This audit does not guarantee that that the code is bug-free, but intends to highlight any areas of weaknesses.

This audit has been conducted on MakerDAO's contract source code for the following deployed smart contracts:

* Tokens
  * [gem:0xc02aaa39] - The `WETH` `Wrapped Ether` [token](https://etherscan.io/token/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2) contract
  * [gov:0x9f8f72aa] - The `MKR` `Maker` [token](https://etherscan.io/token/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2) contract
  * [sai:0x89d24a6b] - The `DAI` `Dai Stablecoin v1.0` [token](https://etherscan.io/token/0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359) contract
  * [sin:0x79f6d0f6] - The `SIN` `SIN` [token](https://etherscan.io/token/0x79f6d0f646706e1261acf0b93dcb864f357d4680) contract
  * [skr:0xf53ad2c6] - The `PETH` `Pooled Ether` [token](https://etherscan.io/token/0xf53ad2c6851052a81b42133467480961b2321c09) contract
* Price Feeds
  * [pip:0x729d19f6] - ETH/USD price feed
  * [pep:0x99041f80] - MKR/USD price feed
* Target Price Feed
  * [vox:0x9b0f70df] - Target price feed
* Collateral Debt Position
  * [tub:0x448a5065] - Collateral Debt Position
* Liquidator
  * [tap:0xbda10930] - Liquidator
* Global Settlement Manager
  * [top:0x9b0ccf7c] - Global Settlement Manager
* Permissions, configuration and actions
  * [dad:0x315cbb88]
  * [mom:0xf2c5369c]
  * [adm:0x8e2a84d6]
* Others
  * [pit:0x69076e44] - SKR burn address

Note that the algorithms governing the economic functioning of the MakerDAO system are not covered by this audit.

<br />

<hr />

## Methodology

The following steps has been conducted for this audit:

* The source code for the MakerDAO smart contracts were extracted from EtherScan from the deployed addresses on the Ethereum mainnet
* Testing scripts were developed to deploy to a dev environment to observe the interactions between the various MakerDAO smart contracts
* The deployed smart contracts were matched to the source code from the source GitHub repositories to separate the deployed smart contracts into their component smart contracts
* The state and historical events for the deployed MakerDAO smart contracts were extracted from the mainnet Ethereum blockchain to confirm the deployment parameters, state variables and event logs
* A code review of the component smart contracts was conducted
* Some manual calculations have been calculated using the [math-d5acd9c](https://github.com/dapphub/ds-math/blob/d5acd9c230361b29817ab3108743511747916abd/src/math.sol) with the *internal* functions converted to *public* functions and deployed to [0xc05e27d67021f9fcF2113b51B2F5F9eb88A9FC48](https://ropsten.etherscan.io/address/0xc05e27d67021f9fcF2113b51B2F5F9eb88A9FC48#readContract) on Ropsten

<br />

<hr />

## Results

The MakerDAO smart contracts are well written with a logical separation of functionality into component smart contracts.

One difficulty in understanding the smart contracts has been MakerDAO's choice of naming contracts and objects with three letter words like *sai*, *sin*, *tub*, *tap* and *top*, and the naming of actions with four letter words like *cage*, *bite*, *mold* and *drip*.

Another difficulty in tracing through the correctness in the functioning of the smart contracts has been the use of calculations with 18 (*wad*) and 27 (*ray*) decimal place precision. This difficulty is compounded by the use of three letter words for the object names mentioned above.

Once the conventions above are understood, the workings of the MakerDAO smart contracts become quite clear.

There are small number of issues of low importance raised by this audit. These are listed in the sections below documenting each deployed smart contract. There is also no ability to transfer out any other ERC20 tokens accidentally sent to the MakerDAO contracts, but again this is of low importance.

No potential vulnerabilities have been identified in the smart contracts.

The remaining sections of this report goes into more details of each component of the MakerDAO Sai smart contracts.

<br />

<hr />

## Tokens

Token            | Symbol | Name                | Decimals | Owner                              | Authority
---------------- | ------ | ------------------- | -------- | ---------------------------------- | ---------------------
[gem:0xc02aaa39] | WETH   | Wrapped Ether       | 18       | n/a                                | n/a
[gov:0x9f8f72aa] | MKR    | Maker               | 18       | [community4of6multisig:0x7bb0b085] | [0x00000000]
[sai:0x89d24a6b] | DAI    | Dai Stablecoin v1.0 | 18       | [0x00000000]                       | [dad:0x315cbb88]
[sin:0x79f6d0f6] | SIN    | SIN                 | 18       | [0x00000000]                       | [dad:0x315cbb88]
[skr:0xf53ad2c6] | PETH   | Pooled Ether        | 18       | [0x00000000]                       | [dad:0x315cbb88]

<br />

### Gem

The WETH (Gem) token contract wraps ethers (ETH) in an ERC20 token contract.

* Contract address: [gem:0xc02aaa39]
* Source code: [weth9-b353893](code-review/makerdao/weth9-b353893.md)
* Deployed source code: [WETH9Gem.sol](deployed-contracts/WETH9Gem-0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.sol)

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in this smart contract.

#### Issues

* **LOW IMPORTANCE** There is a possibility for the total supply to be larger than the sum of all token balance when the `selfdestruct` opcode is used to transfer ETH to this token contract, and this amount cannot be recovered from this token contract

<br />

### Gov

This is the MKR (Maker) governance token contract.

* Contract address: [gov:0x9f8f72aa]
* Source code: [token-e637e3f](code-review/dappsys/token-e637e3f.md) and [dependencies](#code-review-of-components)
* Deployed source code: [DSTokenGov.sol](deployed-contracts/DSTokenGov-0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2.sol)
* Data: [gov.txt](scripts/gov.txt)

#### Permissions

This token contract has `owner` set to [community4of6multisig:0x7bb0b085] and `authority` set to [0x00000000]. The 4 of 6 community multisig is able to `mint(...)` new MKR tokens and `burn(...)` any accounts tokens.

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in this smart contract.

#### Note

* The token contract owner [community4of6multisig:0x7bb0b085] has the ability to `mint(...)` new MKR tokens and `burn(...)` any account's MKR tokens

#### Issues

* **LOW IMPORTANCE** The `name()` and `symbol()` functions return the `bytes32` data type instead of `string` as recommended in the [ERC20 token standard]
* **LOW IMPORTANCE** The `decimals()` function returns the `uint256` data type instead of `uint8` as recommended in the [ERC20 token standard]
* **LOW IMPORTANCE** The `mint(...)` function should emit the `Transfer(address(0), guy, wad)` event as the blockchain token explorers will pick this event up
* **LOW IMPORTANCE** The `burn(...)` function should emit the `Transfer(guy, address(0), wad)` event as the blockchain token explorers will pick this event up

<br />

### Sai, Sin And Skr

These are the *sai* stable coin, *sin* anticoin and the *skr* claim on the collateral token contracts.

* Contract addresses: [sai:0x89d24a6b], [sin:0x79f6d0f6] and [skr:0xf53ad2c6]
* Source code: [token-e637e3f](code-review/dappsys/token-e637e3f.md) and [dependencies](#code-review-of-components)
* Deployed source code: [DSTokenSai.sol](deployed-contracts/DSTokenSai-0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359.sol), [DSTokenSin.sol](deployed-contracts/DSTokenSin-0x79F6D0f646706E1261aCF0b93DCB864f357d4680.sol) and [DSTokenSkr.sol](deployed-contracts/DSTokenSkr-0xf53AD2c6851052A81B42133467480961B2321C09.sol)
* Data: [saiSinSkr.txt](scripts/saiSinSkr.txt)

#### Permissions

These token contracts have `owner` set to [0x00000000] and `authority` set to [dad:0x315cbb88] and this defines the permissions for which other smart contract are able to `mint(...)` and `burn(...)` these tokens. The following table is a whitelist of which smart contracts are able to `mint(...)` and `burn(...)` these tokens:

Permit From      | Permit To        | Function
---------------- | ---------------- | ---------------------
[tap:0xbda10930] | [sai:0x89d24a6b] | mint(address,uint256)
[tap:0xbda10930] | [sai:0x89d24a6b] | burn(address,uint256)
[tap:0xbda10930] | [sai:0x89d24a6b] | burn(uint256)
[tap:0xbda10930] | [sin:0x79f6d0f6] | burn(uint256)
[tap:0xbda10930] | [skr:0xf53ad2c6] | mint(uint256)
[tap:0xbda10930] | [skr:0xf53ad2c6] | burn(uint256)
[tub:0x448a5065] | [sai:0x89d24a6b] | mint(address,uint256)
[tub:0x448a5065] | [sai:0x89d24a6b] | burn(address,uint256)
[tub:0x448a5065] | [sin:0x79f6d0f6] | mint(address,uint256)
[tap:0xbda10930] | [skr:0xf53ad2c6] | burn(address,uint256)
[tub:0x448a5065] | [skr:0xf53ad2c6] | mint(address,uint256)
[tub:0x448a5065] | [skr:0xf53ad2c6] | burn(address,uint256)

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in these smart contract.

#### Issues

* **LOW IMPORTANCE** The `name()` and `symbol()` functions return the `bytes32` data type instead of `string` as recommended in the [ERC20 token standard]
* **LOW IMPORTANCE** The `decimals()` function returns the `uint256` data type instead of `uint8` as recommended in the [ERC20 token standard]

<br />

<hr />

## Pip And Pep Price Feeds

These are the ETH/USD *pip* and the MKR/USD *pep* *Medianizer* smart contracts to calculate the median prices from multiple [price feed sources](Feeds.md). [0x137fdd00](https://etherscan.io/address/0x137fdd00e9a866631d8daf1a2116fb8df1ed07a7#code) is one of the ETH/USD *pip* price feed contributors, and [0x8a4774fe](https://etherscan.io/address/0x8a4774fe82c63484afef97ca8d89a6ea5e21f973#code) is one of the MKR/USD *pep* price feed contributors.

Individual price feed providers write to their instances of [PriceFeed](https://github.com/makerdao/price-feed/blob/master/src/price-feed.sol) contracts, which then call the *Medianizer* `poke()` function. This `poke()` function then collects all contributors price feed *DSValue* points to calculate the median price feed value.

* Contract address: ETH/USD [pip:0x729d19f6]; MKR/USD [pep:0x99041f80]
* Source code: ETH/USD *pip* [medianizer-31cc0a8](code-review/medianizer/medianizer-31cc0a8.md) and [dependencies](#code-review-of-components); MKR/USD *pep* [medianizer-6cb859c](code-review/medianizer/medianizer-6cb859c.md) and [dependencies](#code-review-of-components)
* Deployed source code: ETH/USD *pip* [MedianizerPip.sol](deployed-contracts/MedianizerPip-0x729D19f657BD0614b4985Cf1D82531c67569197B.sol); MKR/USD *pep* [MedianizerPep.sol](deployed-contracts/MedianizerPep-0x99041F808D598B782D5a3e498681C2452A31da08.sol)
* Data: ETH/USD *pip* [pip.txt](scripts/pip.txt); MKR/USD *pep* [pep.txt](scripts/pep.txt)

#### Permissions

Both the *pip* and *pep* contracts have `owner` set to [0x00000000] and `authority` set to [adm:0x8e2a84d6]. The *adm* contract allows multiple parties to vote on a smart contract that will then be executed, and permissioned through the *adm* contract to execute *pip* and *pep* functions.

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in these smart contract.

#### Issues

No potential issues were identified in these contracts.

<br />

<hr />

## Vox Target Price Feed

The *vox* target price feed is the reference rate that the *sai* stable coin targets.

* Contract address: [vox:0x9b0f70df]
* Source code: ETH/USD *pip* [vox-b353893.sol](code-review/makerdao/vox-b353893.md) and [dependencies](#code-review-of-components)
* Deployed source code: [SaiVox.sol](deployed-contracts/SaiVox-0x9B0F70Df76165442ca6092939132bBAEA77f2d7A.sol)
* Data: [vox.txt](scripts/vox.txt)

#### Permissions

This contracts has `owner` set to [0x00000000] and `authority` set to [dad:0x315cbb88] and this defines the permissions for which other smart contracts (*mom*) are able to tune the *vox* parameters using the `mold(...)` and `tune(...)` functions.

Permit From      | Permit To        | Function
---------------- | ---------------- | ---------------------
[mom:0xf2c5369c] | [vox:0x9b0f70df] | mold(bytes32,uint256)
[mom:0xf2c5369c] | [vox:0x9b0f70df] | tune(uint256)

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in these smart contract.

#### Issues

No potential issues were identified in this contract.

<br />

<hr />

## Tub Collateral Debt Position

The *tub* contract manages the list of *cup*s representing the individual collateral debt position.

* Contract address: [tub:0x448a5065]
* Source code: [tub-b353893](code-review/makerdao/tub-b353893.md) and [dependencies](#code-review-of-components)
* Deployed source code: [SaiTub.sol](deployed-contracts/SaiTub-0x448a5065aeBB8E423F0896E6c5D525C040f59af3.sol)
* Data: [tub.txt](scripts/tub.txt)

#### Permissions

This contract has `owner` set to [0x00000000] and `authority` set to [dad:0x315cbb88] and this defines the permissions for which other smart contract are able to execute the functions. The following table is a whitelist of which smart contracts are able to execute the functions:

Permit From      | Permit To        | Function              | Notes
---------------- | ---------------- | --------------------- | ----------------------------
[mom:0xf2c5369c] | [tub:0x448a5065] | mold(bytes32,uint256) | *mom* can set parameters `cap`, `mat`, `tax`, `fee`, `axe` and `gap`
[mom:0xf2c5369c] | [tub:0x448a5065] | setPip(address)       | *mom* can set new ETH/USD *pip* price feed
[mom:0xf2c5369c] | [tub:0x448a5065] | setPep(address)       | *mom* can set new MKR/USD *pep* price feed
[mom:0xf2c5369c] | [tub:0x448a5065] | setVox(address)       | *mom* can set new *vox*
[top:0x9b0ccf7c] | [tub:0x448a5065] | cage(uint256,uint256) |
[top:0x9b0ccf7c] | [tub:0x448a5065] | flow()                |
[top:0x9b0ccf7c] | [tap:0xbda10930] | cage(uint256)         |
[tub:0x448a5065] | [sai:0x89d24a6b] | mint(address,uint256) |
[tub:0x448a5065] | [sai:0x89d24a6b] | burn(address,uint256) |
[tub:0x448a5065] | [sin:0x79f6d0f6] | mint(address,uint256) |
[tub:0x448a5065] | [skr:0xf53ad2c6] | mint(address,uint256) |
[tub:0x448a5065] | [skr:0xf53ad2c6] | burn(address,uint256) |

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in this smart contract.

#### Issues

* **LOW IMPORTANCE** - Note that `tub.tag()` returns value is a ray (10^27) and NOT a a wad (10^18) number as implied in the return value `function tag() public view returns (uint wad) {`

<br />

<hr />

## Tap Liquidator

The *tap* contract is the Liquidator.

* Contract address: [tap:0xbda10930]
* Source code: [tap-b353893](code-review/makerdao/tap-b353893.md) and [dependencies](#code-review-of-components)
* Deployed source code: [SaiTap.sol](deployed-contracts/SaiTap-0xBda109309f9FafA6Dd6A9CB9f1Df4085B27Ee8eF.sol)
* Data: [tap.txt](scripts/tap.txt)

#### Permissions

This contract has `owner` set to [0x00000000] and `authority` set to [dad:0x315cbb88] and this defines the permissions for which other smart contract are able to execute the functions. The following table is the *dad* whitelist of which smart contracts are able to execute the functions:

Permit From      | Permit To        | Function              | Notes
---------------- | ---------------- | --------------------- | ----------------------------
[top:0x9b0ccf7c] | [tap:0xbda10930] | cage(uint256)
[tap:0xbda10930] | [sai:0x89d24a6b] | mint(address,uint256)
[tap:0xbda10930] | [sai:0x89d24a6b] | burn(address,uint256)
[tap:0xbda10930] | [sai:0x89d24a6b] | burn(uint256)
[tap:0xbda10930] | [sin:0x79f6d0f6] | burn(uint256)
[tap:0xbda10930] | [skr:0xf53ad2c6] | mint(uint256)
[tap:0xbda10930] | [skr:0xf53ad2c6] | burn(uint256)
[tap:0xbda10930] | [skr:0xf53ad2c6] | burn(address,uint256)
[mom:0xf2c5369c] | [tap:0xbda10930] | mold(bytes32,uint256)

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in this smart contract.

#### Issues

No potential issues were identified in this contract.

<br />

<hr />

## Top Global Settlement Manager

The *top* contract is the Global Settlement Manager.

* Contract address: [top:0x9b0ccf7c]
* Source code: [top-b353893](code-review/makerdao/top-b353893.md) and [dependencies](#code-review-of-components)
* Deployed source code: [SaiTop.sol](deployed-contracts/SaiTop-0x9b0ccf7C8994E19F39b2B4CF708e0A7DF65fA8a3.sol)
* Data: [top.txt](scripts/top.txt)

#### Permissions

The *top* contract has `owner` set to [0x00000000] and `authority` set to [adm:0x8e2a84d6]. The *adm* contract allows multiple parties to vote on a smart contract that will then be executed, and permissioned through the *adm* contract to execute *top* functions.

Following is the whitelist of permissions from the *dad* contract that allows *top* contract to execute functions in the *tub* and *tap* contracts:

Permit From      | Permit To        | Function              | Notes
---------------- | ---------------- | --------------------- | ----------------------------
[top:0x9b0ccf7c] | [tub:0x448a5065] | cage(uint256,uint256)
[top:0x9b0ccf7c] | [tub:0x448a5065] | flow()
[top:0x9b0ccf7c] | [tap:0xbda10930] | cage(uint256)

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in this smart contract.

#### Issues

No potential issues were identified in this contract.

<br />

<hr />

## Contract Permissions

### Dad

The *dad* contract is set as the authority for many of the MakerDao smart contracts.

* Contract address: [dad:0x315cbb88]
* Source code: [guard-f8b7f58](code-review/dappsys/guard-f8b7f58.md) and [dependencies](#code-review-of-components)
* Deployed source code: [DSGuardDad.sol](deployed-contracts/DSGuardDad-0x315cBb88168396D12e1a255f9Cb935408fe80710.sol)
* Data: [dad.txt](scripts/dad.txt)

The following table shows the whitelist rules created during the deployment of the *dad* contract:

Permit From      | Permit To        | Function
---------------- | ---------------- | ---------------------
[top:0x9b0ccf7c] | [tub:0x448a5065] | cage(uint256,uint256)
[top:0x9b0ccf7c] | [tub:0x448a5065] | flow()
[top:0x9b0ccf7c] | [tap:0xbda10930] | cage(uint256)
[tub:0x448a5065] | [skr:0xf53ad2c6] | mint(address,uint256)
[tub:0x448a5065] | [skr:0xf53ad2c6] | burn(address,uint256)
[tub:0x448a5065] | [sai:0x89d24a6b] | mint(address,uint256)
[tub:0x448a5065] | [sai:0x89d24a6b] | burn(address,uint256)
[tub:0x448a5065] | [sin:0x79f6d0f6] | mint(address,uint256)
[tap:0xbda10930] | [sai:0x89d24a6b] | mint(address,uint256)
[tap:0xbda10930] | [sai:0x89d24a6b] | burn(address,uint256)
[tap:0xbda10930] | [sai:0x89d24a6b] | burn(uint256)
[tap:0xbda10930] | [sin:0x79f6d0f6] | burn(uint256)
[tap:0xbda10930] | [skr:0xf53ad2c6] | mint(uint256)
[tap:0xbda10930] | [skr:0xf53ad2c6] | burn(uint256)
[tap:0xbda10930] | [skr:0xf53ad2c6] | burn(address,uint256)
[mom:0xf2c5369c] | [vox:0x9b0f70df] | mold(bytes32,uint256)
[mom:0xf2c5369c] | [vox:0x9b0f70df] | tune(uint256)
[mom:0xf2c5369c] | [tub:0x448a5065] | mold(bytes32,uint256)
[mom:0xf2c5369c] | [tap:0xbda10930] | mold(bytes32,uint256)
[mom:0xf2c5369c] | [tub:0x448a5065] | setPip(address)
[mom:0xf2c5369c] | [tub:0x448a5065] | setPep(address)
[mom:0xf2c5369c] | [tub:0x448a5065] | setVox(address)

Any MakerDAO contract that has `owner` set to [0x00000000] and `authority` set to [dad:0x315cbb88] will use the the whitelist table above to check if the inter-contract calls are permissioned.

#### Permissions

The *dad* contract has `owner` set to [0x00000000] and `authority` set to [0x00000000]. No further changes to the *dad* contract are possible.

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in this smart contract.

#### Issues

No potential issues were identified in this contract.

<br />

### Mom

The *mom* contract is set up with permissions to execute functions to modify the MakerDAO system parameters. The *adm* contract allows multiple parties to vote on actions (executed via smart contracts) that will execute the appropriate functions in the *mom* contract.

* Contract address: [mom:0xf2c5369c]
* Source code: [mom-b353893](code-review/makerdao/mom-b353893.md) and [dependencies](#code-review-of-components)
* Deployed source code: [SaiMom.sol](deployed-contracts/SaiMom-0xF2C5369cFFb8Ea6284452b0326e326DbFdCb867C.sol)
* Data: [mom.txt](scripts/mom.txt)

#### Permissions

The *mom* contract has `owner` set to [0x00000000] and `authority` set to [adm:0x8e2a84d6]. The *adm* contract allows multiple parties to vote on a smart contract that will then be executed, and permissioned through the *adm* contract to execute *mom* functions.

Following is the whitelist of permissions from the *dad* contract that allows *mom* contract to execute functions in the *vox*, *tub* and *tap* contracts:

Permit From      | Permit To        | Function
---------------- | ---------------- | ---------------------
[mom:0xf2c5369c] | [vox:0x9b0f70df] | mold(bytes32,uint256)
[mom:0xf2c5369c] | [vox:0x9b0f70df] | tune(uint256)
[mom:0xf2c5369c] | [tub:0x448a5065] | mold(bytes32,uint256)
[mom:0xf2c5369c] | [tap:0xbda10930] | mold(bytes32,uint256)
[mom:0xf2c5369c] | [tub:0x448a5065] | setPip(address)
[mom:0xf2c5369c] | [tub:0x448a5065] | setPep(address)
[mom:0xf2c5369c] | [tub:0x448a5065] | setVox(address)

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in this smart contract.

#### Issues

No potential issues were identified in this contract.

<br />

### Adm

The *adm* contract allows multiple parties to vote on actions that will affect the MakerDAO system.

* Contract address: [adm:0x8e2a84d6]
* Source code: [chief-a06b5e4](code-review/dappsys/chief-a06b5e4.md) and [dependencies](#code-review-of-components)
* Deployed source code: [DSChiefAdm.sol](deployed-contracts/DSChiefAdm-0x8E2a84D6adE1E7ffFEe039A35EF5F19F13057152.sol)
* Data: [adm.txt](scripts/adm.txt)

#### Permissions

The *adm* contract has `owner` set to [0x00000000] and `authority` set to [adm:0x8e2a84d6] (itself). The *adm* contract is set up for multiple parties to vote on actions, implemented as a smart contract, that will be execute to modify the parameters of the MakerDAO system. The voted-in contract then has the ability to execute functions on the *mom*, *pip*, *pep* and *top* contracts.

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in this smart contract.

#### Issues

No potential issues were identified in this contract.

<br />

<hr />

## Other

### Pit Token Burner

*skr* tokens can be burnt by sending them to the *pit* contract.

* Contract addresses: [pit:0x69076e44]
* Source code: [pit-b353893](code-review/dappsys/pit-b353893.md) and [dependencies](#code-review-of-components)
* Deployed source code: [GemPit.sol](deployed-contracts/GemPit-0x69076e44a9C70a67D5b79d95795Aba299083c275.sol)
* Data: [pit.txt](scripts/pit.txt)

#### Permissions

This contracts has no `owner` or `authority`. There is a `burn(...)` function in the *pit* contract but this function is not permissioned to execute any token's `burn(...)` function, so this function cannot be execute. As the tokens will be permanently stuck in this *pit* contract, they are effectively burnt.

#### Potential Vulnerabilities

No potential vulnerabilities have been identified in this smart contract.

#### Issues

No potential issues were identified in this contract.

<br />

<hr />

## Code Review Of Components

Source code for the deployed contracts have been matched against the component contracts from the MakerDAO and DappSys source code repository.
[Scripts](checkComponents/checkAll.sh) and [results](checkComponents/results.txt) were used to confirm the match of the deployed
contracts against the component contracts.

* &#10003; Gem ([weth9-b353893](code-review/makerdao/weth9-b353893.md)) is a standalone contract.
* SSS represents the [Sai], [Sin] and [Skr] contracts that are all identical in the source code, but with different deployment parameters
* Pip deployed on 10 May 2017. The other components were deployed in Dec 2017

Component                                                          | [Gov] | [Pip] | [Pep] | [Pit] | [Adm] | SSS | [Dad] | [Mom] | [Vox] | [Tub] | [Tap] | [Top] | [Fab]
------------------------------------------------------------------ |:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:
&#10003; [auth-52c6a32](code-review/dappsys/auth-52c6a32.md)                |  1  |     |  1  |  2  |  1  |  2  |  1  |  1  |  1  |  1  |  1  |  1  |  1
&#10003; [auth-ce285fb](code-review/dappsys/auth-ce285fb.md)                |     |  1  |     |     |     |     |     |     |     |     |     |     |
&#10003; [base-e637e3f](code-review/dappsys/base-e637e3f.md)                |  7  |     |     |  6  |  8  |  6  |     |  7  |     |  7  |  7  |  7  |  9
&#10003; [chief-a06b5e4](code-review/dappsys/chief-a06b5e4.md)              |     |     |     |     | 10  |     |     |     |     |     |     |     |
&#10003; [erc20-56f16b3](code-review/dappsys/erc20-56f16b3.md)              |  6  |     |     |     |     |     |     |     |     |     |     |     |
&#10003; [erc20-c4f5635](code-review/dappsys/erc20-c4f5635.md)              |     |     |     |  5  |  7  |  5  |     |  6  |     |  6  |  6  |  6  |  8
&#10003; [guard-f8b7f58](code-review/dappsys/guard-f8b7f58.md)              |     |     |     |     |     |     |  2  |     |     |     |     |     |  2
&#10003; [math-a01112f](code-review/dappsys/math-a01112f.md)                |     |  3  |     |     |     |     |     |     |     |     |     |     |
&#10003; [math-d5acd9c](code-review/dappsys/math-d5acd9c.md)                |  2  |     |  2  |  1  |  3  |  1  |     |  3  |  3  |  3  |  3  |  3  |  5
&#10003; [note-7170a08](code-review/dappsys/note-7170a08.md)                |  3  |  2  |  3  |  3  |  4  |  3  |     |  2  |  2  |  2  |  2  |  2  |  4
&#10003; [roles-188b3dd](code-review/dappsys/roles-188b3dd.md)              |     |     |     |     |  2  |     |     |     |     |     |     |     |  3
&#10003; [stop-842e350](code-review/dappsys/stop-842e350.md)                |  5  |     |     |  4  |  6  |  4  |     |  5  |     |  5  |  5  |  5  |  7
&#10003; [thing-35b2538](code-review/dappsys/thing-35b2538.md)              |  4  |     |  4  |     |     |     |     |     |     |     |     |     |
&#10003; [thing-4c86a53](code-review/dappsys/thing-4c86a53.md)              |     |     |     |     |  5  |     |     |  4  |  4  |  4  |  4  |  4  |  6
&#10003; [thing-ea63fd3](code-review/dappsys/thing-ea63fd3.md)              |     |  4  |     |     |     |     |     |     |     |     |     |     |
&#10003; [token-e637e3f](code-review/dappsys/token-e637e3f.md)              |  8  |     |     |  7  |  9  |  7  |     |  8  |     |  8  |  8  |  8  | 10
&#10003; [value-2027f97](code-review/dappsys/value-2027f97.md)              |     |  5  |     |     |     |     |     |     |     |     |     |     |
&#10003; [value-faae4cb](code-review/dappsys/value-faae4cb.md)              |     |     |  5  |     |     |     |     |  9  |     |  9  |  9  |  9  | 11
&#10003; [medianizer-31cc0a8](code-review/medianizer/medianizer-31cc0a8.md) |     |  6  |     |     |     |     |     |     |     |     |     |     |
&#10003; [medianizer-6cb859c](code-review/medianizer/medianizer-6cb859c.md) |     |     |  6  |     |     |     |     |     |     |     |     |     |
&#10003; [pit-b353893](code-review/makerdao/pit-b353893.md)                 |     |     |     |  8  |     |     |     |     |     |     |     |     |
&#10003; [vox-b353893](code-review/makerdao/vox-b353893.md)                 |     |     |     |     |     |     |     | 10  |  5  | 10  | 10  | 10  | 12
&#10003; [tub-b353893](code-review/makerdao/tub-b353893.md)                 |     |     |     |     |     |     |     | 11  |     | 11  | 11  | 11  | 13
&#10003; [tap-b353893](code-review/makerdao/tap-b353893.md)                 |     |     |     |     |     |     |     | 12  |     |     | 12  | 12  | 14
&#10003; [top-b353893](code-review/makerdao/top-b353893.md)                 |     |     |     |     |     |     |     | 13  |     |     |     | 13  | 15
&#10003; [mom-b353893](code-review/makerdao/mom-b353893.md)                 |     |     |     |     |     |     |     | 14  |     |     |     |     | 16
&#10003; [fab-b353893](code-review/makerdao/fab-b353893.md)                 |     |     |     |     |     |     |     |     |     |     |     |     | 17

<br />

<br />

(c) BokkyPooBah / Bok Consulting Pty Ltd for MakerDAO - Jun 21 2018. The MIT Licence.

[Gem]: https://etherscan.io/address/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2#code
[Gov]: https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2#code
[Pip]: https://etherscan.io/address/0x729D19f657BD0614b4985Cf1D82531c67569197B#code
[Pep]: https://etherscan.io/address/0x99041F808D598B782D5a3e498681C2452A31da08#code
[Pit]: https://etherscan.io/address/0x69076e44a9c70a67d5b79d95795aba299083c275#code
[Adm]: https://etherscan.io/address/0x8e2a84d6ade1e7fffee039a35ef5f19f13057152#code
[Sai]: https://etherscan.io/address/0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359#code
[Sin]: https://etherscan.io/address/0x79f6d0f646706e1261acf0b93dcb864f357d4680#code
[Skr]: https://etherscan.io/address/0xf53ad2c6851052a81b42133467480961b2321c09#code
[Dad]: https://etherscan.io/address/0x315cbb88168396d12e1a255f9cb935408fe80710#code
[Mom]: https://etherscan.io/address/0xf2c5369cffb8ea6284452b0326e326dbfdcb867c#code
[Vox]: https://etherscan.io/address/0x9b0f70df76165442ca6092939132bbaea77f2d7a#code
[Tub]: https://etherscan.io/address/0x448a5065aebb8e423f0896e6c5d525c040f59af3#code
[Tap]: https://etherscan.io/address/0xbda109309f9fafa6dd6a9cb9f1df4085b27ee8ef#code
[Top]: https://etherscan.io/address/0x9b0ccf7c8994e19f39b2b4cf708e0a7df65fa8a3#code
[Fab]: https://etherscan.io/address/0xF07674F6AC6632e253C291B694f9C2e2ED69eBBB#code
[gem:0xc02aaa39]: https://etherscan.io/address/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2#code
[gov:0x9f8f72aa]: https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2#code
[pip:0x729d19f6]: https://etherscan.io/address/0x729D19f657BD0614b4985Cf1D82531c67569197B#code
[pep:0x99041f80]: https://etherscan.io/address/0x99041F808D598B782D5a3e498681C2452A31da08#code
[pit:0x69076e44]: https://etherscan.io/address/0x69076e44a9c70a67d5b79d95795aba299083c275#code
[adm:0x8e2a84d6]: https://etherscan.io/address/0x8e2a84d6ade1e7fffee039a35ef5f19f13057152#code
[sai:0x89d24a6b]: https://etherscan.io/address/0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359#code
[sin:0x79f6d0f6]: https://etherscan.io/address/0x79f6d0f646706e1261acf0b93dcb864f357d4680#code
[skr:0xf53ad2c6]: https://etherscan.io/address/0xf53ad2c6851052a81b42133467480961b2321c09#code
[dad:0x315cbb88]: https://etherscan.io/address/0x315cbb88168396d12e1a255f9cb935408fe80710#code
[mom:0xf2c5369c]: https://etherscan.io/address/0xf2c5369cffb8ea6284452b0326e326dbfdcb867c#code
[vox:0x9b0f70df]: https://etherscan.io/address/0x9b0f70df76165442ca6092939132bbaea77f2d7a#code
[tub:0x448a5065]: https://etherscan.io/address/0x448a5065aebb8e423f0896e6c5d525c040f59af3#code
[tap:0xbda10930]: https://etherscan.io/address/0xbda109309f9fafa6dd6a9cb9f1df4085b27ee8ef#code
[top:0x9b0ccf7c]: https://etherscan.io/address/0x9b0ccf7c8994e19f39b2b4cf708e0a7df65fa8a3#code
[fab:0xf07674f6]: https://etherscan.io/address/0xF07674F6AC6632e253C291B694f9C2e2ED69eBBB#code
[0x00000000]: https://etherscan.io/address/0x0000000000000000000000000000000000000000#code
[community4of6multisig:0x7bb0b085]: https://etherscan.io/address/0x7bb0b08587b8a6b8945e09f1baca426558b0f06a#code
[ERC20 token standard]: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md