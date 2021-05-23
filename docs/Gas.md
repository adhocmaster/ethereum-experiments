# Gas cost items
1. Modifying states
2. cost of different commands
3. cost of copying objects
4. cost of expression evaluation
5. cost of creating objects
6. First time function calls

# Function calls
First time function calls incur most gas cost!

# Expression evaluation
Sometimes, it’s better to create variables referencing to expressions of storage objects. Because the evaluation cost of the expression is high, and multiple evaluation incurs more gas cost. 
## Which is less costly:
1. Updating properties of a struct separately?
2. Create a new object with all updates and copy to storage?


## Conversion between memory and storage objects:
Interestingly the objects are copied, not references. So, updating an object in memory does not reflect changes in the storage.
Gas cost? - if only the memory object is changed, no cost. If we create memory objects, it will incur a little bit of cost.

## Assert, revert, require 
Why does “assert” consume all the gas budget???? So, it becomes hard to code as we need to decide on gas budget first? Revert or require is much cheaper.
