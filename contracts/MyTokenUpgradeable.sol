// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyTokenUpgradeable is Initializable, OwnableUpgradeable, ERC20Upgradeable  {
    // constructor() ERC20Upgradeable("MyToken", "MY") {
    // }

    function initialize() external initializer {
        __ERC20_init("MyToken", "MYT");
        __Ownable_init();
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}