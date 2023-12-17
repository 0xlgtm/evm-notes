# evm-notes

A collection of interesting findings I stumbled upon while exploring the EVM.

# EVM Quirks
- [When you pass in an argument, the argument is padded with 0s on either the left or right (depending on the type) to 32 bytes. If you access some data directly e.g. SLOAD via inline assembly, it will only be padded left.](./test/InlineAssemblyPadLeft.t.sol)
- [When storage variables are automatically packed together in a single storage slot, it always starts from the right.](./test/PackRightFirst.t.sol)
- [When casting to a smaller / larger type, 0s are padded or truncated on either the left or right side depending on the type](./test/TypeCasting.t.sol)

# Unconventional Gas Optimization
- ["public variables are functions"](#)
- ["uint256 parameter types are cheaper because overflow checks not required"](#)
- ["packing into a struct is more expensive than not packing"](#)

# Assembly How-tos
- [How to return custom errors using assembly?](https://soliditylang.org/blog/2021/04/21/custom-errors/)
- [How to return bytes using assembly?](https://ethereum.stackexchange.com/questions/130072/return-bytes-from-inline-assembly)
- [How are dynamic types encoded?](https://docs.soliditylang.org/en/latest/abi-spec.html#use-of-dynamic-types)

# EVM and Assembly resources
- [evm.codes](https://evm.codes)
- [Solady](https://github.com/Vectorized/solady/)
- [Noxx3xxon's EVM handbook](https://noxx3xxon.notion.site/noxx3xxon/The-EVM-Handbook-bb38e175cc404111a391907c4975426d)

# Gas Optimization resources
- [Beskay's Gas Guide](https://github.com/beskay/gas-guide/tree/main)
- [RareSkills' Book of Gas Optimization](https://www.rareskills.io/post/gas-optimization)
- [0xKalzak's Optimization Iceberg](https://snappify.com/view/f9a681c7-834c-467e-b34d-5ad443a893f2)
