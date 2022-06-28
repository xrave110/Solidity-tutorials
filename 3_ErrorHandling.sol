pragma solidity 0.7.5;

contract Bank{
    
    mapping(address => uint) balance;
    address owner;
    
    constructor(){
        owner = msg.sender;
    }
    
    // modifiers allows to avoid code repetitions
    modifier onlyOnwer{
        require(msg.sender == owner, "You do not have permision to do this action");
        _; // it means - run the function (underscore is replaced by the function in EVM)
    }
    
    modifier costs (uint price){
        require(msg.value >= price);
        _;
    }
    
    
    function addBalance(uint _toAdd) public onlyOnwer returns (uint){

        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
        
    }
    
    function getBalance(address _address) public view returns (uint){
        return balance[_address];
    }
    
    function transfer(address recipent, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipent, "Do not transfer money to yourself");
        
        uint previousSenderBalance = balance[msg.sender];
        //transfering
        _transfer(msg.sender, recipent, amount);
        
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