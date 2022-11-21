require('@nomiclabs/hardhat-waffle');
require('@nomiclabs/hardhat-ethers');
require('@openzeppelin/hardhat-upgrades');
require('nomiclabs/hardhat-etherscan');
require('@nomicfoundation/hardhat-toolbox');

require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: '0.8.16',
  networks: {
    goerli: {
      url: process.env.GOERLI_API,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan: {
    api: process.env.ETHERSCAN_API_KEY,
  },
};
