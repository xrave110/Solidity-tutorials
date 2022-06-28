pragma solidity ^0.4.5;

contract FundRaiser {
    mapping(address => uint256) public balances;

    function contribute() payable public {
        balances[msg.sender] += msg.value;
    }

    function getBalances()public returns(uint256){
        return address(this).balance;
    }

    function withdraw() public{
        if (balances[msg.sender] == 0) {
            throw;
        }
        if (msg.sender.call.value(balances[msg.sender])()) {
            //re-entrancy can happen here!
            balances[msg.sender] = 0;
        } else {
            throw;
        }
    }
}