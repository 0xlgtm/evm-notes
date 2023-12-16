# evm-notes

This repository contains code repro of the issues that I've encountered while diving into the EVM. I've also added a list of useful resources that have helped me on my exploration.

# EVM Behaviour
- [`not` is a bitwise negation](./test/Not.t.sol)
- [Inline assembly will always pad left to 32 bytes](./test/InlineAssemblyPadLeft.t.sol)
- [Solidity packs variables from the right into a single slot](./test/PackRightFirst.t.sol)
- [Solidity type casting](./test/TypeCasting.t.sol)

# Resources
## Assembly How-tos
- [How to return custom errors using assembly?](https://soliditylang.org/blog/2021/04/21/custom-errors/)
- [How to return bytes using assembly?](https://ethereum.stackexchange.com/questions/130072/return-bytes-from-inline-assembly)
- [How are dynamic types encoded?](https://docs.soliditylang.org/en/latest/abi-spec.html#use-of-dynamic-types)

## EVM and Assembly
- [evm.codes](https://evm.codes)
- [Solady](https://github.com/Vectorized/solady/)
- [Noxx3xxon's EVM handbook](https://noxx3xxon.notion.site/noxx3xxon/The-EVM-Handbook-bb38e175cc404111a391907c4975426d)

## Gas Optimization
- [Beskay's Gas Guide](https://github.com/beskay/gas-guide/tree/main)
- [RareSkills' Book of Gas Optimization](https://www.rareskills.io/post/gas-optimization)
- [0xKalzak's Optimization Iceberg](https://snappify.com/view/f9a681c7-834c-467e-b34d-5ad443a893f2)
