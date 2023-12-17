// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract PackRightFirst {
    // If we are relying on the compiler to automatically pack our variables
    // for us, it is important to know the order at which they are packed in a slot.
    // Given the four storage variables below, the right most bytes contain
    // the value a and the left most bytes contain the value d i.e.
    // 0xddddddddddddddddddddddddddddddddccccccccccccccccbbbbbbbbaaaaaaaa
    uint32 a;
    uint32 b;
    uint64 c;
    uint128 d;

    function pack(uint32 _a, uint32 _b, uint64 _c, uint128 _d) public {
        a = _a;
        b = _b;
        c = _c;
        d = _d;
    }
}

contract PackRightFirstTest is Test {
    PackRightFirst example;

    function setUp() public {
        example = new PackRightFirst();
    }

    function test_AutoPack(uint32 _a, uint32 _b, uint64 _c, uint128 _d) public {
        example.pack(_a, _b, _c, _d);

        // Let's manually pack our variable
        // Note: you need to cast _d to a uint256 before any shifting
        // otherwise it'll use the type of uint128 and overflow when
        // you try to shift 128 bits. The final value is then casted
        // to uint256 before being assigned to packed.
        uint256 packed = (((((uint256(_d) << 64) | _c) << 32) | _b) << 32) | _a;
        assertEq(vm.load(address(example), 0), bytes32(packed));
    }
}
