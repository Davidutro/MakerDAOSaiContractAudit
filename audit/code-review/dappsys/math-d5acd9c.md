# math-d5acd9c

Source file [../../contracts/dappsys/math-d5acd9c.sol](../../contracts/dappsys/math-d5acd9c.sol).

Repository https://github.com/dapphub/ds-math/blob/d5acd9c230361b29817ab3108743511747916abd/src/math.sol

<br />

<hr />

```javascript
/// math.sol -- mixin for inline numerical wizardry

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
contract DSMath {
    // BK Ok - Pure internal function
    function add(uint x, uint y) internal pure returns (uint z) {
        // BK Ok
        require((z = x + y) >= x);
    }
    // BK Ok - Pure internal function
    function sub(uint x, uint y) internal pure returns (uint z) {
        // BK Ok
        require((z = x - y) <= x);
    }
    // BK Ok - Pure internal function
    function mul(uint x, uint y) internal pure returns (uint z) {
        // BK Ok
        require(y == 0 || (z = x * y) / y == x);
    }
    // BK NOTE - No div(...), but EVM will throw on a divide by zero

    // BK Ok - Pure internal function
    function min(uint x, uint y) internal pure returns (uint z) {
        // BK Ok
        return x <= y ? x : y;
    }
    // BK Ok - Pure internal function
    function max(uint x, uint y) internal pure returns (uint z) {
        // BK Ok
        return x >= y ? x : y;
    }
    // BK Ok - Pure internal function
    function imin(int x, int y) internal pure returns (int z) {
        // BK Ok
        return x <= y ? x : y;
    }
    // BK Ok - Pure internal function
    function imax(int x, int y) internal pure returns (int z) {
        // BK Ok
        return x >= y ? x : y;
    }

    // BK Next 2 Ok
    uint constant WAD = 10 ** 18;
    uint constant RAY = 10 ** 27;

    // BK Ok - Pure internal function
    function wmul(uint x, uint y) internal pure returns (uint z) {
        // BK Ok
        z = add(mul(x, y), WAD / 2) / WAD;
    }
    // BK Ok - Pure internal function
    function rmul(uint x, uint y) internal pure returns (uint z) {
        // BK Ok
        z = add(mul(x, y), RAY / 2) / RAY;
    }
    // BK Ok - Pure internal function
    function wdiv(uint x, uint y) internal pure returns (uint z) {
        // BK Ok
        z = add(mul(x, WAD), y / 2) / y;
    }
    // BK Ok - Pure internal function
    function rdiv(uint x, uint y) internal pure returns (uint z) {
        // BK Ok
        z = add(mul(x, RAY), y / 2) / y;
    }

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
    //
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

    // BK Ok - Pure internal function
    function rpow(uint x, uint n) internal pure returns (uint z) {
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
}

```
