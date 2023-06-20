// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library StringUtils {
    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = _numDigits(value);
            string memory buffer = new string(length);
            uint256 ptr;
            assembly {
               ptr := add(buffer, 0x20)
            }
            while (true) {
                ptr--;
                assembly {
                    mstore8(ptr, byte(mod(value, 10), 48))
                }
                value /= 10;
                if (value == 0) break;
            }
            return buffer;
        }
    }

    function _numDigits(uint256 value) private pure returns (uint256) {
        uint256 digits = 0;
        while (value != 0) {
            digits++;
            value /= 10;
        }
        return digits;
    }
}

contract NumberToStringExample {
    using StringUtils for uint256;

    function convertNumberToString(uint256 number) public pure returns (string memory) {
        string memory str = number.toString();
        return str;
    }
}
