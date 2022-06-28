pragma solidity 0.7.5;

contract DataLocation {
    
    //storage - persistent data, overtime (non volatile memory) ex. state variables
    
    //memory - temporary data storage, used in functions
    
    //calldata - used mainly for gas optimalization, similar to memory but READ-ONLY
    
    //state variables
    uint data = 123; // stored in storage
    string lastText;
    
    
    function getString(string memory text) public returns(string memory){
        lastText = text;
        return text;
    }
    
}