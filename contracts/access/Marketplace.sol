// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    address public owner;
    uint public listingCount;

    struct Listing {
        uint id;
        string name;
        string description;
        uint price;
        address seller;
        bool isSold;
    }

    mapping (uint => Listing) public listings;

    event CreateListing(uint id, string name, uint price, address seller);
    event PurchaseItem(uint id, string name, uint price, address buyer);

    constructor() {
        owner = msg.sender;
        listingCount = 0;
    }

    function createListing(string memory _name, string memory _description, uint _price) public {
        require(msg.sender == owner);
        listings[listingCount] = Listing(listingCount, _name, _description, _price, msg.sender, false);
        emit CreateListing(listingCount, _name, _price, msg.sender);
        listingCount++;
    }

    function purchaseItem(uint _id) public payable {
        Listing memory listing = listings[_id];
        require(msg.value == listing.price);
        require(!listing.isSold);//not already sold.
        listing.isSold = true;
        listings[_id] = listing;
        emit PurchaseItem(_id, listing.name, listing.price, msg.sender);
        payable(listing.seller).transfer(msg.value);
    }

    function availableListings() public view returns (Listing[] memory) {
        uint count = 0;
        for (uint i = 0; i < listingCount; i++) {
            if(!listings[i].isSold) {
                count++;
            }
        }
        Listing[] memory result = new Listing[](count);
        uint j = 0;
        for (uint i = 0; i < listingCount; i++) {
            if(!listings[i].isSold) {
                result[j] = listings[i];
                j++;
            }
        }
        return result;
    }
}
