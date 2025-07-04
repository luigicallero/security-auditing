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

## Minimal Requirements for an Auditing
https://github.com/Cyfrin/security-and-auditing-full-course-s23/blob/main/minimal-onboarding-questions.md

## Usefull Tools
### CLOC - Count lines of code

Installation:
```bash
npm i cloc
```
Execute
```bash
cloc ./src/
```
Expected Output:
```bash
       3 text files.
       3 unique files.                              
       0 files ignored.

github.com/AlDanial/cloc v 2.04  T=0.03 s (92.4 files/s, 5422.6 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Solidity                         3             37             62             77
-------------------------------------------------------------------------------
SUM:                             3             37             62             77
-------------------------------------------------------------------------------
```

### Slither

Slither is a static analysis framework for Solidity that detects vulnerabilities, enforces coding standards, and provides code optimization suggestions.

Installation:
```bash
pip3 install slither-analyzer
```

Basic usage:
```bash
# Analyze a single contract
slither src/Counter.sol

# Analyze entire project
slither .

# Generate detailed report
slither . --print human-summary

# Check for specific vulnerabilities
slither . --detect reentrancy,unchecked-transfer
```

Common flags:
- `--print human-summary`: Human-readable summary
- `--detect`: Specify vulnerability types to check
- `--exclude`: Exclude specific contracts or directories
- `--json`: Output results in JSON format

Slither also offers a way to remove results:
* By adding to the base code //slither-disable-next-line DETECTER_NAME before the issue:
```bash
// slither-disable-next-line arbitrary-send-eth
(bool success,) = feedAddress.call{value: feesToWithdraw} ("")
```
* Check here for more [options](https://github.com/crytic/slither/wiki/Usage)

* Or remove the check of libraries:
```bash
slither . --exclude-dependencies
```

## Generating a Report:

```bash
pandoc report.md -o report.pdf --from markdown --template=eisvogel --listings
```

## Docker Containers

Optional or VM - I will be using a VM