// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract MyContract is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");//keccak256 function is a cryptographic hash function that is often used to generate unique identifiers for various purposes, such as defining roles and permissions in access control systems.
bytes32 public constant USER_ROLE = keccak256("USER_ROLE");
    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    function adminOnlyFunction() external view onlyRole(ADMIN_ROLE) {
        // Perform admin-only actions
    }
    function userOnlyFunction() external view onlyRole(USER_ROLE) {
        // Perform USER-only actions
    }
}
