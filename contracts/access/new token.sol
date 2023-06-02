// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NewToken is ERC20 {
    constructor() ERC20("NewToken", "MTK2") {
    }
    function mintInitialSupply(uint256 initialSupply) external {
    _mint(msg.sender, initialSupply);
}

}
