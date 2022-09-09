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
    // Function to receive Ether. msg.data must be empty
    receive() external payable {
        emit Log("I am in receive function!");
    }

    // Fallback function is called when msg.data is not empty
    fallback() external payable {
        emit Log("I am in fallback function!");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
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


}