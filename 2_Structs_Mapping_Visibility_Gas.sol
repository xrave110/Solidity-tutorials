pragma solidity 0.7.5;

contract lesson2{
    //1 
    struct Person {
        uint age;
        string name;
    }
    
    //2 
    mapping(address => uint) balance;
    mapping(address => uint) test;
    
    
    //3 
    
    //1 
    
    Person[] people;
    
    function addPerson(uint _age, string memory _name) public {
        Person memory newPerson = Person(_age, _name); // creating of the instance of the array
        people.push(newPerson);
    }
    
    function getPerson(uint _index) public view returns (uint, string memory){
        Person memory personToReturn = people[_index];
        return (personToReturn.age, personToReturn.name);
    }
    
    //2 
    function addBalance(uint _toAdd) public returns (uint){
        
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
        
    }
    
    function getBalance(address _address) public view returns (uint){
        return balance[_address];
    }
    
    //3 
    function transfer(address receipent, uint amount) public {
        //Check if the sender has enaugh money to send
        
        //transfering
        _transfer(msg.sender, receipent, amount);
        
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