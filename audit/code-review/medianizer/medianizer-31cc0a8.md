# medianizer-31cc0a8

Source file [../../contracts/medianizer/medianizer-31cc0a8.sol](../../contracts/medianizer/medianizer-31cc0a8.sol).

Repository https://github.com/makerdao/medianizer/blob/31cc0a8b8c5e33dffaeaadc2ff7665c4dc839126/src/medianizer.sol

<br />

<hr />

```javascript
// BK Ok
pragma solidity ^0.4.8;

// BK Ok
import 'ds-value/value.sol';

// BK Ok
// BK NOTE - medianizerPip.owner=0x0000000000000000000000000000000000000000
// BK NOTE - medianizerPip.authority=adm:0x8e2a84d6ade1e7fffee039a35ef5f19f13057152
// BK NOTE - pip.read() gives 0x000000000000000000000000000000000000000000000020a3e2ab6936928000
// BK NOTE - > new BigNumber("000000000000000000000000000000000000000000000020a3e2ab6936928000", 16)
// BK NOTE - 602105000000000000000
// BK NOTE - > new BigNumber("000000000000000000000000000000000000000000000020a3e2ab6936928000", 16).shift(-18)
// BK NOTE - 602.105
contract Medianizer is DSValue {
    // BK Ok
    mapping (bytes12 => address) public values;
    // BK Ok
    mapping (address => bytes12) public indexes;
    // BK Ok
    bytes12 public next = 0x1;

    // BK Ok
    uint96 public min = 0x1;

    // BK Ok - Only adm can set the PriceFeed address
    function set(address wat) auth {
        // BK Ok
        bytes12 nextId = bytes12(uint96(next) + 1);
        // BK Ok
        assert(nextId != 0x0);
        // BK Ok
        set(next, wat);
        // BK Ok
        next = nextId;
    }

    // BK Ok - Only adm can set the PriceFeed address
    function set(bytes12 pos, address wat) note auth {
        // BK Ok
        if (pos == 0x0) throw;

        // BK Ok
        if (wat != 0 && indexes[wat] != 0) throw;

        // BK Ok
        indexes[values[pos]] = 0; // Making sure to remove a possible existing address in that position

        // BK Ok
        if (wat != 0) {
            // BK Ok
            indexes[wat] = pos;
        }

        // BK Ok
        values[pos] = wat;
    }

    // BK Ok - Only adm can set minimum value
    function setMin(uint96 min_) note auth {
        // BK Ok
        if (min_ == 0x0) throw;
        // BK Ok
        min = min_;
    }

    // BK Ok - Only adm can set next id
    function setNext(bytes12 next_) note auth {
        // BK Ok
        if (next_ == 0x0) throw;
        // BK Ok
        next = next_;
    }

    // BK Ok - Only adm can unset address at pos
    function unset(bytes12 pos) {
        // BK Ok
        set(pos, 0);
    }

    // BK Ok - Only adm can unset address
    function unset(address wat) {
        // BK Ok
        set(indexes[wat], 0);
    }

    // BK Ok - Any account can call to compute the median
    function poke() {
        // BK Ok
        poke(0);
    }

    // BK Ok - Any account can call to compute the median
    function poke(bytes32) note {
        // BK Ok
        (val, has) = compute();
    }

    // BK Ok - Constant function, called by poke to calculate the median price
    function compute() constant returns (bytes32, bool) {
        // BK Ok
        bytes32[] memory wuts = new bytes32[](uint96(next) - 1);
        // BK Ok
        uint96 ctr = 0;
        // BK Ok - First item starts at 1, next is the index to the next item to be set
        for (uint96 i = 1; i < uint96(next); i++) {
            // BK Ok - PriceFeed address set
            if (values[bytes12(i)] != 0) {
                // BK Ok - PriceFeed value
                var (wut, wuz) = DSValue(values[bytes12(i)]).peek();
                // BK Ok - Value set
                if (wuz) {
                    // BK Ok - First item, or item >= last value
                    if (ctr == 0 || wut >= wuts[ctr - 1]) {
                        // BK Ok - Save value
                        wuts[ctr] = wut;
                    // BK Ok - item <= last value
                    } else {
                        // BK Ok
                        uint96 j = 0;
                        // BK Ok - Find first item where value < value to insert
                        while (wut >= wuts[j]) {
                            // BK Ok
                            j++;
                        }
                        // BK Ok - Shift all items up one slot
                        for (uint96 k = ctr; k > j; k--) {
                            // BK Ok
                            wuts[k] = wuts[k - 1];
                        }
                        // BK ok - Insert item
                        wuts[j] = wut;
                    }
                    // BK Ok
                    ctr++;
                }
            }
        }

        // BK Ok - Need a minimum number of price feeds
        if (ctr < min) return (val, false);

        // BK Ok
        bytes32 value;
        // BK Ok - Even number of items
        if (ctr % 2 == 0) {
            // BK Ok - Value below
            uint128 val1 = uint128(wuts[(ctr / 2) - 1]);
            // BK Ok - Value above
            uint128 val2 = uint128(wuts[ctr / 2]);
            // BK Ok - Average
            value = bytes32(wdiv(hadd(val1, val2), 2 ether));
        // BK Ok - Odd number of items
        } else {
            // BK Ok - Middle item
            value = wuts[(ctr - 1) / 2];
        }

        // BK Ok
        return (value, true);
    }

}

```
