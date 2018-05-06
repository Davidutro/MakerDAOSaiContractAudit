# MakerDAO Sai Contract Audit

## Summary

The [MakerDAO](https://makerdao.com/) Sai stable currency is currently in use on Mainnet.

Bok Consulting Pty Ltd was commissioned to perform an audit on the Ethereum smart contracts for MakerDAO's Sai stable currency.

This audit has been conducted on MakerDAO's contract source code for the following contracts:

* Tokens
  * [gem:0xc02aaa39]
  * [gov:0x9f8f72aa]
  * [sai:0x89d24a6b]
  * [sin:0x79f6d0f6]
  * [skr:0xf53ad2c6]
* Price Feeds
  * [pip:0x729d19f6]
  * [pep:0x99041f80]
* Others
  * [pit:0x69076e44]
  * [adm:0x8e2a84d6]
  * [dad:0x315cbb88]
  * [mom:0xf2c5369c]
  * [vox:0x9b0f70df]
  * [tub:0x448a5065]
  * [tap:0xbda10930]
  * [top:0x9b0ccf7c]

TODO: Check that no potential vulnerabilities have been identified in the private presale and token contracts.

<br />

<hr />

## Table Of Contents

* [Tokens](#tokens)
  * [Gem](#gem)
  * [Gov](#gov)
  * [Sai, Sin And Skr](#sai-sin-and-skr)
* [Price Feeds](#price-feeds)
* [Other](#other)
* [Contract Permissions](#contract-permissions)
* [Code Review Of Components](#code-review-of-components)

<br />

<hr />

## Tokens

Token            | Symbol | Name                | Decimals | Owner            | Authority
---------------- | ------ | ------------------- | -------- | ---------------- | ---------------------
[gem:0xc02aaa39] | WETH   | Wrapped Ether       | 18       | n/a              | n/a
[gov:0x9f8f72aa] | MKR    | Maker               | 18       | [0x7bb0b085]     | [0x00000000]
[sai:0x89d24a6b] | DAI    | Dai Stablecoin v1.0 | 18       | [0x00000000]     | [dad:0x315cbb88]
[sin:0x79f6d0f6] | SIN    | SIN                 | 18       | [0x00000000]     | [dad:0x315cbb88]
[skr:0xf53ad2c6] | PETH   | Pooled Ether        | 18       | [0x00000000]     | [dad:0x315cbb88]


### Gem

[gem:0xc02aaa39]

<br />

### Gov

[gov:0x9f8f72aa]

<br />

### Sai, Sin And Skr

[sai:0x89d24a6b], [sin:0x79f6d0f6] and [skr:0xf53ad2c6]

<br />

<hr />

## Price Feeds

<br />

<hr />

## Other

<br />

<hr />

## Contract Permissions

### Dad

The *dad* contract is set as the authority for many of the MakerDao smart contracts.

From the script [getInfo_Dad.sh](scripts/getInfo_Dad.sh) and results [dad.txt](scripts/dad.txt), `owner` and `authority` for the *dad* contract are both set to `0x0` - no new rules can be added to the list in the following table.

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

<br />

<hr />

## Code Review Of Components

Source code for the deployed contracts have been matched against the component contracts from the MakerDAO and DappSys source code repository.
[Scripts](checkComponents/checkAll.sh) and [results](checkComponents/results.txt) were used to confirm the match of the deployed
contracts against the component contracts.

* &#10003; Gem ([weth9-b353893](code-review/makerdao/weth9-b353893.md)) is a standalone contract.
* SSS represents the Sai, Sin and Skr contracts that are all identical, except for the deployment parameters
* Pip - 10 May 2017. Rest Dec 2017

Component                                                          | Gov | Pip | Pep | Pit | Adm | SSS | Dad | Mom | Vox | Tub | Tap | Top | Fab
------------------------------------------------------------------ |:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:
&#10003; [auth-52c6a32](code-review/dappsys/auth-52c6a32.md)                |  1  |     |  1  |  2  |  1  |  2  |  1  |  1  |  1  |  1  |  1  |  1  |  1
&#10003; [auth-ce285fb](code-review/dappsys/auth-ce285fb.md)                |     |  1  |     |     |     |     |     |     |     |     |     |     |  
&#10003; [base-e637e3f](code-review/dappsys/base-e637e3f.md)                |  7  |     |     |  6  |  8  |  6  |     |  7  |     |  7  |  7  |  7  |  9
[chief-a06b5e4](code-review/dappsys/chief-a06b5e4.md)              |     |     |     |     | 10  |     |     |     |     |     |     |     |  
&#10003; [erc20-56f16b3](code-review/dappsys/erc20-56f16b3.md)              |  6  |     |     |     |     |     |     |     |     |     |     |     |  
&#10003; [erc20-c4f5635](code-review/dappsys/erc20-c4f5635.md)              |     |     |     |  5  |  7  |  5  |     |  6  |     |  6  |  6  |  6  |  8
[guard-f8b7f58](code-review/dappsys/guard-f8b7f58.md)              |     |     |     |     |     |     |  2  |     |     |     |     |     |  2
[math-a01112f](code-review/dappsys/math-a01112f.md)                |     |  3  |     |     |     |     |     |     |     |     |     |     |  
[math-d5acd9c](code-review/dappsys/math-d5acd9c.md)                |  2  |     |  2  |  1  |  3  |  1  |     |  3  |  3  |  3  |  3  |  3  |  5
&#10003; [note-7170a08](code-review/dappsys/note-7170a08.md)                |  3  |  2  |  3  |  3  |  4  |  3  |     |  2  |  2  |  2  |  2  |  2  |  4
[roles-188b3dd](code-review/dappsys/roles-188b3dd.md)              |     |     |     |     |  2  |     |     |     |     |     |     |     |  3
&#10003; [stop-842e350](code-review/dappsys/stop-842e350.md)                |  5  |     |     |  4  |  6  |  4  |     |  5  |     |  5  |  5  |  5  |  7
&#10003; [thing-35b2538](code-review/dappsys/thing-35b2538.md)              |  4  |     |  4  |     |     |     |     |     |     |     |     |     |  
&#10003; [thing-4c86a53](code-review/dappsys/thing-4c86a53.md)              |     |     |     |     |  5  |     |     |  4  |  4  |  4  |  4  |  4  |  6
&#10003; [thing-ea63fd3](code-review/dappsys/thing-ea63fd3.md)              |     |  4  |     |     |     |     |     |     |     |     |     |     |  
&#10003; [token-e637e3f](code-review/dappsys/token-e637e3f.md)              |  8  |     |     |  7  |  9  |  7  |     |  8  |     |  8  |  8  |  8  | 10
&#10003; [value-2027f97](code-review/dappsys/value-2027f97.md)              |     |  5  |     |     |     |     |     |     |     |     |     |     |  
&#10003; [value-faae4cb](code-review/dappsys/value-faae4cb.md)              |     |     |  5  |     |     |     |     |  9  |     |  9  |  9  |  9  | 11
&#10003; [medianizer-31cc0a8](code-review/medianizer/medianizer-31cc0a8.md) |     |  6  |     |     |     |     |     |     |     |     |     |     |  
&#10003; [medianizer-6cb859c](code-review/medianizer/medianizer-6cb859c.md) |     |     |  6  |     |     |     |     |     |     |     |     |     |  
[pit-b353893](code-review/makerdao/pit-b353893.md)                 |     |     |     |  8  |     |     |     |     |     |     |     |     |  
[vox-b353893](code-review/makerdao/vox-b353893.md)                 |     |     |     |     |     |     |     | 10  |  5  | 10  | 10  | 10  | 12
[tub-b353893](code-review/makerdao/tub-b353893.md)                 |     |     |     |     |     |     |     | 11  |     | 11  | 11  | 11  | 13
[tap-b353893](code-review/makerdao/tap-b353893.md)                 |     |     |     |     |     |     |     | 12  |     |     | 12  | 12  | 14
[top-b353893](code-review/makerdao/top-b353893.md)                 |     |     |     |     |     |     |     | 13  |     |     |     | 13  | 15
[mom-b353893](code-review/makerdao/mom-b353893.md)                 |     |     |     |     |     |     |     | 14  |     |     |     |     | 16
[fab-b353893](code-review/makerdao/fab-b353893.md)                 |     |     |     |     |     |     |     |     |     |     |     |     | 17

<br />

<br />

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
[0x00000000]: https://etherscan.io/address/0x0000000000000000000000000000000000000000#code
[0x7bb0b085]: https://etherscan.io/address/0x7bb0b08587b8a6b8945e09f1baca426558b0f06a#code
