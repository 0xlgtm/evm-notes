// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract Mock {
    uint256 public a;

    // When you use bytes, bytesNN and string as a paramter type, they are always padded right
    // https://docs.soliditylang.org/en/v0.8.17/abi-spec.html#formal-specification-of-the-encoding
    function argumentPadRight(bytes4 _bytes) public {
        assembly {
            sstore(0, _bytes)
        }
    }
    
    // everything else is padded left
    // https://docs.soliditylang.org/en/v0.8.17/abi-spec.html#formal-specification-of-the-encoding
    function argumentPadLeft(uint16 _a) public {
        assembly {
            sstore(0, _a)
        }
    }

    // But if you use it directly in assembly, it is always padded left
    function yulPadLeft() public {
        assembly {
            sstore(0, 0xa9059cbb)
        }
    }
}

contract InlineAssemblyPadLeftTest is Test {

    Mock mock;
    // uint256(0xa9059cbb00000000000000000000000000000000000000000000000000000000)
    uint256 b = 76450787359836037641860180984291677749980919077056822294353438043884394381312;

    function setUp() public {
        mock = new Mock();
    }

    function test_ArgumentPadRight(bytes4 _b) public {
        mock.argumentPadRight(_b);
        assertEq(mock.a(), uint256(bytes32(_b)));
    }

    function test_ArgumentPadLeft(uint16 _a) public {
        mock.argumentPadLeft(_a);
        assertEq(mock.a(), _a);
    }

    function test_InlineAssemblyPadLeft() public {
        mock.yulPadLeft();
        assertEq(mock.a(), 0x00000000000000000000000000000000000000000000000000000000a9059cbb);
    }
}
