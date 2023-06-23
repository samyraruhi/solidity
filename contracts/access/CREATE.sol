// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// OpenZeppelin Contracts (last updated v4.9.0) (utils/Create2.sol)
library Create2 {
    // Helper functions from the Create2 library...
    // (Include the Create2 library code here)
}

contract ContractFactory {
    struct DeployedContract {
        address deployer;
        address contractAddress;
        bytes32 salt;
    }

    mapping(bytes32 => DeployedContract) public deployedContracts;

    event ContractDeployed(address indexed deployer, address indexed contractAddress, bytes32 salt);

    function deployContract(uint256 amount, bytes32 salt, bytes memory bytecode) public payable returns (address) {
        require(msg.value >= amount, "Insufficient balance for deployment");

        address contractAddress;
        assembly {
            contractAddress := create2(amount, add(bytecode, 0x20), mload(bytecode), salt)
        }
        require(contractAddress != address(0), "fail to deploy contract");

        deployedContracts[salt] = DeployedContract(msg.sender, contractAddress, salt);
        emit ContractDeployed(msg.sender, contractAddress, salt);
        return contractAddress;
    }

    function getDeployedContract(bytes32 salt) public view returns (address) {
        return deployedContracts[salt].contractAddress;
    }
}
