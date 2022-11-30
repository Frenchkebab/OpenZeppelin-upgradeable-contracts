# how to set up

## Install

1. `git clone https://github.com/Frenchkebab/OpenZeppelin-upgradeable-contracts.git`

2. `npm install`

3. `touch .env`

4. Fill in apis / private key in `.env` file. You can choose either **Goerli Testnet** or **Mumbai Testnet**  


# 1. Simple Upgrade with hardhat

## 1) Deploy upgradeable contract

### Using Goerli Testnet

`npx harhdat run scripts/deploy_box_v1.js --network goerli`  

### Using Mumbai Testnet

`npx hardhat run scripts/deploy_box_v1.js --network mumbai`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract Box {
    uint256 public val;

    function initialize(uint256 _val) external {
        val = _val;
    }
}

```  

You deploy 3 contracts:

1. `Box` (**Logic Contract**)
2. `TransparentUpgradeableProxy` (**Proxy Contract**)
3. `ProxyAdmin` (**Proxy Admin Contract**)

If you search with deployer's address in goerli etherscan or mumbai polygonscan after running the script,  
you will see 3 transactions deploying each of these 3 contracts.


You use logic(implementation) of **Box** contract.  

`scripts/deploy_box_v1.js`
```javascript
async function main() {
  const Box = await ethers.getContractFactory('Box');
  console.log('Deploying Box...');

  const box = await upgrades.deployProxy(Box, [42], {
    initializer: 'initialize',
  });
  
  await box.deployed();
  console.log('Box deployed to:', box.address);
}
```

You can see that it calls `initialize` function as an **initializer**,
passing `42` to the parameter `_val`.

This works just like a constructor function, thus `val` stores `42`.  
(Of course this uses `Proxy` contract's storage)  

If you go to **Proxy** contract onn **etherscan** or **polygonscan**,  
click `More Options` > `Is this a proxy?` > `verify`.

Now you will be able to read the storage variable `val`

## 2) Upgrade Logic Contract to BoxV2

### Using Goerli Testnet

`npx harhdat run scripts/upgrade_box_v2.js --network goerli`  

### Using Mumbai Testnet

`npx hardhat run scripts/upgrade_box_v2.js --network mumbai`

This updates the **Logic Contract** from `Box` to `BoxV2`.

Verify again just like you previously did, and you will be able to call `inc()` function.

After calling `inc()`, you can see `val` is updated from `42` to `43`.

# 2. Unsafe Code 

## 1. Do not use `constructor`

### Use `initialize` function instead

You shouldn't use constructor to initalize storage variables when deploying upgradeable contract.

You must use `initialize` function instead.

However in `UnsafeV1.sol`, it only initalizes `immutable` variable which just becomes part of the code of the contract.

You can use both `constructor` and `immutable` variable by adding each of these comments above each line.

* `/// @custom:oz-upgrades-unsafe-allow constructor`

* `/// @custom:oz-upgrades-unsafe-allow state-variable-immutable`

(Check out openzeppelin doccument: https://docs.openzeppelin.com/upgrades-plugins/1.x/faq)

### run scripts

`npx hardhat run scripts/upgrade_box_v2.js --network mumbai`

or

`npx hardhat run scripts/upgrade_box_v2.js --network goerli`
## 2. Do not reorder storage variables

Code in `UnsafeV2` contract is basically all same as `UnsafeV1`.

Only the order of two state variables `owner` and `val` differs from `UnsafeV1`.  

In the original contracct, sotrage variable `owner` was at **slot 0** and `val` was at **slot 1**.  

And in `UnsafeV2` contract, their order changed.  

So if you try to update `val`'s value via `UnsafeV2`, value of `owner`in **Proxy** contract will be changed.

### run script

`npx hardhat run scripts/upgrade_unsafe_v2.js --network goerli`

or

`npxhardhat run scripts/upgrade_unsafe_v2.js --network mumbai`

### result

```
Error: New storage layout is incompatible
```

OpenZeppelin upgradeable tool throws error you if you changed the order of storage variables.


### note
Adding new storage variables after **original storage variables** is totally fine.


## 3. Do not use selfdestruct

If you run `selfdestruct` operation from the **Logic** contract, **Proxy** contract can no longer use it's implementation.
