// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GoldDinarNFT {
    struct NFT {
        address owner;
        uint256 tokenId;
        string serialNumber;
        string productName;
        uint256 productPrice;
    }

    mapping(uint256 => NFT) public nfts;

    event NFTMinted(address indexed owner, uint256 indexed tokenId, string serialNumber, string productName, uint256 productPrice);
    event NFTTransferred(address indexed from, address indexed to, uint256 indexed tokenId);

    function mintNFT(uint256 tokenId, string memory serialNumber, string memory productName, uint256 productPrice) public {
        require(nfts[tokenId].owner == address(0), "Token already minted");
        
        NFT memory newNFT = NFT(msg.sender, tokenId, serialNumber, productName, productPrice);
        nfts[tokenId] = newNFT;
        
        emit NFTMinted(msg.sender, tokenId, serialNumber, productName, productPrice);
    }
    
    function transferNFT(address to, uint256 tokenId) public {
        require(nfts[tokenId].owner == msg.sender, "Sender is not the owner");
        
        nfts[tokenId].owner = to;
        
        emit NFTTransferred(msg.sender,to,tokenId);
    }
}

