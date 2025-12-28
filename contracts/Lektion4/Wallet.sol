// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract Wallet {
    uint public contractBalance;
    mapping(address => uint) internal _balances;
    bool private _locked;

    modifier noReentrancy() {
        require(!_locked, "Stop making reentrancy calls. Please hold!");
        _locked = true;
        _;
        _locked = false;
    }

    modifier hasSufficientBalance(uint withdrawAmount) {
        require(_balances[msg.sender] >= withdrawAmount, "You have an insufficient balance, please try again!");
        _;
    }

    function deposit() public payable {
        _balances[msg.sender] += msg.value;
        contractBalance += msg.value;

        assert(contractBalance == address(this).balance);
    }

    function withdrawal(uint withdrawAmount) public noReentrancy hasSufficientBalance(withdrawAmount) {
        if(withdrawAmount > 1 ether) {
            revert("You cannot withdraw more than 1 ETH at a time");
        }

        _balances[msg.sender] -= withdrawAmount;
        contractBalance -= withdrawAmount;

        (bool success, ) = payable(msg.sender).call{value: withdrawAmount}("");
        require(success, "Transaction Failed");

        assert(contractBalance == address(this).balance);              
    }
}