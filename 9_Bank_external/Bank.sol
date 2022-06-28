pragma solidity 0.7.5;

import "./Ownable.sol";

interface GovernanceInterface{
    function addTransaction(address _from, address _to, uint _amount) external payable;    
}

contract Bank is Ownable{
    
    mapping(address => uint) balance;

    GovernanceInterface governanceInstance = GovernanceInterface(0xd9145CCE52D386f254917e481eB44e9943F39138);

    event depositDone(uint amount, address indexed depositedTo); //indexed (used for search and query)
    
    modifier costs (uint price){
        require(msg.value >= price);
        _;
    }
    
    
    function deposit() public payable returns (uint){ //paybale allows to use msg.value

        balance[msg.sender] += msg.value;
        emit depositDone(msg.value, msg.sender);
        return balance[msg.sender];
        
    }
    
    function withdraw(uint amount) public returns (uint){
        //msg.sender is a payable address
        /* 
        address payable toSend = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        toSend.transfer(amount); */
        require(balance[msg.sender] >= amount, "You do not have enough funds");
        balance[msg.sender] -= amount;
        msg.sender.transfer(amount); // the safest way to withdraw becaouse of built error handlings (revert commend as for required)
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint){
        return balance[msg.sender];
    }
    
    function transfer(address recipent, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipent, "Do not transfer money to yourself");
        
        uint previousSenderBalance = balance[msg.sender];
        //transfering
        _transfer(msg.sender, recipent, amount);
        
        governanceInstance.addTransaction{value: 1 ether}(msg.sender, recipent, amount);
        
        assert(balance[msg.sender] == previousSenderBalance - amount); // this should be always true (invariant condition)
        
        //Raise the event 
        
    }
    
    function _transfer(address _from, address _to, uint _amount) private {
        //Check if the sender has enaugh money to send
        
        //transfering
        balance[_from] -= _amount;
        balance[_to] += _amount;
        
        //Raise the event 
    }
}