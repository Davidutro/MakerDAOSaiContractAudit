# value-faae4cb

Source file [../../contracts/dappsys/value-faae4cb.sol](../../contracts/dappsys/value-faae4cb.sol).

Repository https://github.com/dapphub/ds-value/blob/faae4cb37922fcdb002793a34c7d410b0a23e737/src/value.sol

<br />

<hr />

```javascript
/// value.sol - a value is a simple thing, it can be get and set

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

// BK Ok
import 'ds-thing/thing.sol';

// BK Ok
contract DSValue is DSThing {
    // BK Ok
    bool    has;
    // BK Ok
    bytes32 val;
    // BK Ok - View function
    function peek() public view returns (bytes32, bool) {
        // BK Ok
        return (val,has);
    }
    // BK Ok - View function, a variation of peek with a check for existence of value
    function read() public view returns (bytes32) {
        // BK Ok
        var (wut, haz) = peek();
        // BK Ok
        assert(haz);
        // BK Ok
        return wut;
    }
        // BK Ok - Authorised account is able to set a value
    function poke(bytes32 wut) public note auth {
        // BK Ok
        val = wut;
        // BK Ok
        has = true;
    }
    // BK Ok - Authorised account is able to remove a value
    function void() public note auth {  // unset the value
        // BK Ok
        has = false;
    }
}

```
