pragma solidity 0.7.5;

contract Ownable {
    
    address payable public owner; // public in the parent for any state variable is public also in the child (will be appeared in remix)
    
    modifier onlyOnwer{
        require(msg.sender == owner, "You do not have permision to do this action");
        _; // it means - run the function (underscore is replaced by the function in EVM)
    }
    

    constructor(){
        owner = msg.sender;
    }
    
}