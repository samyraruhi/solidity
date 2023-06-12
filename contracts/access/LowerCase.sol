// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Strings {
    function toLowerCase(string memory _str) internal pure returns (string memory) {
        bytes memory strBytes = bytes(_str);
        for (uint256 i = 0; i < strBytes.length; i++) {
            // Uppercase character
            if ((uint8(strBytes[i]) >= 65) && (uint8(strBytes[i]) <= 90)) {
                // Convert to lowercase by adding 32 to the ASCII value
                strBytes[i] = bytes1(uint8(strBytes[i]) + 32);
            }
        }
        return string(strBytes);
    }
}

contract StringToLower {
    using Strings for string;

    function convertToLower(string memory _str) public pure returns (string memory) {
        return _str.toLowerCase();
    }
}
