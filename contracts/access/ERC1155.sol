// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract Token1 is ERC1155 {//Token1 is inheriting from ERC1155
    mapping(uint256 => address) public creators;
    mapping(uint256 => uint256) public tokenSupply;

    constructor() ERC1155("") {//with empty string to deploying the token1 contract
        // Mint initial tokens or perform any other setup
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data) public {
        require(creators[id] == address(0), "Token already minted");
        creators[id] = msg.sender;
        _mint(account, id, amount, data);
        tokenSupply[id] += amount;
    }

    function transfer(address from, address to, uint256 id, uint256 amount) public {
        require(balanceOf(from, id) >= amount, "Insufficient balance");
        require(from == msg.sender || isApprovedForAll(from, msg.sender), "Transfer not authorized");
        safeTransferFrom(from, to, id, amount, "");
    }
}
