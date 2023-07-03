// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GoldDinarNFT {
    struct NFT {
        address owner;
        uint256 tokenId;
        uint256 productPrice;
        string productDetails;
        string currency;
        string imageUrl;
        string uriPrefix;
        string uriSuffix;
    }

    mapping(uint256 => NFT) public nfts;

    event NFTMinted(
        address indexed owner,
        uint256 indexed tokenId,
        uint256 productPrice,
        string productDetails,
        string currency,
        string imageUrl,
        string uriPrefix,
        string uriSuffix
    );
    event NFTTransferred(address indexed from, address indexed to, uint256 indexed tokenId);

    uint256 public nextTokenId = 1;
    uint256 public minAmount = 10; // Set the minimum amount allowed for the NFT
    uint256 public maxAmount = 1000; // Set the maximum amount allowed for the NFT
    string public uriPrefix; // Set your desired URI prefix
    string public constant symbol = "XAUS";

    constructor(string memory _uriPrefix) {
        uriPrefix = _uriPrefix;
    }

    function mintNFT() public {
        uint256 productPrice = 10; // Set the product price as 10 XAUS tokens
        string memory productDetails = "World's first ever NFT backed by physical gold. XAUS NFTs represent a particular serial number embossed on the physical gold coin along with fungible value in form of physical gold weight equivalent to 10 XAUS tokens (4.25 gms of physical gold weight). XAUS is the first cryptocurrency to receive a Certificate of Sharia Compliance (05-March-2022) from the International Halal Assurance Institute.";
        string memory currency = "ETH/WETH";
        string memory imageUrl = "https://coffee-additional-guanaco-371.mypinata.cloud/ipfs/QmVBNwMYSJaYVzh2Afmri1d2MeoN75awqyL4cL9tZJzZ7D";
        string memory uriSuffix = ".json";

        require(nextTokenId <= maxAmount, "Maximum amount reached");
        uint256 tokenId = nextTokenId;

        NFT memory newNFT = NFT(
            msg.sender,
            tokenId,
            productPrice,
            productDetails,
            currency,
            imageUrl,
            uriPrefix,
            uriSuffix
        );
        nfts[tokenId] = newNFT;

        emit NFTMinted(
            msg.sender,
            tokenId,
            productPrice,
            productDetails,
            currency,
            imageUrl,
            uriPrefix,
            uriSuffix
        );

        nextTokenId++;
    }

    function transferNFT(address to, uint256 tokenId) public {
        require(nfts[tokenId].owner == msg.sender, "Sender is not the owner");

        nfts[tokenId].owner = to;

        emit NFTTransferred(msg.sender, to, tokenId);
    }
}
