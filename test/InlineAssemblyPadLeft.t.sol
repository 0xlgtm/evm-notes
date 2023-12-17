// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract InlineAssemblyPadLeft {
    uint256 public val;
    bytes4 public transferSig = 0xa9059cbb;

    // When you use bytes, bytesNN and string as a paramter type, they are always padded right
    // https://docs.soliditylang.org/en/latest/abi-spec.html#formal-specification-of-the-encoding
    function argumentPadRight(bytes4 someBytes4) public {
        assembly {
            sstore(val.slot, someBytes4)
        }
    }

    // everything else is padded left
    // https://docs.soliditylang.org/en/v0.8.17/abi-spec.html#formal-specification-of-the-encoding
    function argumentPadLeft(uint16 someUint16) public {
        assembly {
            sstore(val.slot, someUint16)
        }
    }

    // But if you reference something directly in assembly, it is always padded left
    function inlineAssemblyPadLeft() public {
        assembly {
            sstore(val.slot, sload(transferSig.slot))
        }
    }
}

contract InlineAssemblyPadLeftTest is Test {
    InlineAssemblyPadLeft example;

    function setUp() public {
        example = new InlineAssemblyPadLeft();
    }

    function test_ArgumentPadRight(bytes4 someBytes4) public {
        example.argumentPadRight(someBytes4);
        assertEq(bytes32(example.val()), bytes32(someBytes4));
    }

    function test_ArgumentPadLeft(uint16 someUint16) public {
        example.argumentPadLeft(someUint16);
        assertEq(example.val(), uint256(someUint16));
    }

    function test_InlineAssemblyPadLeft() public {
        example.inlineAssemblyPadLeft();
        assertEq(example.val(), uint256(uint32(example.transferSig())));
    }
}
