// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract AccessControl {
    mapping(address => bool) public admins;
    mapping(address => bool) public supporters;
    mapping(address => bool) public members;
    
    constructor() {
        admins[msg.sender] = true;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender], "You are not an admin and cannot call this function!");
        _;
    }

    function assignRole(address account) public onlyAdmin {
        admins[account] = true;
    }

    function assignRole(address account, string memory role) public onlyAdmin {
        if (keccak256(bytes(role)) == keccak256("Supporter")) {
            supporters[account] = true;
        } else if (keccak256(bytes(role)) == keccak256("Member")) {
            members[account] = true;
        } else {
            revert("Role does not exist. Please try again!");
        }
    }
}