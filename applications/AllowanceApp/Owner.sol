pragma solidity ^0.6.2;


contract Owner {
    
    address payable owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier ownerOnly() {
        
        require(msg.sender == owner, "You are not the owner!");
        _;
        
    }
}