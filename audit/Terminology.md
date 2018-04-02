# Terminology

### Table Of Contents

* [Contracts And Objects](#contracts-and-objects)
* [Notes](#notes)
* [Tub: Store of Collateralised Debt Position](#tub-store-of-collateralised-debt-position)


### Contracts And Objects

<dl>
  <dt>gem</dt><dd>Wrapped ETH, the underlying collateral</dd>
  <dt>gov</dt><dd>MKR, the governance token</dd>
  <dt>pip</dt><dd>Reference price feed</dd>
  <dt>pep</dt><dd>Governance price feed</dd>
  <dt>pit</dt><dd>Governance vault</dd>
  <dt>adm</dt><dd></dd>
  <dt>sai</dt><dd>Sai or Dai, the stablecoin</dd>
  <dt>sin</dt><dd>Debt, negative sai</dd>
  <dt>skr</dt><dd>Pooled collateral</dd>
  <dt>dad</dt><dd></dd>
  <dt>mom</dt><dd></dd>
  <dt>vox</dt><dd>Target price feed</dd>
  <dt>tub</dt><dd></dd>
  <dt>tap</dt><dd>Liquidator</dd>
  <dt>top</dt><dd></dd>
</dl>

<br />

### Notes

<dl>
  <dt><a href="https://github.com/dapphub/ds-math/tree/0ec16b9c3db78a4c2574f0b9a4638615a35d25c6#dsmath--------">wad</a></dt><dd>Decimal number with 18 digits of precision</dd>
  <dt><a href="https://github.com/dapphub/ds-math/tree/0ec16b9c3db78a4c2574f0b9a4638615a35d25c6#dsmath--------">ray</a></dt><dd>Decimal number with 27 digits of precision</dd>
</dl>

Note:
* 0.9999988 ^ (24 * 60 * 60) = 0.901513679582627 ~ 10% decrease per day
* 1.0000011 ^ (24 * 60 * 60) = 1.099702784876423 ~ 10% increase per day

<br />

### Tub: Store of Collateralised Debt Position

<dl>
  <dt>axe</dt><dd><em>uint256</em> Liquidation penalty. Set by <code>mom.setAxe(...)</code>. <code>1e27 <= axe <= mat</code></dd>
  <dt>cap</dt><dd><em>uint256</em> Debt ceiling. Set by <code>mom.setCap(...)</code></dd>
  <dt>mat</dt><dd><em>uint256</em> Liquidation ratio. Set by <code>mom.setMat(...)</code>. <code>1e27 <= axe <= mat</code></dd>
  <dt>tax</dt><dd><em>uint256</em> Stability fee. Set by <code>mom.setTax(...)</code>. <code>1e27 <= tax < 1.0000011e27 (10% /day)</code></dd>
  <dt>fee</dt><dd><em>uint256</em> Governance fee. Set by <code>mom.setFee(...)</code>. <code>1e27 <= fee < 1.0000011e27 (10% /day)</code></dd>
  <dt>gap</dt><dd><em>uint256</em> Join-Exit spread. Set by <code>mom.setTubGap(...)</code></dd>
  <dt>off</dt><dd><em>bool</em> Cage flag</dd>
  <dt>out</dt><dd><em>bool</em> Post cage exit</dd>
  <dt>fit</dt><dd><em>uint256</em> REF per SKR (just before settlement)</dd>
  <dt>rho</dt><dd><em>uint256</em> Time of last drip</dd>
  <dt>_chi</dt><dd><em>uint256</em> Accumulated Tax Rates</dd>
  <dt>_rhi</dt><dd><em>uint256</em> Accumulated Tax + Fee Rates</dd>
  <dt>rum</dt><dd><em>uint256</em> Total normalised debt</dd>
  <dt>cupi</dt><dd><em>uint256</em> Number of cups, base 1</dd>
  <dt>cups</dt><dd><em>mapping (bytes32 => Cup)</em> record for each cup</dd>
  <dt>Cup.lad</dt><dd><em>address</em> CDP owner</dd>
  <dt>Cup.ink</dt><dd><em>uint256</em> Locked collateral (in SKR)</dd>
  <dt>Cup.art</dt><dd><em>uint256</em> Outstanding normalised debt (tax only)
  <dt>Cup.ire</dt><dd><em>uint256</em> Outstanding normalised debt</dd>
</dl>

<br />

### Vox

<dl>
  <dt>way</dt><dd><em>uint256</em> Rate of change of target price (per second). Set by <code>mom.setWay(...)</code>. <code>0.9999988e27 <= way < 1.0000011e27 (10% /day)</code></dd>
</dl>









