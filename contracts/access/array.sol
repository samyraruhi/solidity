// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
contract Array{
    //declaring the state variables
    uint[10]data1;
//Defining function to add
//values to an array
function array_example()public returns(int[9]memory,uint[10]memory){
int[9]memory data=   [int(9), -63, 77, -28, 90,80,-27,18,-10]; 
data1=[uint(10),20,30,40,50,60,70,80,90,100];
return(data,data1);
}

}
