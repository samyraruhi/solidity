// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrimeNumberSum {
    
    function isPrime(uint number) internal pure returns (bool) {
        if (number <= 1) {
            return false;
        }
        for (uint i = 2; i<= number; i++) {
            if (number % i == 0) {
                return false;
            }
        }
        return true;
    }
    
    function calculatePrimeSum(uint limit) public pure returns (uint) {
        uint sum = 0;
        for (uint i = 2; i <= limit; i++) {
            if (isPrime(i)) {
                sum += i;
            }
        }
        return sum;
    }
}
