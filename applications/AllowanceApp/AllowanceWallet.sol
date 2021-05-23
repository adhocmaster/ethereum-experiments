pragma solidity ^0.6.2;

import "./Owner.sol";

contract AllowanceWallet is Owner{
    
    struct Payment {
        uint amount;
        uint datePaid;
    }
    
    struct Receiver {
        uint allowance;
        uint totalPaid;
        uint numPayments;
        mapping(uint => Payment) payments;
    }
    
    mapping (address => Receiver) public receivers;
    
    event LogUpdateAllowance(address receiverAddress, uint amount);
    
    
    function updateAllowanceDirectlyToStorage(address receiverAddress, uint amount) public ownerOnly {
        
        
        // 27290 gas (slower than updateAllowanceUsingStorage) , 25042 gas without log (fastest)
        receivers[receiverAddress].allowance = amount;
        // emit LogUpdateAllowance(receiverAddress, receivers[receiverAddress].allowance);
        
        // 28681 gas 
        uint a = receivers[receiverAddress].allowance;
        a += receivers[receiverAddress].allowance;
        a += receivers[receiverAddress].allowance;
        a += receivers[receiverAddress].allowance;
        
        
    }
    function updateAllowanceUsingMemory(address receiverAddress, uint amount) public ownerOnly {
        
   
        // 30760 gas , 29402 gas without log
        Receiver memory account = receivers[receiverAddress];
        account.allowance = amount;
        receivers[receiverAddress] = account; // new object
        // emit LogUpdateAllowance(receiverAddress, account.allowance);
        
        
    }
    
    function updateAllowanceUsingStorage(address receiverAddress, uint amount) public ownerOnly {
        
        
        // 27235 gas, 25077 gas wihout log
        Receiver storage account = receivers[receiverAddress];
        account.allowance = amount;
        uint a = account.allowance;
        
        // 28356 gas, lower than updateAllowanceDirectlyToStorage
        a += account.allowance;
        a += account.allowance;
        a += account.allowance;
        
        // emit LogUpdateAllowance(receiverAddress, account.allowance);
        
        // 32192 gas
        // Receiver storage account = receivers[receiverAddress];
        // account.allowance = amount;
        // receivers[receiverAddress] = account; // writing the same object to its place!!!
        // emit LogUpdateAllowance(receiverAddress, account.allowance);
        
        
    }
    
    function allowance(address receiverAddress) public view returns(uint) {
        return receivers[receiverAddress].allowance;
    }
    
    receive() external payable {
        
    }
    
    function withdraw(uint amount) external  {
        // # first check, owner balance
        require(address(this).balance < amount, "Insufficient owner funds");
        
        address receiverAddress = msg.sender;
        Receiver storage account = receivers[receiverAddress];
        
        // # second check, receiver availableAllowance
        require(account.allowance  >= account.totalPaid, "Allowance negative or zero");
        uint availableAllowance = account.allowance - account.totalPaid;
        require(availableAllowance >= amount, "Allowance Insufficient");
        
        Payment memory p = Payment(amount, now);
        createPayment(account, p);
        
        
    }
    
    function createPayment(Receiver storage account, Payment memory payment) internal {
        
        account.payments[account.numPayments] = payment;
        account.numPayments++;
        account.totalPaid -= payment.amount;
        
        
    }
    
}