//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract CombiningStrings{

    function combineStrings(string memory text1, string memory text2) public pure returns(string memory){
        return string(abi.encodePacked(text1, text2));
    }

    //New version of solidity
    function combineStringsNew(string memory text1, string memory text2) public pure returns(string memory){
        return string.concat(text1, text2);
    }
    
}