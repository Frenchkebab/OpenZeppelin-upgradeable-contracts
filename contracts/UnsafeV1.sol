// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract UnsafeV1 {
    // Unsafe - constructor
    address public owner;

    /**
     * These two state variables below are set when the contract is deployed.
     * So they're doing the same as if these two variables are in constructor.
     * (OpenZeppelin upgradeable tool will give warning)
     */
    // uint256 public val = 123;
    uint256 public start = block.timestamp;

    constructor() {
        owner = msg.sender;
    }
}