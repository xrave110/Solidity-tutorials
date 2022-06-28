pragma solidity 0.8.0;

contract attack {
    function start() public {
        //deposit funcds
    }
    
    //calls with no data +  value
    receive() external payable {
        //new call to withdraw
    }
    
    //When no other function matches
    fallback() external payable{
        
    }
}