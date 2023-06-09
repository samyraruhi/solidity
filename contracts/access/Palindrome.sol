// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract palindromeChecker{
   function Palindrome(string memory _str)public pure returns(bool){
       bytes memory strBytes =bytes( _str);
       uint length =strBytes.length;
       for (uint i=0;i<length;i++ ){
           if(strBytes[i]!=strBytes[length - i -1]){
               return false;
           }
       }
       return true;
   }
}
