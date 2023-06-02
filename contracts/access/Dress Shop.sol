// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DressShop {
    struct Dress {
        uint256 price;
        uint256 quantity;
    }
    
    mapping(uint256 => Dress) public dresses;
    address public owner;
    
    event DressPurchased(uint256 dressId, uint256 quantity);
    
    constructor() {
        owner = msg.sender;
    }
    
    function addDress(uint256 dressId, uint256 price, uint256 quantity) public {
        require(msg.sender == owner, "Only the owner can add dresses");
        require(dresses[dressId].price == 0, "Dress with the same ID already exists");
        
        dresses[dressId] = Dress(price, quantity);
    }
    
    function purchaseDress(uint256 dressId, uint256 quantity) public payable {
        Dress storage dress = dresses[dressId];
        
        require(dress.price > 0, "Dress does not exist");
        require(dress.quantity >= quantity, "Insufficient quantity available");
        require(msg.value == dress.price * quantity, "Incorrect payment amount");
        
        dress.quantity -= quantity;
        
        emit DressPurchased(dressId, quantity);
    }
    
    function withdrawFunds() public {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        
        payable(owner).transfer(address(this).balance);
    }
}
