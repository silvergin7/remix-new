// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract ContractOwnerConstructor {
    address public owner;

    constructor(address contractOwner) {
        // owner = msg.sender;
       owner = contractOwner;
    }
}