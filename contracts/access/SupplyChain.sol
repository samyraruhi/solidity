// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    struct Product {
        uint256 productId;
        string name;
        address currentOwner;
    }
    
    mapping(uint256 => Product) private products;
    
    event ProductAdded(uint256 indexed productId, string name, address indexed currentOwner);
    event OwnershipTransferred(uint256 indexed productId, address indexed previousOwner, address indexed newOwner);
    
    uint256 private productIdCounter;
    
    function addProduct(string memory _name) public {
        uint256 newProductId = productIdCounter++;
        products[newProductId] = Product({
            productId: newProductId,
            name: _name,
            currentOwner: msg.sender
        });
        
        emit ProductAdded(newProductId, _name, msg.sender);
    }
    
    function transferOwnership(uint256 _productId, address _newOwner) public {
        require(_newOwner != address(0), "Invalid address");
        require(products[_productId].currentOwner == msg.sender, "Not the current owner");
        
        address previousOwner = products[_productId].currentOwner;
        products[_productId].currentOwner = _newOwner;
        
        emit OwnershipTransferred(_productId, previousOwner, _newOwner);
    }
    
    function getCurrentOwner(uint256 _productId) public view returns (address) {
        return products[_productId].currentOwner;
    }
}
