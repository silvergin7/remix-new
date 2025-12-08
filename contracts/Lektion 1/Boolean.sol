// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract Boolean {
    // State variabel av typen boolean
    bool public isActive = false;

    function setState(bool newState) public {
        isActive = newState;
    }
}