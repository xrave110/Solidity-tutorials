pragma solidity 0.8.0;

//CODING GOOD PRACTISE (PATTERN) - CHECKS, EFECTS (CHANGING SMART CONTRACT STATE), INTERACTIONS

contract test {
    
    //send and transfer take only  certain amount of gas stipend (it is done in order to prevent reentrance attack)
    //but the gas amount of specific operation can vary in future time)
    
    mapping(address=>uint) balance;
    
    function withdraw() public {
        require(balance[msg.sender] > 0); //CHECKS
        uint toTransfer = balance[msg.sender];
        balance[msg.sender] = 0; // EFECTS
        //bool success = msg.sender.send(toTransfer); //INTERACTIONS  (obsolete)
        (bool success, ) = msg.sender.call{value: toTransfer}(""); //INTERACTIONS
        if(!success) {
            balance[msg.sender] = toTransfer;
        }
    }
    
}