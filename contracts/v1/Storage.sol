pragma solidity ^0.5.8;

contract Storage {
    uint public val;
    constructor(uint v) public {
        val = v;
    }
    function setValue(uint v) public {
        val = v;
    }
}
