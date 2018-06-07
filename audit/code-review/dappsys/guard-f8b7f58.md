# guard-f8b7f58

Source file [../../contracts/dappsys/guard-f8b7f58.sol](../../contracts/dappsys/guard-f8b7f58.sol).

Repository https://github.com/dapphub/ds-guard/blob/f8b7f58c0fb5e88bba376e3dfa7a856617fabc0e/src/guard.sol

<br />

<hr />

```javascript
// guard.sol -- simple whitelist implementation of DSAuthority

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
import "ds-auth/auth.sol";

// BK Ok
contract DSGuardEvents {
    // BK Ok - Event
    event LogPermit(
        bytes32 indexed src,
        bytes32 indexed dst,
        bytes32 indexed sig
    );

    // BK Ok - Event
    event LogForbid(
        bytes32 indexed src,
        bytes32 indexed dst,
        bytes32 indexed sig
    );
}

// BK Ok
contract DSGuard is DSAuth, DSAuthority, DSGuardEvents {
    // BK Ok - 0xffff...ffff
    bytes32 constant public ANY = bytes32(uint(-1));

    // BK Ok
    mapping (bytes32 => mapping (bytes32 => mapping (bytes32 => bool))) acl;

    // BK Ok
    function canCall(
        address src_, address dst_, bytes4 sig
    ) public view returns (bool) {
        // BK Ok
        var src = bytes32(src_);
        // BK Ok
        var dst = bytes32(dst_);

        // BK Ok
        return acl[src][dst][sig]
            || acl[src][dst][ANY]
            || acl[src][ANY][sig]
            || acl[src][ANY][ANY]
            || acl[ANY][dst][sig]
            || acl[ANY][dst][ANY]
            || acl[ANY][ANY][sig]
            || acl[ANY][ANY][ANY];
    }

    // BK Ok - Was set up in `fab` via the `permit(...)` version below, and permissions no longer available to execute this
    function permit(bytes32 src, bytes32 dst, bytes32 sig) public auth {
        // BK Ok
        acl[src][dst][sig] = true;
        // BK Ok - Log event
        LogPermit(src, dst, sig);
    }

    // BK Ok - Not used in MakerDAO system, and permissions no longer available to execute this
    function forbid(bytes32 src, bytes32 dst, bytes32 sig) public auth {
        // BK Ok
        acl[src][dst][sig] = false;
        // BK Ok - Log event
        LogForbid(src, dst, sig);
    }

    // BK Ok - Permissioning on this function is enforced in the called `permit(...)` function above 
    function permit(address src, address dst, bytes32 sig) public {
        // BK Ok
        permit(bytes32(src), bytes32(dst), sig);
    }
    // BK Ok - Permissioning on this function is enforced in the called `forbid(...)` function above
    function forbid(address src, address dst, bytes32 sig) public {
        // BK Ok
        forbid(bytes32(src), bytes32(dst), sig);
    }

}

// BK Ok - Not used in the MakerDAO system
contract DSGuardFactory {
    // BK Ok
    mapping (address => bool)  public  isGuard;

    // BK Ok - Constructor
    function newGuard() public returns (DSGuard guard) {
        // BK Ok
        guard = new DSGuard();
        // BK Ok
        guard.setOwner(msg.sender);
        // BK Ok
        isGuard[guard] = true;
    }
}

```
