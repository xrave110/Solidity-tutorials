pragma solidity 0.7.5;
pragma abicoder v2;

contract Gastest {
    uint something;
    //calldata means that the variable is not in memory and it is just called (read from function call)
    function testExternal(uint[10] calldata numbers) external pure returns(uint) { //execution cost: (calldata) 23036 gas
        return numbers[0];
    }
    function testPublic(uint[10] memory numbers) public view returns(uint) { //execution cost: (memory) 25691 gas
        numbers[0] = something;
        return numbers[0];
    }
}