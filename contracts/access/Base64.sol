// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EvenNumberSum {
    function SumEvenNumbers(uint[] memory numbers) public pure returns (uint) {
        if (numbers.length==0){
            return 0;
        }
       uint sum=0;
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                sum  +=  numbers[i];
            }
        }
        return  sum;
    }
}
