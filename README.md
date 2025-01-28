Following along with Patric C in Cyfrin:

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