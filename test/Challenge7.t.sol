// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Force} from "src/Challenge7-force/Puzzle.sol";

contract Challenge7Test is Test {
    Force public puzzle;
    address player = makeAddr("player");

    /// @dev Setup the testing environment.
    function setUp() public {
        puzzle = new Force();
        vm.deal(player, 1);
    }

    function testSimpleHack() public {
        assertEq(address(puzzle).balance, 0);
        vm.startPrank(player,player);
        KBoom e = new KBoom();
        e.boom{value: 1}(address(puzzle));
        vm.stopPrank();
        assertGt(address(puzzle).balance, 0);
    }


    function testHackHuff() public {
        assertEq(address(puzzle).balance, 0);
        vm.startPrank(player,player);
        KBoom e = KBoom(HuffDeployer.config()
            .deploy("Challenge7-force/Hack"));
        e.boom{value: 1}(address(puzzle));
        vm.stopPrank();
        assertGt(address(puzzle).balance, 0);
    }
    
}

contract KBoom {
    function boom(address puzzle) external payable  {
        selfdestruct(payable(puzzle));
    }
}