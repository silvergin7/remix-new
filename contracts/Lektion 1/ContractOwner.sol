// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract ContractOwner {
    address public owner = msg.sender;

    function updateOwner(address newOwner) public {
        require(msg.sender == owner, "Only the current owner can call this function");
        owner = newOwner;
    }
}