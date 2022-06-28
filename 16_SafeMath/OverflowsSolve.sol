pragma solidity 0.8.0;

import "./SafeMath";

contract OverflowSolve {
    
    using SafeMath for uint256;  // use safe math for specified type (there is no safemath for ex. uint8)
    
    function add(uint256 n) public returns(uint256){
        n = n.add(1);
        return n;
    } 
    
    function substract(uint256 n) public returns(uint256){
        n = n.sub(1);
        return n;
    }
    
}