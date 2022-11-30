const { ethers, upgrades } = require('hardhat');

async function main() {
  const UnsafeV1 = await ethers.getContractFactory('UnsafeV1');
  console.log('Deploying UnsafeV1...');
  const unsafeV1 = await upgrades.deployProxy(UnsafeV1, [444], {
    constructorArgs: [999],
    initializer: 'initialize',
  });
  await unsafeV1.deployed();

  console.log('UnsafeV1 deployed to:', unsafeV1.address);
}

main();
