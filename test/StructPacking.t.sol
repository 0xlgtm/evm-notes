// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract StructPacking {
    struct ExampleStruct {
        uint64 a;
        uint64 b;
        uint64 c;
        uint64 d;
    }

    ExampleStruct s;
    uint64 a;
    uint64 b;
    uint64 c;
    uint64 d;

    function storeValuesNoStruct(uint256 _a, uint256 _b, uint256 _c, uint256 _d) public {
        a = uint64(_a);
        b = uint64(_b);
        c = uint64(_c);
        d = uint64(_d);
    }

    function storeValuesWithStruct(uint256 _a, uint256 _b, uint256 _c, uint256 _d) public {
        s = ExampleStruct(uint64(_a), uint64(_b), uint64(_c), uint64(_d));
    }
}

contract StructPackingTest is Test {
    StructPacking example;

    function setUp() public {
        example = new StructPacking();
    }

    function test_StoreValuesNoStruct(uint256 _a, uint256 _b, uint256 _c, uint256 _d) public {
        example.storeValuesNoStruct(_a, _b, _c, _d);
    }

    function test_StoreValuesWithStruct(uint256 _a, uint256 _b, uint256 _c, uint256 _d) public {
        example.storeValuesWithStruct(_a, _b, _c, _d);
    }
}
