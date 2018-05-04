# base-e637e3f

Source file [../../contracts/dappsys/base-e637e3f.sol](../../contracts/dappsys/base-e637e3f.sol).

Repository https://github.com/dapphub/ds-token/blob/e637e3f3aff929ca4e72966015c16df0b235ea2a/src/base.sol

<br />

<hr />

```javascript
/// base.sol -- basic ERC20 implementation

// Copyright (C) 2015, 2016, 2017  DappHub, LLC

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

// BK Next 2 Ok
import "erc20/erc20.sol";
import "ds-math/math.sol";

// BK Ok
contract DSTokenBase is ERC20, DSMath {
    // BK Ok
    uint256                                            _supply;
    // BK Next 2 Ok
    mapping (address => uint256)                       _balances;
    mapping (address => mapping (address => uint256))  _approvals;

    // BK Ok - Constructor
    function DSTokenBase(uint supply) public {
        // BK Ok
        _balances[msg.sender] = supply;
        // BK Ok
        _supply = supply;
    }

    // BK Ok - View function
    function totalSupply() public view returns (uint) {
        // BK Ok
        return _supply;
    }
    // BK Ok - View function
    function balanceOf(address src) public view returns (uint) {
        // BK Ok
        return _balances[src];
    }
    // BK Ok - View function
    function allowance(address src, address guy) public view returns (uint) {
        // BK Ok
        return _approvals[src][guy];
    }

    // BK Ok - Any account with token balance can call
    function transfer(address dst, uint wad) public returns (bool) {
        // BK Ok
        return transferFrom(msg.sender, dst, wad);
    }

    // BK Ok - Any account with token balance or approved to spend src's token balance can call
    function transferFrom(address src, address dst, uint wad)
        public
        returns (bool)
    {
        // BK Ok
        if (src != msg.sender) {
            // BK Ok
            _approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
        }

        // BK Ok
        _balances[src] = sub(_balances[src], wad);
        // BK Ok
        _balances[dst] = add(_balances[dst], wad);

        // BK Ok - Log event
        Transfer(src, dst, wad);

        // BK Ok
        return true;
    }

    // BK Ok - Any account can call
    function approve(address guy, uint wad) public returns (bool) {
        // BK Ok
        _approvals[msg.sender][guy] = wad;

        // BK Ok - Log event
        Approval(msg.sender, guy, wad);

        // BK Ok
        return true;
    }
}

```
