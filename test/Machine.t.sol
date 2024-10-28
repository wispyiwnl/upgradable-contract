// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Calculator} from "../contracts/v1/Calculator.sol";
import {Storage} from "../contracts/v1/Storage.sol";
import {Machine} from "../contracts/v1/Machine.sol";

contract MachineTest is Test {
    Machine public machine;
    Storage public storageContract;
    Calculator public calculator;

    address public EOA = address(0x55555);
    uint256 public a = 1;
    uint256 public b = 2;

    function setUp() public {
        machine = new Machine(storageContract);
        storageContract = new Storage(0);
        calculator = new Calculator();
    }

    function test_addValuesWithCall() public {
        machine.addValuesWithCall(address(calculator), a, b);

        assertEq(calculator.user(), address(machine));
        assertEq(calculator.calculateResult(), 3);

        assertEq(machine.calculateResult(), 0);
        assertEq(machine.user(), address(0));
    }

    function test_addValuesWithDelegateCall() public {
        vm.startPrank(EOA);
        machine.addValuesWithDelegateCall(address(calculator), a, b);

        assertEq(calculator.user(), address(0));
        assertEq(calculator.calculateResult(), 0);

        assertEq(machine.calculateResult(), 3);
        assertEq(machine.user(), address(EOA));
        vm.stopPrank();
    }
}
