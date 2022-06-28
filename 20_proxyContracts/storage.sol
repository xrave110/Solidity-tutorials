//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract Storage {
    uint256 main_storage;

    function get_storage() internal view returns (uint256) {
        return main_storage;
    }

    function set_storage(uint256 _value) internal {
        main_storage = _value;
    }
}