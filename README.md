# evm-notes

A collection of interesting findings I stumbled upon while exploring the EVM.

# EVM Quirks
- [When you pass in an argument, the argument is padded with 0s on either the left or right (depending on the type) to 32 bytes. If you access some data directly e.g. SLOAD via inline assembly, it will only be padded left.](./test/InlineAssemblyPadLeft.t.sol)
- [When storage variables are automatically packed together in a single storage slot, it always starts from the right.](./test/PackRightFirst.t.sol)
- [When casting to a smaller / larger type, 0s are padded or truncated on either the left or right side depending on the type](./test/TypeCasting.t.sol)

# Unconventional Gas Optimization
- [`uint256` parameter type is cheaper than `uint64`](./test/OverflowCheckOnParams.t.sol) <sub>[1](#1)</sub>
- [packing into a struct is more expensive than not packing](./test/StructPacking.t.sol) <sub>[2](#2)</sub>

# Assembly How-Tos
- [How to return custom errors using assembly?](https://soliditylang.org/blog/2021/04/21/custom-errors/)
- [How to return bytes using assembly?](https://ethereum.stackexchange.com/questions/130072/return-bytes-from-inline-assembly)
- [How are dynamic types encoded?](https://docs.soliditylang.org/en/latest/abi-spec.html#use-of-dynamic-types)
- [How to represent signed integers in binary?](https://twitter.com/0xlgtm/status/1742369037706031215)
- [How do calldata arrays save gas?](https://twitter.com/0xlgtm/status/1744209267090198564)

# EVM and Assembly Resources
- [evm.codes](https://evm.codes)
- [Solady](https://github.com/Vectorized/solady/)
- [Noxx3xxon's EVM handbook](https://noxx3xxon.notion.site/noxx3xxon/The-EVM-Handbook-bb38e175cc404111a391907c4975426d)

# Gas Optimization Resources
- [Beskay's Gas Guide](https://github.com/beskay/gas-guide/tree/main)
- [RareSkills' Book of Gas Optimization](https://www.rareskills.io/post/gas-optimization)
- [0xKalzak's Optimization Iceberg](https://snappify.com/view/f9a681c7-834c-467e-b34d-5ad443a893f2)

# Explainer Threads
1. <a id="1"></a> https://twitter.com/0xlgtm/status/1736345019660001495
2. <a id="2"></a> https://twitter.com/0xlgtm/status/1736638254424981951
