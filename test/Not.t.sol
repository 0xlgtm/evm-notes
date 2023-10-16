// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

contract NotTest is Test {
    // In most programming languages, if you do not(1), you will get 0.
    // If you do not(true), you will get false. However in assembly,
    // the `not` operates on the bits i.e. it is a bitwise negation.
    // This can throw you off sometimes if you're not careful.

    function negate(uint256 a) public pure returns (uint256 b) {
        assembly {
            b := not(a)
        }
    }

    function test_NegateOneIsNotZero() public {
        // When you negate 1, you are negating the bitwise representation of 1.
        // The resulting value is not zero but rather type(uint256).max - 1 because
        // you have 255 leading 1s and 1 0 at the end.
        uint256 a = 1;
        uint256 b = negate(a);
        assertNotEq(b, 0);
        assertEq(b, type(uint256).max - 1);
    }

    function test_NegateNoneOneIsNotZero(uint256 a) public {
        // The same also applies here. When you negate any positive value that is not
        // the max value of uint256, you will always get a "true" value.
        vm.assume(a > 1);
        vm.assume(a < type(uint256).max);
        uint256 b = negate(a);
        assertNotEq(b, 0);
    }

    function test_NegateUint256MaxIsZero() public {
        // As you can see here, negating the max value of uint256 will give you a
        // "false" value or 0.
        uint256 a = type(uint256).max;
        uint256 b = negate(a);
        assertEq(b, 0);
    }

    function test_NegateZeroIsNotOne() public {
        // Likewise if you negate 0, you do not get 1 because at a bit level, all your
        // 0s become 1s i.e. not(0) gets you type(uint256).max
        uint256 a = 0;
        uint256 b = negate(a);
        assertNotEq(b, 1);
        assertEq(b, type(uint256).max);
    }
}
