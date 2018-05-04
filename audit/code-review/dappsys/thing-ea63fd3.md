# thing-ea63fd3

Source file [../../contracts/dappsys/thing-ea63fd3.sol](../../contracts/dappsys/thing-ea63fd3.sol).

Repository https://github.com/dapphub/ds-thing/blob/ea63fd311d3a6018401eb2ef84c9deffaca20e55/src/thing.sol

<br />

<hr />

```javascript
// `auth` with handy mixins. your things should be DSThings

// Copyright (C) 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

// BK Ok
pragma solidity ^0.4.8;

// BK Next 3 Ok
import 'ds-auth/auth.sol';
import 'ds-note/note.sol';
import 'ds-math/math.sol';

// BK Ok
contract DSThing is DSAuth, DSNote, DSMath {
}

```
