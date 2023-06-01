// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinMarketplace {
    struct Coin {
        uint256 coinId;
        string name;
        uint256 price;
        address payable seller;
        bool isSold;
    }

    mapping(uint256 => Coin) public coins;
    uint256 public coinCount;

    event CoinAdded(uint256 indexed coinId, string name, uint256 price, address indexed seller);
    event CoinSold(uint256 indexed  coinId, address indexed buyer, uint256 price);

    constructor() {}

    function addCoin(string memory name, uint256 price) public {
        coinCount++;

        coins[coinCount] = Coin(coinCount, name, price, payable(msg.sender), false);
        emit CoinAdded(coinCount, name, price, msg.sender);
    }

    function buyCoin(uint256 coinId) public payable {
        require(coinId <= coinCount, "Invalid coin ID");
        Coin storage coin = coins[coinId];
        require(!coin.isSold, "coin has already been sold");
        require(msg.value >= coin.price, "Insufficient funds");

        coin.isSold = true;
       coin.seller.transfer(coin.price);

        emit CoinSold(coinId, msg.sender, coin.price);
    }
}
