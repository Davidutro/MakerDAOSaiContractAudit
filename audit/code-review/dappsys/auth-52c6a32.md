# auth-52c6a32

Source file [../../contracts/dappsys/auth-52c6a32.sol](../../contracts/dappsys/auth-52c6a32.sol).

Repository https://github.com/dapphub/ds-auth/blob/52c6a32a858601859dd809c718b59fb064fa21a7/src/auth.sol

<br />

<hr />

```javascript
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
contract DSAuthority {
    // BK Ok - View function, implemented in guard
    function canCall(
        address src, address dst, bytes4 sig
    ) public view returns (bool);
}

// BK Ok
contract DSAuthEvents {
    // BK Next 2 Ok
    event LogSetAuthority (address indexed authority);
    event LogSetOwner     (address indexed owner);
}

// BK Ok
contract DSAuth is DSAuthEvents {
    // BK Ok
    DSAuthority  public  authority;
    // BK Ok
    address      public  owner;

    // BK Ok - Constructor
    function DSAuth() public {
        // BK Ok
        owner = msg.sender;
        // BK Ok - Log event
        LogSetOwner(msg.sender);
    }

    // BK Ok - Only authorised account (this contract, owner, permissioned DSAuthority) can execute
    function setOwner(address owner_)
        public
        auth
    {
        // BK Ok
        owner = owner_;
        // BK Ok - Log event
        LogSetOwner(owner);
    }

    // BK Ok - Only authorised account (this contract, owner, permissioned DSAuthority) can execute
    function setAuthority(DSAuthority authority_)
        public
        auth
    {
        // BK Ok
        authority = authority_;
        // BK Ok - Log event
        LogSetAuthority(authority);
    }

    // BK Ok - Modifier
    modifier auth {
        // BK Ok
        require(isAuthorized(msg.sender, msg.sig));
        // BK Ok
        _;
    }

    // BK Ok - Internal view function
    function isAuthorized(address src, bytes4 sig) internal view returns (bool) {
        // BK Ok - Contract can call itself
        if (src == address(this)) {
            // BK Ok
            return true;
        // BK Ok - owner can call
        } else if (src == owner) {
            // BK Ok
            return true;
        // BK Ok - Reject if authority is not set
        } else if (authority == DSAuthority(0)) {
            // BK Ok
            return false;
        // BK Ok
        } else {
            // Check guard function result
            return authority.canCall(src, this, sig);
        }
    }
}

```
