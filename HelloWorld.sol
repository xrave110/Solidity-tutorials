pragma solidity 0.7.5;

contract HelloWorld {
    //1 
    string message;
    
    //2
    int number;
    
    //3
    int[] numbers; // dynamic array
    int[5] numbers1 = [1,2,3,4,5];
    
    constructor(string memory _message) {
        message = _message;
    }
    //view - means that the function only reads some variable from outside of the function without modifying it
    function hello() public view returns(string memory){
        return message;
    }
    //pure - means that the function is not interacting with anything outside the function
    function hellobasic() public pure returns(string memory){
        return "Hello World";
    }
    
    function getNumber() public view returns(int){
        return number;
    }
    
    function setNumber(int _number) public {
        number = _number;
    }
    
    
    function setNumberFromArr(int _number) public{
        numbers.push(_number);
    }
    
    function getNumberFromArr(uint _index) public view returns(int){
        return numbers[_index];
    }
    
    function getAllNumbersFromArr() public view returns(int[] memory){
        return numbers;
    }
    
}