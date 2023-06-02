// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Owned {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    function transferOwnership(address newOwner)public onlyOwner{
        require(newOwner!=address(0),"Invalid address");
        emit OwnershipTransferred(owner,newOwner);
       owner=newOwner;
    }
}
    contract MyContract is Owned{
        uint256 private value;
        mapping(address=>bool)private authorized;
        event ValueChanged(address indexed author,uint256 newValue);
        event AuthorizationUpdated(address indexed authorizedAddress,bool isAuthorized);
        constructor(){
            authorized[owner]=true;
        }
modifier onlyAuthorized(){
    require(authorized[msg.sender],"not authorized can call this function");
        _; 
}
   function setValue(uint256 newValue)public onlyAuthorized{
    value=newValue;
    emit ValueChanged(msg.sender,newValue);
}
function getValue()public view returns(uint256){
    return value;
}
function addAuthorized(address newAuthorized)public onlyOwner{
    require(newAuthorized!=address(0),"invalid address");
    authorized[newAuthorized]=true;
    emit AuthorizationUpdated(newAuthorized,true);//The emit keyword is used to invoke an event and pass the event data

}
 function removeAuthorized(address existingAuthorized) public onlyOwner {
        require(existingAuthorized != address(0), "Invalid address");
        require(existingAuthorized != owner, "Owner cannot be removed from authorized");
        authorized[existingAuthorized] = false;
        emit AuthorizationUpdated(existingAuthorized, false);
    }
 
}
   
