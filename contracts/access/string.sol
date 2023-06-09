// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StringStorage {
    string public stringValue;

    // function getString() public view returns(string memory value) {
    //     return stringValue;
    // }

    function set(string memory _value) public {
        stringValue = _value;
    }
}
