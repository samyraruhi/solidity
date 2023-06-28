// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract UniqueValuesContract {
    //This check is necessary to handle the case when the array is empty and provide a meaningful result.
    function getUniqueValues(uint256[] memory input) public pure returns (uint256[] memory) {
        if (input.length == 0) {
            return new uint256[](0);
        }

        uint256[] memory uniqueValues = new uint256[](input.length);
        uint256 uniqueCount = 0;

        for (uint256 i = 0; i < input.length; i++) {
            bool isUnique = true;
            for (uint256 j = 0; j < uniqueCount; j++) {
                if (uniqueValues[j] == input[i]) {
                    isUnique = false;
                    break;
                }
            }

            if (isUnique) {
                uniqueValues[uniqueCount] = input[i];
                uniqueCount++;
            }
        }

        // Trim the array to remove any unused elements
        uint256[] memory result = new uint256[](uniqueCount);
        for (uint256 i = 0; i < uniqueCount; i++) {
            result[i] = uniqueValues[i];
        }

        return result;
    }

    function unsafeAccess(address[] storage arr, uint256 pos) internal view returns (address) {
        require(pos < arr.length, "Index out of range");
        return arr[pos];
    }
}
