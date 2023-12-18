// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract OverflowCheckOnParams {
    uint64 a;
    uint64 b;
    uint64 c;
    uint64 d;

    // + 22 gas
    function storeUint64Params(uint64 _a, uint64 _b, uint64 _c, uint64 _d) public {
        a = _a;
        b = _b;
        c = _c;
        d = _d;
    }

    // + 44 gas
    function storeUint256Params(uint256 _a, uint256 _b, uint256 _c, uint256 _d) public {
        a = uint64(_a);
        b = uint64(_b);
        c = uint64(_c);
        d = uint64(_d);
    }
}

contract OverflowCheckOnParamsTest is Test {
    OverflowCheckOnParams example;

    function setUp() public {
        example = new OverflowCheckOnParams();
    }

    function test_StoreUint64Params(uint64 _a, uint64 _b, uint64 _c, uint64 _d) public {
        example.storeUint64Params(_a, _b, _c, _d);
    }

    function test_StoreUint256Params(uint256 _a, uint256 _b, uint256 _c, uint256 _d) public {
        example.storeUint256Params(_a, _b, _c, _d);
    }
}
