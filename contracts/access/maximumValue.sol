// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MaximumValue {
    function getMax(uint256[] memory numbers) public pure returns (uint256) {
        require(numbers.length > 0, "Array must have at least one element");

        uint256 largest = numbers[0];

        for (uint256 i = 1; i < numbers.length; i++) {
            if (numbers[i] > largest) {
                largest = numbers[i];
            }
        }

        return largest;
    }
}
