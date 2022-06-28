pragma solidity 0.7.5;

contract C {
    
    uint [] storageArray; // storageArray
    //Assign by copy
    //Assign by reference
    
    // storage -> memory = copy
    // memory -> storage = copy
    
    // memory -> memory = reference
    // storage -> local storage = reference
    
    
    function f(uint[] memory memoryArray) public {
        storageArray = memoryArray; //copy memoryArray to storageArray
        storageArray.push(4); //[4]
        
        uint[] storage pointerArray = storageArray; //pointerArray => storageArray
        memoryArray = storageArray; //copy 
        pointerArray.push(7); //storageArray [4,7] memoryArray [4]
        
        uint[] memory memoryArray2 = memoryArray; // memoryArray2 => memoryArray
        
    }
    
}