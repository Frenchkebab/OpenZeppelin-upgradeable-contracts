const { ethers, upgrades } = require('hardhat');

const PROXY = '0xa81Ef777305c924fB7bA26B7D5bb990ca8C1D423';

async function main() {
  const BoxV2 = await ethers.getContractFactory('BoxV2');
  await upgrades.upgradeProxy(PROXY, BoxV2);
  console.log('Box upgraded');
}

main();
