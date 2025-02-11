Following along with Patric C in Cyfrin:
[Cyfrin Security and Auditing Full Course](https://github.com/Cyfrin/security-and-auditing-full-course-s23)

Encoding Section comes from this repo:
https://github.com/PatrickAlphaC/hardhat-nft-fcc/blob/main/contracts/sublesson/Encoding.sol

SelfDestruct can be used to exploit a smart contract that has not receive or fallback functions:
https://www.cyfrin.io/glossary/self-destruct-hack-solidity-code-example

## Fork a blockchain
```bash
forge test --fork-url $MAINNET_ALCHEMY_URL
```

Or you can add it to the test contract:
```bash
foundry.toml:
[rpc_endpoints]
mainnet = "{MAINNET_ALCHEMY_URL}"
```
```solidity
function setUp(){
    vm.createSelectFork({blockNumber: 0, urlOrAlias: "mainnet"});
}
```

## Auditing a smart Contract:
The client has only provided this link to Etherscan:

https://sepolia.etherscan.io/address/0x2ecf6ad327776bf966893c96efb24c9747f6694b

Issue #1 - We should have the test suit / github repo, not available on the verified contract

Where to start?
Use the RekTest: this codebase does not pass the Rektest
https://blog.trailofbits.com/2023/08/14/can-you-pass-the-rekt-test/

Issue #2 - No documentation available. Answer to all questions in RekTest are answered with No

If documentation is not provided, audit / security research can NOT be conducted.