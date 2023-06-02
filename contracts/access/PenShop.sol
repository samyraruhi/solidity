// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract PenShop{
    struct Pen{
        uint256 price;
        uint256 quantity;
    }
    mapping(uint256 =>Pen)public pens;
address public shopOwner;
event PenPurchased(address  indexed buyer,uint256 penId,uint256 quantity);
constructor(){
 
   shopOwner=msg.sender;
}
function addPen(uint256 penId,uint256 price,uint256 quantity)public{
require(pens[penId].price==0,"Pen with the same id already exists");
pens[penId]=Pen(price,quantity);
}
function buyPen(uint256 penId,uint256 quantity) public payable{
require(pens[penId].price>0,"Pen with the same Id already exists");
require(pens[penId].quantity>=quantity,"Insufficient pen avaliable");
require(msg.value==pens[penId].price*quantity,"Insufficient payment amount");
pens[penId].quantity-=quantity;
emit PenPurchased(msg.sender, penId, quantity);
payable(shopOwner).transfer(msg.value);
}
}
