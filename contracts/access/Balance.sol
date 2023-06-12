// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalanceTracker {
    mapping(address => uint256) private balances;
    event Transfer(address indexed from, address indexed to, uint256 amount);
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function transfer(address to, uint256 amount) public {
        require(to != address(0), "Invalid recipient");
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);   
    }
}
