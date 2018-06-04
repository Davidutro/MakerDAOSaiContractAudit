# math-a01112f

Source file [../../contracts/dappsys/math-a01112f.sol](../../contracts/dappsys/math-a01112f.sol).

Repository https://github.com/dapphub/ds-math/blob/a01112f73507c42961d497ba18a352aca41474cb/src/math.sol

<br />

<hr />

```javascript
/// math.sol -- mixin for inline numerical wizardry

// Copyright (C) 2015, 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

// BK Ok
pragma solidity ^0.4.10;

// BK Ok
contract DSMath {
    
    /*
    standard uint256 functions
     */

    // BK Ok - Constant internal function
    function add(uint256 x, uint256 y) constant internal returns (uint256 z) {
        // BK Ok
        assert((z = x + y) >= x);
    }

    // BK Ok - Constant internal function
    function sub(uint256 x, uint256 y) constant internal returns (uint256 z) {
        // BK Ok
        assert((z = x - y) <= x);
    }

    // BK Ok - Constant internal function
    function mul(uint256 x, uint256 y) constant internal returns (uint256 z) {
        // BK Ok
        assert((z = x * y) >= x);
    }

    // BK Ok - Constant internal function
    function div(uint256 x, uint256 y) constant internal returns (uint256 z) {
        // BK Ok - EVM will throw on a divide by zero
        z = x / y;
    }

    // BK Ok - Constant internal function
    function min(uint256 x, uint256 y) constant internal returns (uint256 z) {
        // BK Ok
        return x <= y ? x : y;
    }
    // BK Ok - Constant internal function
    function max(uint256 x, uint256 y) constant internal returns (uint256 z) {
        // BK Ok
        return x >= y ? x : y;
    }

    /*
    uint128 functions (h is for half)
     */

    // BK Ok - Constant internal function
    function hadd(uint128 x, uint128 y) constant internal returns (uint128 z) {
        // BK Ok
        assert((z = x + y) >= x);
    }

    // BK Ok - Constant internal function
    function hsub(uint128 x, uint128 y) constant internal returns (uint128 z) {
        // BK Ok
        assert((z = x - y) <= x);
    }

    // BK Ok - Constant internal function
    function hmul(uint128 x, uint128 y) constant internal returns (uint128 z) {
        // BK Ok
        assert((z = x * y) >= x);
    }

    // BK Ok - Constant internal function
    function hdiv(uint128 x, uint128 y) constant internal returns (uint128 z) {
        // BK Ok - EVM will throw on a divide by zero
        z = x / y;
    }

    // BK Ok - Constant internal function
    function hmin(uint128 x, uint128 y) constant internal returns (uint128 z) {
        // BK Ok
        return x <= y ? x : y;
    }
    // BK Ok - Constant internal function
    function hmax(uint128 x, uint128 y) constant internal returns (uint128 z) {
        // BK Ok
        return x >= y ? x : y;
    }


    /*
    int256 functions
     */

    // BK Ok - Constant internal function
    function imin(int256 x, int256 y) constant internal returns (int256 z) {
        // BK Ok
        return x <= y ? x : y;
    }
    // BK Ok - Constant internal function
    function imax(int256 x, int256 y) constant internal returns (int256 z) {
        // BK Ok
        return x >= y ? x : y;
    }

    /*
    WAD math
     */

    // BK Ok
    uint128 constant WAD = 10 ** 18;

    // BK Ok - Constant internal function
    function wadd(uint128 x, uint128 y) constant internal returns (uint128) {
        // BK Ok
        return hadd(x, y);
    }

    // BK Ok - Constant internal function
    function wsub(uint128 x, uint128 y) constant internal returns (uint128) {
        // BK Ok
        return hsub(x, y);
    }

    // BK Ok - Constant internal function
    function wmul(uint128 x, uint128 y) constant internal returns (uint128 z) {
        // BK Ok
        z = cast((uint256(x) * y + WAD / 2) / WAD);
    }

    // BK Ok - Constant internal function
    function wdiv(uint128 x, uint128 y) constant internal returns (uint128 z) {
        // BK Ok
        z = cast((uint256(x) * WAD + y / 2) / y);
    }

    // BK Ok - Constant internal function
    function wmin(uint128 x, uint128 y) constant internal returns (uint128) {
        // BK Ok
        return hmin(x, y);
    }
    // BK Ok - Constant internal function
    function wmax(uint128 x, uint128 y) constant internal returns (uint128) {
        // BK Ok
        return hmax(x, y);
    }

    /*
    RAY math
     */

    // BK Ok
    uint128 constant RAY = 10 ** 27;

    // BK Ok - Constant internal function
    function radd(uint128 x, uint128 y) constant internal returns (uint128) {
        // BK Ok
        return hadd(x, y);
    }

    // BK Ok - Constant internal function
    function rsub(uint128 x, uint128 y) constant internal returns (uint128) {
        // BK Ok
        return hsub(x, y);
    }

    // BK Ok - Constant internal function
    function rmul(uint128 x, uint128 y) constant internal returns (uint128 z) {
        // BK Ok
        z = cast((uint256(x) * y + RAY / 2) / RAY);
    }

    // BK Ok - Constant internal function
    function rdiv(uint128 x, uint128 y) constant internal returns (uint128 z) {
        // BK Ok
        z = cast((uint256(x) * RAY + y / 2) / y);
    }

    // BK Ok - Constant internal function
    function rpow(uint128 x, uint64 n) constant internal returns (uint128 z) {
        // This famous algorithm is called "exponentiation by squaring"
        // and calculates x^n with x as fixed-point and n as regular unsigned.
        //
        // It's O(log n), instead of O(n) for naive repeated multiplication.
        //
        // These facts are why it works:
        //
        //  If n is even, then x^n = (x^2)^(n/2).
        //  If n is odd,  then x^n = x * x^(n-1),
        //   and applying the equation for even x gives
        //    x^n = x * (x^2)^((n-1) / 2).
        //
        //  Also, EVM division is flooring and
        //    floor[(n-1) / 2] = floor[n / 2].

        // BK NOTE - https://mpark.github.io/programming/2014/08/18/exponentiation-by-squaring/
        // BK NOTE - double exp(double x, int n) {
        // BK NOTE -   if (n < 0) return 1 / exp(x, -n);
        // BK NOTE -   double result = 1;
        // BK NOTE -   while (n > 0) {
        // BK NOTE -     if (n % 2 == 1) result *= x;
        // BK NOTE -     x *= x;
        // BK NOTE -     n /= 2;
        // BK NOTE -   }  // while
        // BK NOTE -   return result;
        // BK NOTE - }

        // BK Ok
        z = n % 2 != 0 ? x : RAY;

        // BK Next block Ok
        for (n /= 2; n != 0; n /= 2) {
            x = rmul(x, x);

            if (n % 2 != 0) {
                z = rmul(z, x);
            }
        }
    }

    // BK Ok - Constant internal function
    function rmin(uint128 x, uint128 y) constant internal returns (uint128) {
        // BK Ok
        return hmin(x, y);
    }
    // BK Ok - Constant internal function
    function rmax(uint128 x, uint128 y) constant internal returns (uint128) {
        // BK Ok
        return hmax(x, y);
    }

    // BK Ok - Constant internal function
    function cast(uint256 x) constant internal returns (uint128 z) {
        // BK Ok
        assert((z = uint128(x)) == x);
    }

}

```
