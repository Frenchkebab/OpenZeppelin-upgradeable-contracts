async function forceImport(
  address: '0xBeFaE60652237dAf9bce65f04958377750840f80',
  deployedImpl: ethers.getContractFactory('Box'),
  opts?: {
    kind?: 'uups' | 'transparent' | 'beacon',
  },
);

forceImport();