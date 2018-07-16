# auth-ce285fb

Source file [../../contracts/dappsys/auth-ce285fb.sol](../../contracts/dappsys/auth-ce285fb.sol).

Repository https://github.com/dapphub/ds-auth/blob/ce285fba8ac4df04561cef04bab7ce825bd86aca/src/auth.sol

<br />

<hr />

```javascript
/// auth.sol -- widely-used access control pattern for Ethereum

// Copyright (C) 2015, 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

// BK Ok
pragma solidity ^0.4.8;

// BK Ok
contract DSAuthority {
    // BK Ok - Constant function, implemented in guard and roles
    function canCall(
        address src, address dst, bytes4 sig
    ) constant returns (bool);
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
    function DSAuth() {
        // BK Ok
        owner = msg.sender;
        // BK Ok - Log event
        LogSetOwner(msg.sender);
    }

    // BK Ok - Only authorised account (this contract, owner, permissioned DSAuthority) can execute
    function setOwner(address owner_)
        auth
    {
        // BK Ok
        owner = owner_;
        // BK Ok - Log event
        LogSetOwner(owner);
    }

    // BK Ok - Only authorised account (this contract, owner, permissioned DSAuthority) can execute
    function setAuthority(DSAuthority authority_)
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
        assert(isAuthorized(msg.sender, msg.sig));
        // BK Ok
        _;
    }

    // BK Ok - Modifier
    modifier authorized(bytes4 sig) {
        // BK Ok
        assert(isAuthorized(msg.sender, sig));
        // BK Ok
        _;
    }

    // BK Ok - Internal function - Not that this is not a constant function
    function isAuthorized(address src, bytes4 sig) internal returns (bool) {
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

    function assert(bool x) internal {
        if (!x) throw;
    }
}

```
