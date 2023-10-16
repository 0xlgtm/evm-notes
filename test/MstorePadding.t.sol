// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

contract Mock {
    uint256 public a;

    function storeIncomplete() public {
        assembly {
            mstore(0, 0xa9059cbb)
            sstore(0, mload(0)) // function selector for transfer
        }
    }

    function storeComplete() public {
        assembly{
            mstore(0, 0xa9059cbb00000000000000000000000000000000000000000000000000000000)
            sstore(0, mload(0))
        }
    }
}

contract MstorePaddingTest is Test {

    Mock mock;
    // uint256(0xa9059cbb00000000000000000000000000000000000000000000000000000000)
    uint256 b = 76450787359836037641860180984291677749980919077056822294353438043884394381312;

    function setUp() public {
        mock = new Mock();
    }

    function test_storeIncomplete() public {
        // Let's say hypothetically you wanted to store the function selector to execute some code.
        // However when you call mstore(0, 0xa9059cbb), the mstore opcode is storing 32 bytes but 
        // the selector only has 4 bytes so the compiler will automatically pad 0s on the left 
        // i.e. you're storing 0x00000000000000000000000000000000000000000000000000000000a9059cbb
        mock.storeIncomplete();
        assertNotEq(mock.a(), b);
        assertEq(mock.a(), 0x00000000000000000000000000000000000000000000000000000000a9059cbb);
    }

    function test_storeComplete() public {
        // In order to store it properly, you need to manually pad the 0s on the right
        mock.storeComplete();
        assertEq(mock.a(), b);
    }

    
}
