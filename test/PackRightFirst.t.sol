// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract Pack {
    // As we are relying on solidity to automatically pack our variables for us
    // into a single slot, it is important to understand the packing order.
    // Solidity packs variables from the right.
    // The right most bytes contain the value a because it is packed first
    // and the left most bytes contain the value d because it is packed last i.e.
    // 0xddddddddddddddddddddddddddddddddccccccccccccccccbbbbbbbbaaaaaaaa
    uint32 a;
    uint32 b;
    uint64 c;
    uint128 d;

    function setValues(uint32 _a, uint32 _b, uint64 _c, uint128 _d) public {
        a = _a;
        b = _b;
        c = _c;
        d = _d;
    }

    function getValues() public returns(uint256 val) {
        assembly {
            val := sload(0) // Note that a.slot, b.slot, c.slot and d.slot all refers to slot 0.
        }
    }
}

contract PackRightFirstTest is Test {

    Pack pack;

    function setUp() public {
        pack = new Pack();
    }
    
    function test_autoPack(uint32 _a, uint32 _b, uint64 _c, uint128 _d) public {

        pack.setValues(_a, _b, _c, _d);

        // Let's manually pack the variable mp.
        uint256 mp;
        assembly {
            // Insert _d into mp
            mp := or(mp, _d)
            // Shift left by 64 bits to make space for _c
            mp := shl(64, mp)
            // Repeat for _c, _b and _a
            mp := or(mp, _c)
            mp := shl(32, mp)
            mp := or(mp, _b)
            mp := shl(32, mp)
            mp := or(mp, _a)
        }
        assertEq(mp, pack.getValues());
    }

}
