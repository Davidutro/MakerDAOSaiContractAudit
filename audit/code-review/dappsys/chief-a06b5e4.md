# chief-a06b5e4

Source file [../../contracts/dappsys/chief-a06b5e4.sol](../../contracts/dappsys/chief-a06b5e4.sol).

Repository https://github.com/dapphub/ds-chief/blob/a06b5e426a30e1471b93093857760b85e2fcb93a/src/chief.sol

<br />

<hr />

```javascript
// chief.sol - select an authority by consensus

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
pragma solidity ^0.4.17;

// BK Next 3 Ok
import 'ds-token/token.sol';
import 'ds-roles/roles.sol';
import 'ds-thing/thing.sol';

// The right way to use this contract is probably to mix it with some kind
// of `DSAuthority`, like with `ds-roles`.
//   SEE DSChief
// BK Ok
contract DSChiefApprovals is DSThing {
    // BK Next 4 Ok
    mapping(bytes32=>address[]) public slates;
    mapping(address=>bytes32) public votes;
    mapping(address=>uint256) public approvals;
    mapping(address=>uint256) public deposits;
    // BK Next 3 Ok
    // BK NOTE - adm.GOV=gov:0x9f8f72aa9304c8b593d555f12ef6589cc3a579a2
    DSToken public GOV; // voting token that gets locked up
    // BK NOTE - adm.IOU=IOU:0x9aed7a25f2d928225e6fb2388055c7363ad6727b
    DSToken public IOU; // non-voting representation of a token, for e.g. secondary voting mechanisms
    // BK NOTE - adm.hat=spell:0x347e94e12c623d7b9d51b3f143ff42b73d619773
    address public hat; // the chieftain's hat

    // BK Ok
    // BK NOTE - adm.MAX_YAYS=5
    uint256 public MAX_YAYS;

    // BK Ok - Event
    event Etch(bytes32 indexed slate);

    // IOU constructed outside this contract reduces deployment costs significantly
    // lock/free/vote are quite sensitive to token invariants. Caution is advised.
    // BK Ok - Constructor
    function DSChiefApprovals(DSToken GOV_, DSToken IOU_, uint MAX_YAYS_) public
    {
        // BK Next 3 Ok
        GOV = GOV_;
        IOU = IOU_;
        MAX_YAYS = MAX_YAYS_;
    }

    // BK Ok - Any account with MKR `approve(...)`d to this contract can call this function
    // BK NOTE - Eg https://etherscan.io/tx/0x64b6aaaac78591007ea5ac06a49467e0f70be3db042657b53cbe041321b3d5ca
    function lock(uint wad)
        public
        note
    {
        // BK Ok - transferFrom(...)
        GOV.pull(msg.sender, wad);
        // BK Ok - Mint IOU
        IOU.mint(msg.sender, wad);
        // BK Ok
        deposits[msg.sender] = add(deposits[msg.sender], wad);
        // BK Ok
        addWeight(wad, votes[msg.sender]);
    }

    // BK Ok - Any account that previously deposited MKR tokens can call this function
    // BK NOTE - Eg https://etherscan.io/tx/0x7616420fe921634246eaf052a94551142bfd5da9457fa910acf42c75f66ffa65
    function free(uint wad)
        public
        note
    {
        // BK Ok
        deposits[msg.sender] = sub(deposits[msg.sender], wad);
        // BK Ok
        subWeight(wad, votes[msg.sender]);
        // BK Ok
        IOU.burn(msg.sender, wad);
        // BK Ok - Transfer back to original account owner
        GOV.push(msg.sender, wad);
    }

    // BK Ok - Any account can execute
    // BK NOTE - Eg https://etherscan.io/tx/0xdfbe4d748a278660cd7b5482a69b561890888986b56a03fc253c7bc1442c9a81
    function etch(address[] yays)
        public
        note
        returns (bytes32 slate)
    {
        // BK Ok
        require( yays.length <= MAX_YAYS );
        // BK Ok
        requireByteOrderedSet(yays);

        // BK Ok
        bytes32 hash = keccak256(yays);
        // BK Ok
        slates[hash] = yays;
        // BK Ok - Log event
        Etch(hash);
        // BK Ok
        return hash;
    }

    // BK Ok - Any account can execute, but should have deposited MKR in prior call for their vote to have any weight
    // BK NOTE - Eg https://etherscan.io/tx/0x15700d1b584234219ad5849296b930f055c48acd3ba1d320ed59a078fd8a5fd4
    function vote(address[] yays) public returns (bytes32)
        // note  both sub-calls note
    {
        // BK Ok
        var slate = etch(yays);
        // BK Ok
        vote(slate);
        // BK Ok
        return slate;
    }

    // BK Ok - Any account can execute, but should have deposited MKR in prior call for their vote to have any weight
    // BK NOTE - Eg https://etherscan.io/tx/0x73989389a8a2f21d13751d76b304b4d32c0f8afdeeb694b3dc73850a46d53334
    function vote(bytes32 slate)
        public
        note
    {
        // BK Ok
        uint weight = deposits[msg.sender];
        // BK Ok
        subWeight(weight, votes[msg.sender]);
        // BK Ok
        votes[msg.sender] = slate;
        // BK Ok
        addWeight(weight, votes[msg.sender]);
    }

    // like `drop`/`swap` except simply "elect this address if it is higher than current hat"
    // BK Ok - Any account can execute this, but only the `whom` with more approvals than the current `hat` can be elected to replace the `hat`
    // BK NOTE - Eg https://etherscan.io/tx/0xdd6a7c725702f2e2cbe01eefb668e58b87d0a9a50a308ace9184722c181050e7
    function lift(address whom)
        public
        note
    {
        // BK Ok
        require(approvals[whom] > approvals[hat]);
        // BK Ok
        hat = whom;
    }

    // BK Ok - Internal function
    function addWeight(uint weight, bytes32 slate)
        internal
    {
        // BK Ok
        var yays = slates[slate];
        // BK Ok
        for( uint i = 0; i < yays.length; i++) {
            // BK Ok
            approvals[yays[i]] = add(approvals[yays[i]], weight);
        }
    }

    // BK Ok - Internal function
    function subWeight(uint weight, bytes32 slate)
        internal
    {
        // BK Ok
        var yays = slates[slate];
        // BK Ok
        for( uint i = 0; i < yays.length; i++) {
            // BK Ok
            approvals[yays[i]] = sub(approvals[yays[i]], weight);
        }
    }

    // Throws unless the array of addresses is a ordered set.
    // BK Ok - Pure internal function
    function requireByteOrderedSet(address[] yays)
        internal
        pure
    {
        // BK Ok - 0 or 1 element
        if( yays.length == 0 || yays.length == 1 ) {
            // BK Ok
            return;
        }
        // BK Ok - > 1 element, check in order
        for( uint i = 0; i < yays.length - 1; i++ ) {
            // strict inequality ensures both ordering and uniqueness
            // BK Ok
            require(uint(bytes32(yays[i])) < uint256(bytes32(yays[i+1])));
        }
    }
}


// `hat` address is unique root user (has every role) and the
// unique owner of role 0 (typically 'sys' or 'internal')
// BK Ok
// BK NOTE - adm.owner=0x0000000000000000000000000000000000000000
// BK NOTE - adm.authority=adm:0x8e2a84d6ade1e7fffee039a35ef5f19f13057152
contract DSChief is DSRoles, DSChiefApprovals {

    // BK Ok - Constructor
    function DSChief(DSToken GOV, DSToken IOU, uint MAX_YAYS)
             DSChiefApprovals (GOV, IOU, MAX_YAYS)
        public
    {
        // Set this contract as the authority
        // BK Ok
        authority = this;
        // And invalidate owner
        // BK Ok
        owner = 0;
    }

    // BK Ok - Any account can execute this function, but it will throw. i.e. disabled
    function setOwner(address owner_) public {
        // BK Ok
        owner_;
        // BK Ok
        revert();
    }

    // BK Ok - Any account can execute this function, but it will throw. i.e. disabled
    function setAuthority(DSAuthority authority_) public {
        // BK Ok
        authority_;
        // BK Ok
        revert();
    }

    // BK Ok - Constant function - `hat` is the root user
    function isUserRoot(address who)
        public
        constant
        returns (bool)
    {
        // BK Ok
        return (who == hat);
    }
    // BK Ok - Any account can execute this function, but it will throw. i.e. disabled
    function setRootUser(address who, bool enabled) public {
        // BK Ok
        who; enabled;
        // BK Ok
        revert();
    }
}

// BK Ok
contract DSChiefFab {
    // BK Ok
    function newChief(DSToken gov, uint MAX_YAYS) public returns (DSChief chief) {
        // BK Ok
        DSToken iou = new DSToken('IOU');
        // BK Ok
        chief = new DSChief(gov, iou, MAX_YAYS);
        // BK Ok
        iou.setOwner(chief);
    }
}

```
