pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract TypeCastingTest is Test {
    // https://docs.soliditylang.org/en/latest/types.html#explicit-conversions

    // When downcasting uint, higher order bits are truncated.
    // When upcasting uint, 0s are padded to the right.
    function test_UintCast() public {
        uint32 a = 0x12345678;
        uint16 b = uint16(a);
        assertEq(b, 0x5678);
        uint32 c = uint32(b);
        assertEq(c, 0x00005678); 
    }

    // When downcasting bytesNN, lower order bits are truncated.
    // When upcasting bytesNN, 0s are padded to the left.

    function test_BytesNNCast() public {
        bytes2 a = 0x1234;
        bytes1 b = bytes1(a);
        assertEq(b, bytes1(0x12));
        bytes2 c = bytes2(b);
        assertEq(c, bytes2(0x1200));
    }
}