// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract Crowdfunding {
    address public owner;
    uint public goal;
    uint public deadline;
    bool public goalReached;
    uint public currentBalance;

    mapping(address => uint) public donations;

    constructor(address contractOwner, uint fundingGoal, uint durationInDays) {
        owner = contractOwner;
        goal = fundingGoal;
        deadline = block.timestamp + (durationInDays * 1 days);
        goalReached = false;
        currentBalance = 0;
    }

    function contribute() public payable {
        require(block.timestamp < deadline, "The deadline has passed");

        donations[msg.sender] += msg.value;
        currentBalance += msg.value;

        if(currentBalance >= goal) {
            goalReached = true;
        }
    }

    function withdrawFunds() public {
        if(goalReached) {
            require(msg.sender == owner, "You are not the owner and cannot withdraw the fund.");

            uint amountToTransfer = currentBalance;
            currentBalance = 0;

            payable(owner).transfer(amountToTransfer);
        } else {
            uint amountToTransfer = donations[msg.sender];
            donations[msg.sender] = 0;
            currentBalance -= amountToTransfer;
            
            (bool success, ) = payable(msg.sender).call {value: amountToTransfer}("");
            require(success, "Transaction failed");
        }
    }
}