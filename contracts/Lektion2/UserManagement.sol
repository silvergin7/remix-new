// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract UserManagement {
    struct User {
        string name;
        uint8 age;
    }

    mapping(address => User) public users;

    function setUserProfile(string memory userName, uint8 userAge) public {
        users[msg.sender] = User(userName, userAge);
    }
}