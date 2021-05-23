Classes have high gas costs. Use structs as much as possible
Assert consumes all the gas. Revert returns unused gas.
Assert to validate invariants, require to user input.
Revert and require are the same. Use require most of the time.
Fall back functions in > 0.6 has been split into two functions: fallback() external payable and receive() external payable. Fallback is not called if receive is available.
View functions do not change state
Pure functions do not access storage variables, or states.
Public private external internal functions
3 ways to receive funds in a SC even when it is not receiving (won’t throw any exception):
Destroying another child SC 
Miner reward
Sent to the SC address before its deployment.
This is why you should never match balance received with total balance.
Preventing accidental wrong function call:
require(msg.data.length == 0) in fallback. But this is error prone.
Modifiers are like decorators or middleware!
In case of inheritance, only one contract is deployed. 
Real blockchains do not return values from functions to outside to the transaction creator if it’s not a view function? - solution: events.
Side chain storage?
Events instead of return values
Event logs cannot be accessed inside solidity contracts?
Events
Return values
Data store
Trigger
Events are cheap
Event arguments marked as indexed can be searched for (underlying data structure?)
Virtual or interface for overriding
Multiple base class order
Super function calls depend on the inheritance order, not the override order!!!!!!!!!!!!!!!

Before 0.6, we could increase/decrease the length of arrays. But now it has become like a stack?????
Public vs external: external uses less gas? External functions can read data from  calldata, but public functions need to copy the input data into memory (it’s local scope). This is because public methods can be called internally. So, call data is not always available. (https://ethereum.stackexchange.com/questions/19380/external-vs-public-best-practices). Never use public, use external, internal, private.
Calldata, memory, and storage. calldata is allocated by the caller, while memory is allocated by the callee.
Transaction cost includes execution cost.
Read-only function calls are not always free. When they are called within a state-changing function, they have added cost. (https://blog.b9lab.com/calls-vs-transactions-in-ethereum-smart-contracts-62d6b17d0bc2)
# Modifying states:
1. Changing state variables (in storage, not memory)
2. Emitting events
3. Creating variables in memory? - no
4. Creating local variables? - no
5. Calling other state-changing methods? - yes

# Function calls:
1. Why cannot pure methods call pure methods? Because a call to a pure method is regarded as a view action?


Why does “assert” consume all the gas budget???? So, it becomes hard to code as we need to decide on gas budget first? Revert or require is much cheaper.
Conversion between memory and storage objects:
Interestingly the objects are copied, not references. So, updating an object in memory does not reflect changes in the storage.
Gas cost? - if only the memory object is changed, no cost. If we create memory objects, it will incur a little bit of cost.
First time function calls incur most gas cost!
Sometimes, it’s better to create variables referencing to expressions of storage objects. Because the evaluation cost of the expression is high, and multiple evaluation incurs more gas cost. 
Which is less costly:
Updating properties of a struct separately?
Create a new object with all updates and copy to storage?
