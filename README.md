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
