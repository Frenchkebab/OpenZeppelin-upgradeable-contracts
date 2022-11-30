// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract UnsafeV2 is Initializable {
    // Safe - constants and immutables
    uint256 public constant MY_CONSTANT = 111;

    /// @custom:oz-upgrades-unsafe-allow state-variable-immutable
    uint256 public immutable MY_IMMUTABLE;

    uint256 public val;
    address public owner;
    uint256 public start;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor (uint256 _x) {
        MY_IMMUTABLE = _x; // part of the code of the contract
    }

    // Initialize - repaces constructor, can only call once
    function initialize(uint256 _val) external initializer {
        owner = msg.sender;
        val = _val;
        start = block.timestamp;
    }
}