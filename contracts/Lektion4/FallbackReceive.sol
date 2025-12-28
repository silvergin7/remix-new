// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract FallbackReceive {
    uint public contractBalance;
    mapping(address => uint) internal _balances;
    bool private _locked;

    event DepositMade(address indexed accountAddress, uint amount);
    event WithdrawalMade(address indexed accountAddress, uint amount);
    event FallbackFunctionCalled(address indexed accountAddress);

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

    fallback() external {
        emit FallbackFunctionCalled(msg.sender);
        revert("The function you tried to call does not exist. Please try again!");
    }

    receive() external payable {
        deposit();
    }

    function deposit() public payable {
        _balances[msg.sender] += msg.value;
        contractBalance += msg.value;

        assert(contractBalance == address(this).balance);

        emit DepositMade(msg.sender, msg.value);
    }

    function withdraw(uint withdrawAmount) public noReentrancy hasSufficientBalance(withdrawAmount) {
        if(withdrawAmount > 1 ether) {
            revert("You cannot withdraw more than 1 ETH at a time");
        }

        _balances[msg.sender] -= withdrawAmount;
        contractBalance -= withdrawAmount;

        (bool success, ) = payable(msg.sender).call{value: withdrawAmount}("");
        require(success, "Transaction Failed");

        assert(contractBalance == address(this).balance);

        emit WithdrawalMade(msg.sender, withdrawAmount);           
    }
}