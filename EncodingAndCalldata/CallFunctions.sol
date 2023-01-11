//SPDX-License-Identifier: MIT
pragma solidity  ^0.8.8;

 

/** In order to call a function using only data field of the call, there is need to encode down to binary level following strings:
- function name
- the params of the function
*/

/* Contract assigns each function by "function selector" -> the first 4 bytes of the function signature. 
The "function signature" is a string that defines the function name & parameters.
Function selector example:
0xA3B5C6FF
Function signature example:
"transfer(address,uint256)"
*/

contract CallFunction {
    address public s_someAddress;
    uint256 public s_amount;

    event Log(string message);

    function transfer(address someAddress, uint256 amount) public {
        s_someAddress = someAddress;
        s_amount = amount;
    }

    function getSelectorOne() public pure returns(bytes4 selector){
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }

    function getSelectorTwo() public view returns (bytes4 selector) {
        bytes memory functionCallData = abi.encodeWithSignature(
            "transfer(address,uint256)",
            address(this),
            123
        );
        selector = bytes4(
            bytes.concat(
                functionCallData[0],
                functionCallData[1],
                functionCallData[2],
                functionCallData[3]
            )
        );
    }

    function getDataToCallTransferTwo() public view returns (bytes memory ) {
        bytes memory functionCallData = abi.encodeWithSignature(
            "transfer(address,uint256)",
            address(this),
            123
        );
        return functionCallData;
    }

    function getDataToCallTransfer(address someAddress, uint256 amount) public pure returns(bytes memory){
        //this returned bytes can be added to the data transfer in order to call function
        return abi.encodeWithSelector(getSelectorOne(), someAddress, amount);
    }

    function callTransfer(address someAddress, uint256 amount) public returns(bool){
        (bool success, bytes memory func) = address(this).call(getDataToCallTransfer(someAddress, amount));
        emit Log(string(func));
        return success;
        
    }

}

contract CallTransferFunction {
    address public s_contractAddressToCall;

    constructor(address contractAddressToCall){
        s_contractAddressToCall = contractAddressToCall;
    }

    function callTransferFunctionDirectly(address someAddress, uint256 amount) public returns(bytes4, bool){
        (bool success, bytes memory returnData) = s_contractAddressToCall.call(abi.encodeWithSignature("transfer(address,uint256)", someAddress, amount));
        return (bytes4(returnData), success);
    }

    function callTransferFunctionDirectlyTwo(bytes calldata encodedFunc) public returns(bytes4, bool){
        (bool success, bytes memory returnData) = s_contractAddressToCall.call(encodedFunc);
        return (bytes4(returnData), success);
    }
}



