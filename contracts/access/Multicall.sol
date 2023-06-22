// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Multicall {
    function multicall(bytes[] calldata data) external returns (bytes[] memory results) {
        results = new bytes[](data.length);
        for (uint256 i = 0; i < data.length; i++) {
            (bool success, bytes memory result) = address(this).delegatecall(data[i]);//address(this).delegatecall(data[i]) is used to perform a delegate call to an external contract using the delegatecall
            if (success) {
                results[i] = result;//loop
            } else {
                results[i] = revertReason(result);
            }
        }
        return results;
    }

    function revertReason(bytes memory data) internal pure returns (bytes memory) {
        if (data.length < 68) {
            return "Call failed";
        }
        assembly {
            data := add(data, 0x04)
        }
        return data;
    }

    function getAddressBalance(address[] calldata addresses) external view returns (uint256[] memory balances) {
        balances = new uint256[](addresses.length);
        for (uint256 i = 0; i < addresses.length; i++) {
            balances[i] = addresses[i].balance;
        }
        return balances;
    }
}
