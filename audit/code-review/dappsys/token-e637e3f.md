# token-e637e3f

Source file [../../contracts/dappsys/token-e637e3f.sol](../../contracts/dappsys/token-e637e3f.sol).

Repository https://github.com/dapphub/ds-token/blob/e637e3f3aff929ca4e72966015c16df0b235ea2a/src/token.sol

<br />

<hr />

```javascript
/// token.sol -- ERC20 implementation with minting and burning

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

// BK Ok
import "ds-stop/stop.sol";

// BK Ok
import "./base.sol";

// BK Ok - ERC20 with name, symbol and decimals, stoppable by authorised account
contract DSToken is DSTokenBase(0), DSStop {

    // BK Next 2 Ok
    bytes32  public  symbol;
    // BK Ok - Should be uint8, but no known problems with other tokens using uint256
    uint256  public  decimals = 18; // standard token precision. override to customize

    // BK Ok - Constructor
    function DSToken(bytes32 symbol_) public {
        // BK
        symbol = symbol_;
    }

    // BK Next 2 Ok - Events
    event Mint(address indexed guy, uint wad);
    event Burn(address indexed guy, uint wad);

    // BK Ok - Any account can execute when operations are not stopped
    function approve(address guy) public stoppable returns (bool) {
        // BK Ok
        return super.approve(guy, uint(-1));
    }

    // BK Ok - Any account can execute when operations are not stopped
    function approve(address guy, uint wad) public stoppable returns (bool) {
        // BK Ok
        return super.approve(guy, wad);
    }

    // BK Ok - Any account with balance or approved balanced from the spending account can execute when operations are not stopped
    function transferFrom(address src, address dst, uint wad)
        public
        stoppable
        returns (bool)
    {
        // BK Ok - Approval of 0xffff...ffff does not get approved amount updated
        if (src != msg.sender && _approvals[src][msg.sender] != uint(-1)) {
            // BK Ok
            _approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
        }

        // BK Next 2 Ok
        _balances[src] = sub(_balances[src], wad);
        _balances[dst] = add(_balances[dst], wad);

        // BK Ok - Log event
        Transfer(src, dst, wad);

        // BK Ok
        return true;
    }

    // BK Ok - Variation of transferFrom above
    function push(address dst, uint wad) public {
        // BK Ok
        transferFrom(msg.sender, dst, wad);
    }
    // BK Ok - Variation of transferFrom above
    function pull(address src, uint wad) public {
        // BK Ok
        transferFrom(src, msg.sender, wad);
    }
    // BK Ok - Variation of transferFrom above
    function move(address src, address dst, uint wad) public {
        // BK Ok
        transferFrom(src, dst, wad);
    }

    // BK Ok - Short form of mint below
    function mint(uint wad) public {
        // BK Ok
        mint(msg.sender, wad);
    }
    // BK Ok - Short form of burn below
    function burn(uint wad) public {
        // BK Ok
        burn(msg.sender, wad);
    }
    // BK Ok - Authorised account is able to mint tokens for an account when operations are not stopped
    function mint(address guy, uint wad) public auth stoppable {
        // BK Ok
        _balances[guy] = add(_balances[guy], wad);
        // BK Ok
        _supply = add(_supply, wad);
        // BK Ok - Log event
        Mint(guy, wad);
    }
    // BK Ok - Authorised account is able to burn it's own tokens, or tokens approved by another account, when operations are not stopped
    function burn(address guy, uint wad) public auth stoppable {
        // BK Ok - Approval of 0xffff...ffff does not get approved amount updated
        if (guy != msg.sender && _approvals[guy][msg.sender] != uint(-1)) {
            // BK Ok
            _approvals[guy][msg.sender] = sub(_approvals[guy][msg.sender], wad);
        }

        // BK Ok
        _balances[guy] = sub(_balances[guy], wad);
        // BK Ok
        _supply = sub(_supply, wad);
        // BK Ok - Log event
        Burn(guy, wad);
    }

    // Optional token name
    // BK Ok - Normally a string, but Ok
    bytes32   public  name = "";

    // BK Ok - Name can be updated by an authorised account
    function setName(bytes32 name_) public auth {
        // BK Ok
        name = name_;
    }
}

```
