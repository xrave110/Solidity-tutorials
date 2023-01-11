// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ReceiveEther {
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */
    event Log(string message);
    event Gas(uint gas);
    event Received(address caller, uint amount, string message);
    uint256 public cntr;
    // Function to receive Ether. msg.data must be empty
    receive() external payable {
        // send / transfer (forwards 2300 gas to this fallback function)
        // call (forwards all of the gas)
        emit Log("I am in receive function!");
        //To much gas is required to suceed with send and transfer
        //emit Gas(gasleft());
        //emit Received(msg.sender, msg.value, "");
    }

    // Fallback function is called when msg.data is not empty
    fallback() external payable {
        emit Log("I am in fallback function!");
        emit Gas(gasleft());
        emit Received(msg.sender, msg.value, "");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function foo(string memory _message, uint _x) public payable returns (uint) {
        emit Received(msg.sender, msg.value, _message);
        cntr += _x;
        return _x + 1;
    }
}

contract SendEther {
    event Response(bool success, bytes data);

    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCallReceive(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
    function sendViaCallFallback(address payable _to) public payable returns(bytes memory){
        // Call returns a boolean value indicating success or failure.
        
        (bool sent, bytes memory data) = _to.call{value: msg.value}(bytes("Not empty"));
        require(sent, "Failed to send Ether");
        return data;
    }

    // Let's imagine that contract B does not have the source code for
    // contract A, but we do know the address of A and the function to call.
    function testCallFoo(address payable _addr) public payable {
        // You can send ether and specify a custom gas amount
        (bool success, bytes memory data) = _addr.call{value: msg.value, gas: 5000}(
            abi.encodeWithSelector(getSelectorOne(), "call foo", 123)
        );

        emit Response(success, data);
    }

    function getSelectorOne() public pure returns(bytes4 selector){
        selector = bytes4(keccak256(bytes("foo(string,uint256)")));
    }

    // Calling a function that does not exist triggers the fallback function.
    function testCallDoesNotExist(address _addr) public {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("doesNotExist()")
        );

        emit Response(success, data);
    }

}