// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Crowdfunding {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public shares;
    uint256 public totalShares;
    uint256 public totalFunds;
    event FundTransfer(address backer, uint256 amount, bool isContribution);
    event ShareTransfer(address backer, uint256 shares);

    function contribute() public payable {
        require(msg.value > 0, "Contribution amount must be greater than zero");
        
        balances[msg.sender] += msg.value;
        totalFunds += msg.value;
        
        emit FundTransfer(msg.sender, msg.value, true);
    }
    
    function getShare() public {
        require(balances[msg.sender] > 0, "You have no funds to share");
        
        uint256 userShares = (balances[msg.sender] * totalShares) / totalFunds;
        
        shares[msg.sender] += userShares;
        totalShares += userShares;
        
        balances[msg.sender] = 0;
        
        emit ShareTransfer(msg.sender, userShares);
    }
    
    function withdraw() public {
        require(shares[msg.sender] > 0, "You have no shares to withdraw");
        
        uint256 amount = (totalFunds * shares[msg.sender]) / totalShares;
        
        shares[msg.sender] = 0;
        totalShares -= shares[msg.sender];
        
        payable(msg.sender).transfer(amount);
        
        emit FundTransfer(msg.sender, amount, false);
    }
}


