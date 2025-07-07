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

## Test Quality - Forge Coverage

Forge coverage helps measure how thoroughly your smart contract code is being tested. It analyzes which parts of your code are executed during tests and provides detailed metrics.

### Running Coverage Analysis

Basic coverage check:
```bash
forge coverage
```

Example output:
```bash
+------------------------+----------------+----------------+----------------+----------------+
| File                   | % Lines        | % Statements   | % Branches     | % Functions    |
+------------------------+----------------+----------------+----------------+----------------+
| src/PuppyRaffle.sol    | 92.31% (72/78) | 93.18% (82/88) | 83.33% (30/36) | 100% (12/12)   |
+------------------------+----------------+----------------+----------------+----------------+
```

### Coverage Metrics Explained

- **Lines**: Percentage of code lines executed (92.31%)
- **Statements**: Percentage of code statements run (93.18%)
- **Branches**: Percentage of decision paths taken (83.33%)
- **Functions**: Percentage of functions called (100%)

### Advanced Coverage Commands

Generate HTML report:
```bash
forge coverage --report lcov
genhtml lcov.info -o coverage/
```

Filter specific contracts:
```bash
forge coverage --contracts "src/MyContract.sol"
```

Show uncovered lines:
```bash
forge coverage --report debug
```

### Coverage Best Practices

Target metrics:
- Line/Statement coverage: >90%
- Branch coverage: >85%
- Function coverage: 100%

Focus on testing:
- Fund transfer functions
- Access controls
- State changes
- Error handling

Common coverage gaps:
- Error conditions
- Edge cases
- Multiple modifier combinations
- Complex conditionals

### Coverage Limitations

1. High coverage doesn't guarantee bug-free code:
   - Only shows execution, not correctness
   - May miss edge cases
   - Doesn't verify business logic

2. Coverage blind spots:
   - Unreachable code
   - Emergency functions
   - Assembly code
   - External library code

### CI Integration

Add to your CI pipeline:
```yaml
- name: Coverage Check
  run: forge coverage --min-coverage 90
```

### Troubleshooting Low Coverage

1. Review uncovered code:
   ```bash
   forge coverage --report debug
   ```

2. Common fixes:
   - Add missing test cases
   - Remove dead code
   - Check compiler settings
   - Verify dependencies

### Resources

- [Foundry Coverage Documentation](https://book.getfoundry.sh/reference/forge/forge-coverage)
- [Coverage Best Practices](https://ethereum.org/en/developers/tutorials/solidity-coverage/)

## Generating a Report:

```bash
pandoc report.md -o report.pdf --from markdown --template=eisvogel --listings
```

## Docker Containers

Optional or VM - I will be using a VM