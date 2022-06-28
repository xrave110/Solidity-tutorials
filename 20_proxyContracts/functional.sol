//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./storage.sol";

contract Functional is Storage {
    function get_func_storage() public view returns (uint256) {
        return Storage.get_storage();
    }

    function set_func_storage(uint256 _value) public {
        Storage.set_storage(_value);
    }
}
