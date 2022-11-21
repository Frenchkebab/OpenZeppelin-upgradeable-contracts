// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract Box {
    uint256 public val;

    /*
        For upgradeable contracts, state variables inside of implementations are never used
    */
    // constructor(uint _val) {
    //     val = _val;
    // }

    function initialize(uint256 _val) external {
        val = _val;
    }
}