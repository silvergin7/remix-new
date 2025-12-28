// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

library MathLibrary {
    function _add(uint a, uint b) internal pure returns(uint) {
        return a + b;
    }
    
    function _subtract(uint a, uint b) internal pure returns(uint) {
        return a - b;
    }

    function _multiply(uint a, uint b) internal pure returns(uint) {
        return a * b;
    }
}

contract Calculator {
    using MathLibrary for uint;

    function add(uint a, uint b) public pure returns(uint) {
       // return MathLibrary._add(a, b);
       return a._add(b);
    }

     function subtract(uint a, uint b) public pure returns(uint) {
       // return MathLibrary._subtract(a, b);
       return a._subtract(b);
    }

     function multiply(uint a, uint b) public pure returns(uint) {
       // return MathLibrary._multiply(a, b);
       return a._multiply(b);
    }
}