//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./storage.sol";

contract ProxyFunc is Storage {
    /* 
    A calls B, sends 100 wei
            B calls C, sends 50 wei
    A --> B --> C
                msg.sender = B
                msg.value = 50
                execute code on C's state variables
                use ETH in C

    A calls B, sends 100 wei
            B delegatecall C
    A --> B --> C
                msg.sender = A
                msg.value = 100
                execute code on B's state variables
                use ETH in B
    */
    address public currentAddress;

    constructor(address _currentAddress) {
        currentAddress = _currentAddress;
    }

    function upgrade(address _currentAddress) public {
        currentAddress = _currentAddress;
    }

    function get_func_proxy_storage() public returns (bool, bytes memory) {
        (bool res, bytes memory data) = currentAddress.delegatecall(
            abi.encodeWithSignature(("get_func_storage()"))
        );
        return (res, data);
    }

    function set_func_proxy_storage(uint256 _value)
        public
        returns (bool, bytes memory)
    {
        (bool res, bytes memory data) = currentAddress.delegatecall(
            abi.encodeWithSignature(
                ("set_func_storage(uint256)"),
                _value
            )
        );
        return (res, data);
    }
}