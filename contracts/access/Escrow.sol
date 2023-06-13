// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
address payable public sender;
address payable public recipient;
uint public startTime;
uint public endTime;
uint public amount;
bool public released;
constructor()payable {
sender=payable (msg.sender);
amount=msg.value;
}
function deposit(address payable _recipient,uint _duration)public payable{
    require(msg.sender==sender);//only sender can deposit
    require( _duration>0);//duration must be positive
    recipient=  _recipient;
    startTime=block.timestamp;
    endTime=startTime+ _duration;
    amount+=msg.value;

}
function withdraw()public{
     require(msg.sender==sender);//only sender can withdraw
     require(block.timestamp >=endTime);
     require(!released);
     sender.transfer(amount);
     released=true;


}
function claim()public{
    require(msg.sender==recipient); // Only recipient can claim
     require(block.timestamp >=endTime);
     require(!released);
    recipient.transfer(amount);
     released=true;

}

}







    
