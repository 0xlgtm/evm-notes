// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract InlineAssemblyPadLeftTest is Test {
    uint256 val;
    bytes4 transferSig = 0xa9059cbb;

    // When you use bytes, bytesNN and string as a paramter type, they are always padded right
    // https://docs.soliditylang.org/en/latest/abi-spec.html#formal-specification-of-the-encoding
    function test_ArgumentPadRight(bytes4 some4Bytes) public {
        assembly {
            sstore(0, some4Bytes)
        }
        assertEq(vm.load(address(this), 0), bytes32(some4Bytes));
    }

    // everything else is padded left
    // https://docs.soliditylang.org/en/v0.8.17/abi-spec.html#formal-specification-of-the-encoding
    function test_ArgumentPadLeft(uint16 someUint16) public {
        assembly {
            sstore(0, someUint16)
        }
        assertEq(vm.load(address(this), 0), bytes32(uint256(someUint16)));
    }

    // But if you use it directly in assembly, it is always padded left
    function test_InlineAssemblyPadLeft() public {
        assembly {
            sstore(0, sload(transferSig.slot))
        }
        assertEq(vm.load(address(this), 0), bytes32(uint256(uint32(transferSig))));
    }
}
