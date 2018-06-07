# roles-188b3dd

Source file [../../contracts/dappsys/roles-188b3dd.sol](../../contracts/dappsys/roles-188b3dd.sol).

Repository https://github.com/dapphub/ds-roles/blob/188b3dd6497d1f8c17b5bb381b37bdf238e3d239/src/roles.sol

<br />

<hr />

```javascript
// roles.sol - roled based authentication

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
import 'ds-auth/auth.sol';

// BK Ok
contract DSRoles is DSAuth, DSAuthority
{
    // BK Next 4 Ok
    mapping(address=>bool) _root_users;
    mapping(address=>bytes32) _user_roles;
    mapping(address=>mapping(bytes4=>bytes32)) _capability_roles;
    mapping(address=>mapping(bytes4=>bool)) _public_capabilities;

    // BK Ok - View function. No roles set up in the MakerDAO system
    function getUserRoles(address who)
        public
        view
        returns (bytes32)
    {
        // BK Ok
        return _user_roles[who];
    }

    // BK Ok - View function. No roles set up in the MakerDAO system
    function getCapabilityRoles(address code, bytes4 sig)
        public
        view
        returns (bytes32)
    {
        // BK Ok
        return _capability_roles[code][sig];
    }

    // BK Ok - Overridden in chief
    function isUserRoot(address who)
        public
        view
        returns (bool)
    {
        // BK Ok
        return _root_users[who];
    }

    // BK Ok - View function. No capabilities set up in the MakerDAO system
    function isCapabilityPublic(address code, bytes4 sig)
        public
        view
        returns (bool)
    {
        // BK Ok
        return _public_capabilities[code][sig];
    }

    // BK Ok - View function, not used in the MakerDAO system
    function hasUserRole(address who, uint8 role)
        public
        view
        returns (bool)
    {
        // BK Ok
        bytes32 roles = getUserRoles(who);
        // BK Ok
        bytes32 shifted = bytes32(uint256(uint256(2) ** uint256(role)));
        // BK Ok
        return bytes32(0) != roles & shifted;
    }

    // BK Ok - View function
    // BK NOTE - This is the function that provides the permissioning for the ChiefAdm in the MakerDAO system, where the permission is enabled for the `hat`, which is voted upon
    function canCall(address caller, address code, bytes4 sig)
        public
        view
        returns (bool)
    {
        // BK Ok - isUserRoot(...) permissions the ChiefAdm `hat`
        if( isUserRoot(caller) || isCapabilityPublic(code, sig) ) {
            // BK Ok
            return true;
        // BK Ok
        } else {
            // BK Ok
            var has_roles = getUserRoles(caller);
            // BK Ok
            var needs_one_of = getCapabilityRoles(code, sig);
            // BK Ok
            return bytes32(0) != has_roles & needs_one_of;
        }
    }

    // BK Ok - Internal pure function
    function BITNOT(bytes32 input) internal pure returns (bytes32 output) {
        // BK Ok
        return (input ^ bytes32(uint(-1)));
    }

    // BK Ok - This is overridden in the ChiefAdm to revert if called
    function setRootUser(address who, bool enabled)
        public
        auth
    {
        // BK Ok
        _root_users[who] = enabled;
    }

    // BK Ok - This is not called in the MakerDAO system so far
    function setUserRole(address who, uint8 role, bool enabled)
        public
        auth
    {
        // BK Ok
        var last_roles = _user_roles[who];
        // BK Ok
        bytes32 shifted = bytes32(uint256(uint256(2) ** uint256(role)));
        // BK Ok
        if( enabled ) {
            // BK Ok
            _user_roles[who] = last_roles | shifted;
        // BK Ok
        } else {
            // BK Ok
            _user_roles[who] = last_roles & BITNOT(shifted);
        }
    }

    // BK Ok - Not used in MakerDAO system
    function setPublicCapability(address code, bytes4 sig, bool enabled)
        public
        auth
    {
        // BK Ok
        _public_capabilities[code][sig] = enabled;
    }

    // BK Ok - Not used in MakerDAO system
    function setRoleCapability(uint8 role, address code, bytes4 sig, bool enabled)
        public
        auth
    {
        // BK Ok
        var last_roles = _capability_roles[code][sig];
        // BK Ok
        bytes32 shifted = bytes32(uint256(uint256(2) ** uint256(role)));
        // BK Ok
        if( enabled ) {
            // BK Ok
            _capability_roles[code][sig] = last_roles | shifted;
        // BK Ok
        } else {
            // BK Ok
            _capability_roles[code][sig] = last_roles & BITNOT(shifted);
        }

    }

}

```
