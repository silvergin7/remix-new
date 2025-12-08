// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract Counter {
    // State variabel
    uint public count = 0;

    function incrementCount() public {
        // count = count + 1;
        count++;
        // count += 1;
    }
}