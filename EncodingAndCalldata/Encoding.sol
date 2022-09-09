// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Encoding{

    function encodeNumber() public pure returns (bytes memory){
        bytes memory number = abi.encode(1);
        return number;
    }

    function encodeString() public pure returns (bytes memory){
        bytes memory someString = abi.encode("some string");
        return someString;
    }

    function encodePackedString() public pure returns (bytes memory){
        bytes memory someString = abi.encodePacked("some string"); // compress 
        return someString;
    }

    function encodeBytesString() public pure returns (bytes memory){
        bytes memory someString = bytes("some string"); // almost identical with  encodePackedString
        return someString;
    }

    function decodeString() public pure returns(string memory){
        string memory someString = abi.decode(encodeString(), (string));
        return someString;
    }

    function multiEncode() public pure returns(bytes memory){
        bytes memory someString = abi.encode("some string", "it's bigger!");
        return someString;
    } 

    function multiDecode() public pure returns(string memory, string memory){
        (string memory someString, string memory someOtherString) = abi.decode(multiEncode(), (string, string));
        return (someString, someOtherString);
    }

    function multiEncodePacked() public pure returns(bytes memory){
        bytes memory someString = abi.encodePacked("some string", "it's bigger!");
        return someString;
    } 

    function multiDecodePacked() public pure returns(string memory) {

        //(string memory someString, string memory someOtherString) = abi.decode(multiEncodePacked(), (string, string)); // Wil not work
        //return (someString, someOtherString);
        string memory someString = string(multiEncodePacked());
        return someString;
    }

}
