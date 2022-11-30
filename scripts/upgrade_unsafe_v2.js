const { ethers, upgrades } = require('hardhat');

const PROXY = '0xa81Ef777305c924fB7bA26B7D5bb990ca8C1D423';

async function main() {
  const UnsafeV2 = await ethers.getContractFactory('UnsafeV2');
  console.log('Upgrading UnsafeV2...');
  await upgrades.upgradeProxy(PROXY, UnsafeV2, {
    constructorArgs: [111],
  });
  console.log('UnsafeV2 upgraded');
}

main();
