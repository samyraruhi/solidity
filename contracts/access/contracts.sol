// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/utils/Context.sol";

contract AccessControl is Context {
    address private owner;
    mapping(address => bool) private authorizedUsers;

    constructor() {
        owner = _msgSender();
    }

    modifier onlyOwner() {
        require(_msgSender() == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyAuthorized() {
        require(authorizedUsers[_msgSender()], "Only authorized users can call this function");
        _;
    }

    function grantAccess(address user) public onlyOwner {
        authorizedUsers[user] = true;
    }

    function revokeAccess(address user) public onlyOwner {
        authorizedUsers[user] = false;
    }

    function action() public onlyAuthorized view returns (string memory) {
        return "You have the access to perform this action";
    }
}
