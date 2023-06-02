# solidity
This is the report for learning solidity.
##make an solidity project :an auction contract
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Auction{
    address public auctioneer;
    string public item;
uint256 public highestBid;
    address public highestBidder;
    bool public ended;
    mapping(address=>uint256)public bids;
    event BidPlaced(address bidder,uint256 bidAmount);
    constructor(string memory _item){
 auctioneer=msg.sender;
 item= _item;
    }
    function placeBid()public payable{
        require(!ended,"Action has ended ");
        require(msg.value>highestBid,"Amount is too high");
        if(highestBid!=0){
payable(highestBidder).transfer(highestBid);
        }
       highestBid=msg.value;
        highestBidder=msg.sender;
        bids[msg.sender]=msg.value;
        emit BidPlaced(msg.sender,msg.value);
    }
    function endAuction()public{
        require(msg.sender==auctioneer,"Only auctioneer can end the auction");
        require(!ended,"Auction already ended");
        ended=true;
        payable(auctioneer).transfer(highestBid);
    }
}
