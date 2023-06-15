// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Lottery{
address public manager;
address payable[]public players;
constructor(){
    manager=msg.sender;
}
function Enter()public payable {
   require(msg.value>2*1e16,"Minimum entry fee ") ;//1e16 represents 10^16, so 2 * 1e16 is equivalent to 2 Ether.
   players.push(payable(msg.sender));//The push function is used to add an element to the end of an array in Solidity.
}
function random() private view returns (uint) {
    return uint(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp, players.length)));
}

function Winner()public restricted{
require(players.length>0,"No player in the pool");
uint256 winnerIndex=random()%players.length; 
address payable winner=players[winnerIndex];
players=new address payable[](0);
winner.transfer(address(this).balance);
}
   function getPlayers() public view returns (address payable[] memory) {
        return players;
    }
    
modifier restricted(){
    require(msg.sender==manager,"Access denied");
    _;
}
  function getBalance() public view restricted returns (uint256) {
        return address(this).balance;
    }
}
