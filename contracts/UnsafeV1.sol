// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract UnsafeV1 is Initializable {
    /**
     * These two state variables below are set when the contract is deployed.
     * So they're doing the same as if these two variables are in constructor.
     * (OpenZeppelin upgradeable tool will give warning)
     */
    // uint256 public val = 123;
    // uint256 public start = block.timestamp;

    // Safe - constants and immutables
    uint256 public constant MY_CONSTANT = 111;

    /// @custom:oz-upgrades-unsafe-allow state-variable-immutable
    uint256 public immutable MY_IMMUTABLE;

    address public owner;
    uint256 public val;
    uint256 public start;

    /**
     * Openzeppelin provides these
     */
    // bool public initialized;
    // modifier notInitialized() {
    //     require(!initialized, "already initialized");
    //     _;
    //     initialized = true;
    // }

    // Unsafe - constructor
    // constructor() {
    //     owner = msg.sender;
    // }

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