# thing-4c86a53

Source file [../../contracts/dappsys/thing-4c86a53.sol](../../contracts/dappsys/thing-4c86a53.sol).

Repository https://github.com/dapphub/ds-thing/blob/4c86a534b2cdaf7c7a8564dfd8572ef466615a00/src/thing.sol

<br />

<hr />

```javascript
// thing.sol - `auth` with handy mixins. your things should be DSThings

// Copyright (C) 2017  DappHub, LLC

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// BK Ok
pragma solidity ^0.4.13;

// BK Next 3 Ok
import 'ds-auth/auth.sol';
import 'ds-note/note.sol';
import 'ds-math/math.sol';

// BK Ok
contract DSThing is DSAuth, DSNote, DSMath {

    // BK Ok - Internal pure function
    function S(string s) internal pure returns (bytes4) {
        // BK Ok
        return bytes4(keccak256(s));
    }

}

```
