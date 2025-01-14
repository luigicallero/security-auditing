### Install and update Foundry
```
foundryup
```
### Other important tools
* Phind - AI searcher or Chatgpt
* Pheerana - Q&A for Web3
* Ethereum stack exchange

### Updating the amount of fuzz test
Use the link in foundry.toml file:
https://github.com/foundry-rs/foundry/blob/master/crates/config/README.md#all-options

look for fuzz parameter, copy paste the stanza into foundry.toml and update the number of "runs":

```
[fuzz]
runs = 600
max_test_rejects = 65536
seed = '0x3e8'
dictionary_weight = 40
include_storage = true
include_push_bytes = true
```

### Checking storage used by variables with forge

```
forge inspect CONTRACT_NAME storage
```

Output - you can see number and number2 but number3 is not stored in the storage, because they are part of the bytecode
```
{
  "storage": [
    {
      "astId": 3,
      "contract": "src/Counter.sol:Counter",
      "label": "number",
      "offset": 0,
      "slot": "0",
      "type": "t_uint256"
    },
    {
      "astId": 5,
      "contract": "src/Counter.sol:Counter",
      "label": "number2",
      "offset": 0,
      "slot": "1",
      "type": "t_uint256"
    }
  ],
  "types": {
    "t_uint256": {
      "encoding": "inplace",
      "label": "uint256",
      "numberOfBytes": "32"
    }
  }
}
```